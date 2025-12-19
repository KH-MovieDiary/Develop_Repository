package com.kh.moviediary.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.moviediary.member.service.MemberService;
import com.kh.moviediary.member.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	//È¸ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½Ìµï¿½
	@RequestMapping("/enrollForm.me")
	public String enrollForm() {
		
		return "member/memberEnrollForm";
	}
	
	@ResponseBody
	@RequestMapping(value="idCheck.me", produces="text/html; charset=utf-8")
	public String idCheck(String inputId) {

		int count = service.idCheck(inputId);
	    
	    // ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½Óµï¿½ ï¿½ï¿½ï¿½Ú¿ï¿½ ï¿½ï¿½È¯
		if(count>0) {
			
			return "NNNNN";
		}else {
			
			return "NNNNY";
		}
	}
	
	@RequestMapping("/insert.me")
	public String insertMember(Member m, String emailId, String emailDomain, Model model, HttpSession session) {
	    
	    m.setEmail(emailId + "@" + emailDomain);
	    
	    //ºñ¹Ğ¹øÈ£ ¾ÏÈ£È­
	    String encPwd = bcrypt.encode(m.getUserPwd());
	    m.setUserPwd(encPwd);

	    int result = service.insertMember(m);
	    
	    if(result > 0) {
	        session.setAttribute("alertMsg", "¼º°øÀûÀ¸·Î È¸¿ø°¡ÀÔÀÌ ¿Ï·áµÇ¾ú½À´Ï´Ù.");
	        return "redirect:/"; 
	    } else {
	        model.addAttribute("errorMsg", "È¸¿ø°¡ÀÔ¿¡ ½ÇÆĞÇß½À´Ï´Ù.");
	        return "common/errorPage";
	    }
	}
	

}

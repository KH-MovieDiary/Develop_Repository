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
	
	//회원가입 페이지로 이동
	@RequestMapping("/enrollForm.me")
	public String enrollForm() {
		
		return "member/memberEnrollForm";
	}
	
	@ResponseBody
	@RequestMapping(value="idCheck.me", produces="text/html; charset=utf-8")
	public String idCheck(String inputId) {

		int count = service.idCheck(inputId);
	    
	    // 결과에 따라 약속된 문자열 반환
		if(count>0) {
			
			return "NNNNN";
		}else {
			
			return "NNNNY";
		}
	}
	
	@RequestMapping("/insert.me")
	public String insertMember(Member m, String emailId, String emailDomain, Model model, HttpSession session) {
	    
	    m.setEmail(emailId + "@" + emailDomain);
	    
	    //비밀번호 암호화
	    String encPwd = bcrypt.encode(m.getUserPwd());
	    m.setUserPwd(encPwd);

	    int result = service.insertMember(m);
	    
	    if(result > 0) {
	        session.setAttribute("alertMsg", "성공적으로 회원가입이 완료되었습니다.");
	        return "redirect:/"; 
	    } else {
	        model.addAttribute("errorMsg", "회원가입에 실패했습니다.");
	        return "common/errorPage";
	    }
	}
	

}

package com.kh.moviediary.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.moviediary.member.service.MemberService;
import com.kh.moviediary.member.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@RequestMapping("/enrollForm.me")
	public String enrollForm() {
		
		return "member/memberEnrollForm";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/idCheck.me", produces="text/html; charset=utf-8")
	public String idCheck(String inputId) {

		int count = service.idCheck(inputId);

		if(count>0) {
			
			return "NNNNN";
		}else {
			
			return "NNNNY";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="/nickCheck.me", produces="text/html; charset=utf-8")
	public String nickCheck(String nickName) {
		int count = service.nickCheck(nickName);
		
		if(count>0) {
			return "NNNNN";
		}else {
			return "NNNNY";
		}
	}
	
	
	@RequestMapping("/insert.me")
	public String insertMember(Member m, MultipartFile uploadFile, HttpSession session) {
	   
	    m.setUserPwd(bcrypt.encode(m.getUserPwd()));
	    
	    if(uploadFile!=null && !uploadFile.getOriginalFilename().equals("")) { 
		    
	    	String originName=uploadFile.getOriginalFilename();
		    String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		    int ranNum = (int)(Math.random()*90000+10000);
		    String ext = originName.substring(originName.lastIndexOf("."));
		    String changeName = currentTime+ranNum+ext;
		    String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		    
		    try {
				uploadFile.transferTo(new File(savePath+changeName));
				
				m.setPicture("resources/uploadFiles/" + changeName);
				System.out.println("사진 저장 성공");
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("사진 저장 실패");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }

	    int result = service.insertMember(m);
	    
	    if(result > 0) {
	        session.setAttribute("alertMsg", "회원가입성공");
	        return "redirect:/"; 
	    } else {
	        session.setAttribute("alertMsg", "회원가입실패");
	        return "common/errorPage";
	    }
	}
	
	
	

}

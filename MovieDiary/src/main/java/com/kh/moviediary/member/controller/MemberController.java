package com.kh.moviediary.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	
	//회원가입 페이지로 이동
	@RequestMapping("/enrollForm.me")
	public String enrollForm() {
		
		return "member/memberEnrollForm";
	}
	

}

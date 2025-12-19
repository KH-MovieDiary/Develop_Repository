package com.kh.moviediary.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.moviediary.member.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	//ȸ������ �������� �̵�
	@RequestMapping("/enrollForm.me")
	public String enrollForm() {
		
		return "member/memberEnrollForm";
	}
	
	@ResponseBody
	@RequestMapping(value="idCheck.me", produces="text/html; charset=utf-8")
	public String idCheck(String inputId) {

		int count = service.idCheck(inputId);
	    
	    // ����� ���� ��ӵ� ���ڿ� ��ȯ
		if(count>0) {
			
			return "NNNNN";
		}else {
			
			return "NNNNY";
		}
	}
	

}

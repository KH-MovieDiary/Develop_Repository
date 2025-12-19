package com.kh.moviediary.member.service;

import com.kh.moviediary.member.vo.Member;

public interface MemberService {

	int insertMember(Member m);

	//아이디 중복 확인
	int idCheck(String inputId);

}

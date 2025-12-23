package com.kh.moviediary.member.service;

import com.kh.moviediary.member.vo.Member;

public interface MemberService {

	int insertMember(Member m);

	int idCheck(String inputId);

	int nickCheck(String nickName);

	Member loginUser(Member m);

	int updateMember(Member m);

}

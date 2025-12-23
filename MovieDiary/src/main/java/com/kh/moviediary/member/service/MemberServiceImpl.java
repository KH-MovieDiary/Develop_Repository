package com.kh.moviediary.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.member.dao.MemberDao;
import com.kh.moviediary.member.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertMember(Member m) {
		return dao.insertMember(sqlSession, m);
	}

	@Override
	public int idCheck(String inputId) {
		return dao.idCheck(sqlSession, inputId);
	}

	@Override
	public int nickCheck(String nickName) {
		return dao.nickCheck(sqlSession, nickName);
	}

	@Override
	public Member loginUser(Member m) {
		Member loginUser = dao.loginUser(sqlSession, m);
		return loginUser;
	}

	@Override
	public int updateMember(Member m) {
		return dao.updateUser(sqlSession, m);
	}
	

}

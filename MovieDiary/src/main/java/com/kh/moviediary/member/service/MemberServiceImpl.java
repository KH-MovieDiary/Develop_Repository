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
		
		return 0;
	}

	@Override
	public int idCheck(String inputId) {
		return dao.idCheck(sqlSession, inputId);
	}
	

}

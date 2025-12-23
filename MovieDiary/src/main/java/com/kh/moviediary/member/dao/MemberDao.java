package com.kh.moviediary.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.member.vo.Member;

@Repository
public class MemberDao {

	public int idCheck(SqlSessionTemplate sqlSession, String inputId) {
		return sqlSession.selectOne("memberMapper.idCheck", inputId);
	}

	public int nickCheck(SqlSessionTemplate sqlSession, String nickName) {
		return sqlSession.selectOne("memberMapper.nickCheck", nickName);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember",m);
	}

	public Member loginUser(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginUser", m);
	}

	public int updateUser(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateUser",m);
	}

	public int deleteMember(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.update("memberMapper.deleteMember",userId);
	}

}

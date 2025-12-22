package com.kh.moviediary.review.dao;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.review.model.vo.Review;

@Repository
public class ReviewDao {

	public int reviewInsert(Review r, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("reviewMapper.reviewInsert", r);
	}

	public int increaseCount(int rno, SqlSessionTemplate sqlSession) {
		return sqlSession.update("reviewMapper.increaseCount",rno);
	}
	
	public Review reviewDetail(int rno, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reviewMapper.reviewDetail",rno);
	}
	
	public int reviewUpdate(Review r, SqlSessionTemplate sqlSession) {
		return sqlSession.update("reviewMapper.reviewUpdate",r);
	}

	public int reviewDelete(int rno, SqlSessionTemplate sqlSession) {
		return sqlSession.delete("reviewMapper.reviewDelete", rno);
	}

	

	


}

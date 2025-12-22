package com.kh.moviediary.reviewLike.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.reviewLike.model.vo.Reviewlike;

@Repository
public class ReviewlikeDao {
	
	public String reviewLike(Reviewlike rl, SqlSessionTemplate sqlSession) {

		return sqlSession.selectOne("reviewMapper.reviewLike", rl);
	}

	public int insertReviewLike(Reviewlike rl, SqlSessionTemplate sqlSession) {
		
		return sqlSession.insert("reviewMapper.likeInsert", rl);
	}

	public int updateReviewLike(Reviewlike rl, SqlSessionTemplate sqlSession) {
		
		return sqlSession.update("reviewMapper.likeUpdate", rl);
	}


}

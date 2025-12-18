package com.kh.moviediary.review.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.moviediary.review.model.vo.Review;

public class ReviewDao {

	public int reviewInsert(Review r, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("reviewMapper.reviewInsert", r);
	}


}

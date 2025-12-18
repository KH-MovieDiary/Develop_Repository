package com.kh.moviediary.review.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.review.model.vo.Review;

@Repository
public class ReviewDao {

	public int reviewInsert(Review r, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("reviewMapper.reviewInsert", r);
	}


}

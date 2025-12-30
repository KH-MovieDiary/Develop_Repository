package com.kh.moviediary.mainpage.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.review.model.vo.Review;

@Repository
public class MainPageDao {

	public List<Review> reviewGet(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("movieMapper.reviewGet");
	}

	public List<Review> reviewPopularTop5(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("movieMapper.reviewPopularTop5");
	}

}

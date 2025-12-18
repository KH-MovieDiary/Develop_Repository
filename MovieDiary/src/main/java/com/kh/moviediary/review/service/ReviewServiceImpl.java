package com.kh.moviediary.review.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.review.dao.ReviewDao;
import com.kh.moviediary.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int reviewInsert(Review r) {
		return dao.reviewInsert(r,sqlSession);
	}
	
	

}

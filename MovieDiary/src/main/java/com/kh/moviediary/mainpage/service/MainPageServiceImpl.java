package com.kh.moviediary.mainpage.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.mainpage.dao.MainPageDao;
import com.kh.moviediary.review.model.vo.Review;

@Service
public class MainPageServiceImpl implements MainPageService {

	@Autowired
	private MainPageDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<Review> reviewGet() {
		return dao.reviewGet(sqlSession);
	}

}

package com.kh.moviediary.reviewlist.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.common.vo.ReviewPageInfo;
import com.kh.moviediary.reviewlist.dao.ReviewListDao;
import com.kh.moviediary.reviewlist.vo.ReviewList;

@Service
public class ReviewListServiceImpl implements ReviewListService{
	
	@Autowired
	private ReviewListDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int listCount() {
		return dao.listcount(sqlSession);
	}

	@Override
	public ArrayList<ReviewList> reviewList(ReviewPageInfo pi) {
		return dao.reviewList(sqlSession, pi);
	}

	@Override
	public ArrayList<ReviewList> searchList(HashMap<String, String> map, ReviewPageInfo pi) {
		return dao.searchList(sqlSession, map, pi);
	}

	@Override
	public int searchListCount(HashMap<String, String> map) {
		return dao.searchListCount(sqlSession, map);
	}

}

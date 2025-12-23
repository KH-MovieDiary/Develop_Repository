package com.kh.moviediary.reviewcomment.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.reviewcomment.dao.ReviewCommentDao;
import com.kh.moviediary.reviewcomment.vo.ReviewComment;

@Service
public class ReviewCommentServiceImpl implements ReviewCommentService{

	@Autowired
	private ReviewCommentDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertReply(ReviewComment rc) {
		
		return dao.insertReply(sqlSession, rc);
	}

	@Override
	public List<ReviewComment> selectList(int reviewId) {
		return dao.selectList(sqlSession, reviewId);
	}

}

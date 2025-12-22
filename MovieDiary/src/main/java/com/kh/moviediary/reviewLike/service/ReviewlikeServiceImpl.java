package com.kh.moviediary.reviewLike.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.reviewLike.dao.ReviewlikeDao;
import com.kh.moviediary.reviewLike.model.vo.Reviewlike;

@Service
public class ReviewlikeServiceImpl implements ReviewlikeService{
	
	@Autowired 
	ReviewlikeDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int reviewLike(Reviewlike rl) {
		
		String likeYN = dao.reviewLike(rl, sqlSession);
		
		int result = 0;
		
		if(likeYN==null) {
			result = dao.insertReviewLike(rl,sqlSession);
		} else {
			result = dao.updateReviewLike(rl,sqlSession);
		}
		
		return result;
		
	}

	@Override
	public String selectLike(Reviewlike rl) {
		
		return dao.reviewLike(rl, sqlSession);
	}

}

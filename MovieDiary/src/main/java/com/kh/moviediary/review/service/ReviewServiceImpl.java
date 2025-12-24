package com.kh.moviediary.review.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.movie.vo.Movie;
import com.kh.moviediary.review.dao.ReviewDao;
import com.kh.moviediary.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	//리뷰등록
	@Override
	public int reviewInsert(Review r) {
		return dao.reviewInsert(r,sqlSession);
	}
	
	//리뷰조회수 증가
	@Override
	public int increaseCount(int rno) {
		return dao.increaseCount(rno,sqlSession);
	}

	//리뷰디테일
	@Override
	public Review reviewDetail(int rno) {
		return dao.reviewDetail(rno,sqlSession);
	}
	
	//리뷰업데이트
	@Override
	public int reviewUpdate(Review r) {
		return dao.reviewUpdate(r,sqlSession);
	}

	//리뷰삭제
	@Override
	public int reviewDelete(int rno) {
		return dao.reviewDelete(rno,sqlSession);
	}

	public int countByMovieId(int movieId) {

		return dao.countByMovieId(movieId,sqlSession);
	}

	public int insertMovie(Movie m) {
		
		return dao.insertMovie(m,sqlSession);
	}

	

	
	
	

}

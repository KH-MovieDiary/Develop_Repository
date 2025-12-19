package com.kh.moviediary.review.service;

import com.kh.moviediary.review.model.vo.Review;

public interface ReviewService {

	int reviewInsert(Review r);

	int increaseCount(int rno);
	
	Review reviewDetail(int rno);
	
	int reviewUpdate(Review r);

	int reviewDelete(int rno);

	

	
	
}

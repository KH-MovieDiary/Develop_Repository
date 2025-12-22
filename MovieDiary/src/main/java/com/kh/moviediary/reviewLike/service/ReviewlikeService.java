package com.kh.moviediary.reviewLike.service;

import com.kh.moviediary.reviewLike.model.vo.Reviewlike;

public interface ReviewlikeService {

	int reviewLike(Reviewlike rl);
	
	String selectLike(Reviewlike rl);

}

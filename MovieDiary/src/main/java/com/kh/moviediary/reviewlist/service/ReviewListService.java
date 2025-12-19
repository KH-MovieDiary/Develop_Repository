package com.kh.moviediary.reviewlist.service;

import java.util.ArrayList;

import com.kh.moviediary.common.vo.ReivewPageInfo;
import com.kh.moviediary.reviewlist.vo.ReviewList;

public interface ReviewListService {
	
	//게시글 수 조회
	int listCount();

	ArrayList<ReviewList> reviewList(ReivewPageInfo pi);

}

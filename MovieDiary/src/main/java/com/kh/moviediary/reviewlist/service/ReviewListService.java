package com.kh.moviediary.reviewlist.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.moviediary.common.vo.ReviewPageInfo;
import com.kh.moviediary.reviewlist.vo.ReviewList;

public interface ReviewListService {
	
	int listCount();

	ArrayList<ReviewList> reviewList(ReviewPageInfo pi, String sort);

	ArrayList<ReviewList> searchList(HashMap<String, String> map, ReviewPageInfo pi);

	int searchListCount(HashMap<String, String> map);

}

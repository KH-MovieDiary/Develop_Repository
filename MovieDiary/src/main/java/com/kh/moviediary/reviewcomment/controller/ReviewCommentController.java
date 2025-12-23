package com.kh.moviediary.reviewcomment.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.moviediary.reviewcomment.service.ReviewCommentService;
import com.kh.moviediary.reviewcomment.vo.ReviewComment;

@Controller
public class ReviewCommentController {

	@Autowired
	private ReviewCommentService service;
	
	
	@ResponseBody
	@RequestMapping("/insertReply.re")
	public int insertReply(ReviewComment rc) {

		System.out.println(rc);
		int result = service.insertReply(rc);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/selectList.re",produces="application/json;charset=UTF-8")
	public List<ReviewComment> selectList(int reviewId) {
		
		List<ReviewComment> list = service.selectList(reviewId);
		
		return list;
	}
	
}

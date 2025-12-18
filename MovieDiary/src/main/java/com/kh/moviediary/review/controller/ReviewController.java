package com.kh.moviediary.review.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.moviediary.review.model.vo.Review;
import com.kh.moviediary.review.service.ReviewService;

@Controller
public class ReviewController {
	
	@Autowired
	ReviewService service;

	@PostMapping("/insert.review")
	public String reviewInsert(Review r, HttpSession session) {
		
		int result = service.reviewInsert(r);
		
		return null;
	}
}

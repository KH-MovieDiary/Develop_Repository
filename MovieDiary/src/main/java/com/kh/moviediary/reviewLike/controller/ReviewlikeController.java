package com.kh.moviediary.reviewLike.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.moviediary.reviewLike.model.vo.Reviewlike;
import com.kh.moviediary.reviewLike.service.ReviewlikeService;

@Controller
public class ReviewlikeController {
	
	@Autowired 
	ReviewlikeService service;
	
	@ResponseBody
	@RequestMapping("/like.review")
	public int reviewLike(Reviewlike rl) {
		
		int result = service.reviewLike(rl);
		
		return result;
	}

	
}

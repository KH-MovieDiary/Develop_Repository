package com.kh.moviediary.review.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.moviediary.review.model.vo.Review;
import com.kh.moviediary.review.service.ReviewService;

@Controller
public class ReviewController {
	
	@Autowired
	ReviewService service;
	
	@GetMapping("/insert.review")
	public String reviewInsertForm() {
		
		return "review/reviewInsert";
	}
	
	@PostMapping("/insert.review")
	public String reviewInsert(Review r, HttpSession session) {
		
		int result = service.reviewInsert(r);
		
		if(result>0) {
			session.setAttribute("alertMsg","성공적으로 작성되었습니다!");
		} else {
			session.setAttribute("alertMsg", "감상문 등록에 실패하였습니다");
		}
		
		System.out.println(result);
		
		return "redirect:/reviewList.bo";
	}
}

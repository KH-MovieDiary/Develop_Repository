package com.kh.moviediary.reviewlist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ReviewListController {

	@RequestMapping("/reviewList.bo")
	public String commentList() {
		
		return "reviewList/reviewListView";
	}
}

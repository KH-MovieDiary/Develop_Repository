package com.kh.moviediary.comment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommentController {

	@RequestMapping("/commentList.bo")
	public String commentList() {
		
		return "comment/commentListView";
	}
}

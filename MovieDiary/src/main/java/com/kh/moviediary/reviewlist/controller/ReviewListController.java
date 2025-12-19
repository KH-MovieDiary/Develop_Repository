package com.kh.moviediary.reviewlist.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.moviediary.common.template.Pagination;
import com.kh.moviediary.common.vo.ReivewPageInfo;
import com.kh.moviediary.reviewlist.service.ReviewListService;
import com.kh.moviediary.reviewlist.vo.ReviewList;

@Controller
public class ReviewListController {
	
	@Autowired
	private ReviewListService service;

	@RequestMapping("/reviewList.bo")
	public String commentList(@RequestParam(value="page",defaultValue="1")
								int currentPage
							   ,Model model) {
		//페이징 처리
		int listCount = service.listCount();
		int pageLimit = 10;
		int boardLimit = 10;
		
		ReivewPageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		//감상평 정보 불러오기
		ArrayList<ReviewList> list = service.reviewList(pi);
		System.out.println(list.size());
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		
		return "reviewList/reviewListView";
	}
	
}

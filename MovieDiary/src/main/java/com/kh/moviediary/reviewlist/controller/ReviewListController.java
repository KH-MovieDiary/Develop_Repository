package com.kh.moviediary.reviewlist.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.moviediary.common.template.Pagination;
import com.kh.moviediary.common.vo.ReviewPageInfo;
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
		
		int listCount = service.listCount();
		int pageLimit = 10;
		int boardLimit = 10;
		
		ReviewPageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<ReviewList> list = service.reviewList(pi);
		System.out.println(list.size());
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		
		return "reviewList/reviewListView";
	}
	
	@RequestMapping("/searchList.bo")
	public String searchList(@RequestParam(value="page", defaultValue="1")
											int currentPage
										   ,String condition
										   ,String keyword
										   ,Model model) {
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int listCount = service.searchListCount(map);
		int pageLimit = 10;
		int boardLimit = 10;
		
		ReviewPageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
		
		ArrayList<ReviewList> searchList = service.searchList(map,pi);
		
		model.addAttribute("list", searchList);
		model.addAttribute("pi", pi);
		model.addAttribute("map",map);
		
		return "reviewList/reviewListView";
	}
}

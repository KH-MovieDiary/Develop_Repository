package com.kh.moviediary.review.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@RequestMapping("/detail.review")
	public String reviewDetail(@RequestParam(value="rno") int rno,Model model,HttpSession session,HttpServletRequest request) {
		
		int result = service.increaseCount(rno);
		
		if(result>0) {
			Review r = service.reviewDetail(rno);
			model.addAttribute("review", r);
			return "review/reviewDetail";
		} else {
			session.setAttribute("alertMsg", "상세보기를 실패하였습니다");
			return "redirect: " + request.getHeader("referer");
		}
	}
	
	@PostMapping("/updateForm.review")
	public String reviewUpdateForm(int rno,Model model) {
		Review r = service.reviewDetail(rno);
		model.addAttribute("review",r);
		return "review/reviewUpdate";
	}
	
	
	@RequestMapping("/update.review")
	public String reviewUpdate(Review r,HttpSession session) {
		
		int result = service.reviewUpdate(r);
		
		if(result>0) {
			session.setAttribute("alertMsg", "수정에 성공하셨습니다");
		} else {
			session.setAttribute("alertMsg", "수정에 실패하였습니다");
		}
		return "redirect:/detail.review?rno="+r.getReviewId();
	}
	
	@PostMapping("/delete.review")
	public String reviewDelete(int rno,HttpSession session) {
		
		int result = service.reviewDelete(rno);
		if(result>0) {
			session.setAttribute("alertMsg", "삭제에 성공하였습니다");
			return "redirect:/reviewList.bo";
		} else {
			session.setAttribute("alertMsg", "삭제에 실패하였습니다");
			return "redirect:/reviewList.bo";
		}
		
	}
}

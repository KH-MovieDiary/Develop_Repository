package com.kh.moviediary.comment.controller;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import com.kh.moviediary.comment.service.CommentService;
import com.kh.moviediary.comment.vo.MovieComment;
import com.kh.moviediary.member.vo.Member;

@RestController
public class CommentController {

    @Autowired
    private CommentService commentService;

    @ResponseBody
    @GetMapping(value="/comment/list.mo",produces="application/json;charset=UTF-8")
	public List<MovieComment> replyList(int movidId) {
			
			
			List<MovieComment> list = commentService.getCommentList(movidId);
			return list;
	}

    @ResponseBody
	@RequestMapping("/comment/insert.mo")
	public int insertReply(MovieComment mc) {
		
		int result = commentService.addComment(mc);
	
		return result;
	}
    
    @GetMapping("/comment/delete.mo")
    public String delete(int commentId, HttpSession session) {
        System.out.println("Delete컨트롤러 commentId=" + commentId);
        int result = commentService.deleteComment(commentId);
        if(result>0) {
        	return "redirect:/";
        }
        else {
        	System.out.println("삭제 실패..");
        	return "";
        }
    }


    
}

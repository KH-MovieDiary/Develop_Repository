package com.kh.moviediary.like.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kh.moviediary.like.service.CommentLikeService;
import com.kh.moviediary.member.vo.Member;

@RestController
public class CommentLikeController {

    @Autowired
    private CommentLikeService commentLikeService;

    @ResponseBody
    @GetMapping(value="/commentLike/status.mo", produces="text/plain;charset=UTF-8")
    public String status(int commentId, HttpSession session) {

        String userId = getLoginUserId(session);

        Map<String, Object> status = commentLikeService.getStatus(commentId, userId);

        String myChoice = status.get("myChoice") == null ? "" : status.get("myChoice").toString();

        int likeCount = status.get("LIKE_COUNT") == null
                ? 0
                : ((Number) status.get("LIKE_COUNT")).intValue();

        return myChoice + "," + likeCount;
    }

    @ResponseBody
    @PostMapping(value="/commentLike/toggle.mo", produces="text/plain;charset=UTF-8")
    public String toggle(int commentId, HttpSession session) {

        String userId = getLoginUserId(session);
        if (userId.isBlank()) {
            return "LOGIN";
        }

        Map<String, Object> status = commentLikeService.toggle(commentId, userId);

        String myChoice = status.get("myChoice") == null ? "" : status.get("myChoice").toString();

        int likeCount = status.get("LIKE_COUNT") == null
                ? 0
                : ((Number) status.get("LIKE_COUNT")).intValue();

        return myChoice + "," + likeCount;
    }

    private String getLoginUserId(HttpSession session) {
        Object obj = session.getAttribute("loginUser");
        if (obj instanceof Member) {
            Member m = (Member) obj;
            if (m.getUserId() != null) return m.getUserId();
        }
        return "";
    }
}

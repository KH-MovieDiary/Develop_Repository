package com.kh.moviediary.like.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kh.moviediary.like.service.MovieLikeService;
import com.kh.moviediary.member.vo.Member;

@RestController
public class MovieLikeController {

    @Autowired
    private MovieLikeService movieLikeService;

    
    //지금 이 영화의 좋아요/싫어요 총합 + 내가 뭘 눌렀는지”를 가져오는 API
    @ResponseBody
    @GetMapping(value="/like/status.mo", produces="text/plain;charset=UTF-8")
    public String likeStatus(int movieId, HttpSession session) {

        String userId = getLoginUserId(session); 

        Map<String, Object> status = movieLikeService.getStatus(movieId, userId);

        String myChoice = status.get("myChoice") == null ? "" : status.get("myChoice").toString();

        int likeCount = status.get("LIKE_COUNT") == null
                ? 0
                : ((Number) status.get("LIKE_COUNT")).intValue();

        int dislikeCount = status.get("DISLIKE_COUNT") == null
                ? 0
                : ((Number) status.get("DISLIKE_COUNT")).intValue();

        return myChoice + "," + likeCount + "," + dislikeCount;
    }

    
    //좋아요/싫어요 버튼 눌렀을 때 상태를 토글(추가/취소/변경)하고, 결과를 다시 돌려주는 API
    @ResponseBody
    @PostMapping(value="/like/toggle.mo", produces="text/plain;charset=UTF-8")
    public String likeToggle(int movieId, String action, HttpSession session) {

        String userId = getLoginUserId(session);
        if (userId.isBlank()) {
            return "LOGIN";
        }

        action = (action == null) ? "" : action.trim().toUpperCase();
        if (!action.equals("LIKE") && !action.equals("DISLIKE")) {
            return "BAD";
        }

        Map<String, Object> status = movieLikeService.toggle(movieId, userId, action);

        String myChoice = status.get("myChoice") == null ? "" : status.get("myChoice").toString();

        int likeCount = status.get("LIKE_COUNT") == null
                ? 0
                : ((Number) status.get("LIKE_COUNT")).intValue();

        int dislikeCount = status.get("DISLIKE_COUNT") == null
                ? 0
                : ((Number) status.get("DISLIKE_COUNT")).intValue();

        return myChoice + "," + likeCount + "," + dislikeCount;
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

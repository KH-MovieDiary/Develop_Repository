package com.kh.moviediary.comment.controller;

import java.util.HashMap;
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

    @GetMapping(value="/comment/list.mo", produces=MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> list(@RequestParam("movieId") int movieId) {
        Map<String, Object> res = new HashMap<>();
        try {
            List<MovieComment> list = commentService.getCommentList(movieId);
            res.put("ok", true);
            res.put("list", list);
        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", e.getMessage());
        }
        return res;
    }

    @PostMapping(value="/comment/insert.mo",
                 consumes=MediaType.APPLICATION_JSON_VALUE,
                 produces=MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> insert(@RequestBody Map<String, Object> body, HttpSession session) {
        Map<String, Object> res = new HashMap<>();

        try {
            Object movieIdObj = body.get("movieId");
            String content = body.get("content") == null ? "" : String.valueOf(body.get("content")).trim();

            if (movieIdObj == null) {
                res.put("ok", false);
                res.put("message", "movieId가 없습니다");
                return res;
            }

            int movieId = (movieIdObj instanceof Number)
                    ? ((Number) movieIdObj).intValue()
                    : Integer.parseInt(String.valueOf(movieIdObj));

            if (content.isBlank()) {
                res.put("ok", false);
                res.put("message", "내용을 입력하세요");
                return res;
            }

            String userId = "guest";

            Object loginUserObj = session.getAttribute("loginUser");
            if (loginUserObj instanceof Member) {
                Member m = (Member) loginUserObj;
                if (m.getUserId() != null && !m.getUserId().isBlank()) {
                    userId = m.getUserId();
                }
            }

            MovieComment c = MovieComment.builder()
                    .movieId(movieId)
                    .content(content)
                    .userId(userId)   
                    .build();

            int result = commentService.addComment(c);

            res.put("ok", result > 0);
            if (result <= 0) res.put("message", "등록 실패(영향받은 행이 0)");
        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", e.getClass().getSimpleName() + ": " + e.getMessage());
        }

        return res;
    }
}

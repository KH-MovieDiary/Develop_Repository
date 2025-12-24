package com.kh.moviediary.rating.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kh.moviediary.rating.service.RatingService;

@RestController
public class RatingController {

    @Autowired
    private RatingService ratingService;

    // 상태 조회: 평균/개수/내 점수
    // 응답 형식: "avg,count,myScore"  예) "4.2,15,5"
    @ResponseBody
    @GetMapping(value="/rating/status.mo", produces="text/plain;charset=UTF-8")
    public String status(int movieId, @RequestParam(required=false) String userId) {

        double avg = ratingService.getAvgScore(movieId);
        int count = ratingService.getRatingCount(movieId);

        int myScore = 0;
        if(userId != null && !userId.trim().isEmpty()) {
            myScore = ratingService.getMyScore(movieId, userId);
        }

        // 소수점 1자리
        double avg1 = Math.round(avg * 10.0) / 10.0;

        return avg1 + "," + count + "," + myScore;
    }

    // 별점 등록/수정(UPSERT)
    // 응답 형식: "avg,count,myScore"
    @ResponseBody
    @PostMapping(value="/rating/upsert.mo", produces="text/plain;charset=UTF-8")
    public String upsert(int movieId, String userId, int score) {

        if(userId == null || userId.trim().isEmpty()) {
            return "LOGIN";
        }
        if(score < 1 || score > 5) {
            return "BAD";
        }

        ratingService.upsertRating(movieId, userId, score);

        double avg = ratingService.getAvgScore(movieId);
        int count = ratingService.getRatingCount(movieId);
        int myScore = ratingService.getMyScore(movieId, userId);

        double avg1 = Math.round(avg * 10.0) / 10.0;
        return avg1 + "," + count + "," + myScore;
    }
}

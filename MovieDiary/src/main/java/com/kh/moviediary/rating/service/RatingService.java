package com.kh.moviediary.rating.service;

public interface RatingService {

    int upsertRating(int movieId, String userId, int score);

    double getAvgScore(int movieId);

    int getRatingCount(int movieId);

    Integer getMyScore(int movieId, String userId);
}

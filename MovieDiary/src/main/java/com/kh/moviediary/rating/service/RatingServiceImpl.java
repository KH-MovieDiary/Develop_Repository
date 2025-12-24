package com.kh.moviediary.rating.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.rating.dao.RatingDao;

@Service
public class RatingServiceImpl implements RatingService {

    @Autowired
    private RatingDao ratingDao;

    @Autowired
	private SqlSessionTemplate sqlSession;
    
    @Override
    public int upsertRating(int movieId, String userId, int score) {
        return ratingDao.upsertRating(sqlSession,movieId, userId, score);
    }

    @Override
    public double getAvgScore(int movieId) {
        Double v = ratingDao.selectAvgScore(sqlSession, movieId);
        if(v == null) return 0.0;
        return Math.round(v * 10.0) / 10.0;
    }

    @Override
    public int getRatingCount(int movieId) {
        Integer v = ratingDao.selectRatingCount(sqlSession, movieId);
        return (v == null) ? 0 : v;
    }

    @Override
    public Integer getMyScore(int movieId, String userId) {
        return ratingDao.selectMyScore(sqlSession, movieId, userId);
    }
}

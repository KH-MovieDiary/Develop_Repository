package com.kh.moviediary.rating.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RatingDao {

    public int upsertRating(SqlSessionTemplate sqlSession, int movieId, String userId, int score) {
        Map<String, Object> param = new HashMap<>();
        param.put("movieId", movieId);
        param.put("userId", userId);
        param.put("score", score);

        // mapper namespace: ratingMapper / id: upsertRating
        return sqlSession.update("movieMapper.upsertRating", param);
    }

    public Double selectAvgScore(SqlSessionTemplate sqlSession, int movieId) {
        // mapper id: selectAvgScore
        return sqlSession.selectOne("movieMapper.selectAvgScore", movieId);
    }

    public Integer selectRatingCount(SqlSessionTemplate sqlSession, int movieId) {
        // mapper id: selectRatingCount
        return sqlSession.selectOne("movieMapper.selectRatingCount", movieId);
    }

    public Integer selectMyScore(SqlSessionTemplate sqlSession, int movieId, String userId) {
        Map<String, Object> param = new HashMap<>();
        param.put("movieId", movieId);
        param.put("userId", userId);

        // mapper id: selectMyScore
        return sqlSession.selectOne("movieMapper.selectMyScore", param);
    }
}

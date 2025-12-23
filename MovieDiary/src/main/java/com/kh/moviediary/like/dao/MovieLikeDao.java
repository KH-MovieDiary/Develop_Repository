package com.kh.moviediary.like.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MovieLikeDao {

    public Map<String, Object> getStatus(SqlSessionTemplate sqlSession, int movieId, String userId) {

        Map<String, Object> param = new HashMap<>();
        param.put("movieId", movieId);
        param.put("userId", userId);

        String myChoice = sqlSession.selectOne("movieMapper.selectMyChoice", param);

        Map<String, Object> counts = sqlSession.selectOne("movieMapper.selectCounts", param);
        if (counts == null) counts = new HashMap<>();

        counts.put("myChoice", myChoice); // LIKE / DISLIKE / null
        return counts;
    }

    public Map<String, Object> toggle(SqlSessionTemplate sqlSession, int movieId, String userId, String action) {

        // action 값 무조건 'LIKE' 또는 'DISLIKE'로 정규화해서 체크제약조건 위반 방지
        String likeType = normalizeAction(action); // 'LIKE' or 'DISLIKE'

        Map<String, Object> param = new HashMap<>();
        param.put("movieId", movieId);
        param.put("userId", userId);

        String current = sqlSession.selectOne("movieMapper.selectMyChoice", param); // 현재 내 상태

        if (current == null) {
            // 최초 클릭 -> insert
            param.put("likeType", likeType);
            sqlSession.insert("movieMapper.insertLike", param);
        } else if (current.equals(likeType)) {
            // 같은 버튼 다시 누름 -> delete (취소)
            sqlSession.delete("movieMapper.deleteLike", param);
        } else {
            // LIKE <-> DISLIKE 변경 -> update
            param.put("likeType", likeType);
            sqlSession.update("movieMapper.updateLike", param);
        }

        // 변경 후 상태 + 카운트 반환
        return getStatus(sqlSession, movieId, userId);
    }

    private String normalizeAction(String action) {
        if (action == null) return "LIKE"; // 안전 기본값 (원하면 예외로 바꿔도 됨)

        String a = action.trim().toUpperCase();

        // 프론트가 "LIKE"/"DISLIKE" 말고 "L"/"D" 보내도 안전하게 처리
        if (a.equals("DISLIKE") || a.equals("D")) return "DISLIKE";
        return "LIKE";
    }
    
    
}

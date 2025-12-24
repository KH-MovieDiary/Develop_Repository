package com.kh.moviediary.like.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentLikeDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public boolean exists(int commentId, String userId) {
        Map<String, Object> param = new HashMap<>();
        param.put("commentId", commentId);
        param.put("userId", userId);
        Integer cnt = sqlSession.selectOne("movieMapper.exists", param);
        return cnt != null && cnt > 0;
    }

    public int countLikes(int commentId) {
        Integer cnt = sqlSession.selectOne("movieMapper.countLikes", commentId);
        return cnt == null ? 0 : cnt;
    }

    public int insertLike(int commentId, String userId) {
        Map<String, Object> param = new HashMap<>();
        param.put("commentId", commentId);
        param.put("userId", userId);
        return sqlSession.insert("movieMapper.commenInsertLike", param);
    }

    public int deleteLike(int commentId, String userId) {
        Map<String, Object> param = new HashMap<>();
        param.put("commentId", commentId);
        param.put("userId", userId);
        return sqlSession.delete("movieMapper.commentDeleteLike", param);
    }

    public int updateCommentLikeCount(int commentId, int likeCount) {
        Map<String, Object> param = new HashMap<>();
        param.put("commentId", commentId);
        param.put("likeCount", likeCount);
        return sqlSession.update("movieMapper.updateCommentLikeCount", param);
    }
}

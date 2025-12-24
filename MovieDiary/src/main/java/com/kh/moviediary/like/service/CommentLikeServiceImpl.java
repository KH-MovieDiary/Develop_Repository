package com.kh.moviediary.like.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.like.dao.CommentLikeDao;

@Service
public class CommentLikeServiceImpl implements CommentLikeService {

    @Autowired
    private CommentLikeDao commentLikeDao;

    @Override
    public Map<String, Object> getStatus(int commentId, String userId) {
        boolean liked = false;
        if (userId != null && !userId.isBlank()) {
            liked = commentLikeDao.exists(commentId, userId);
        }

        int likeCount = commentLikeDao.countLikes(commentId);

        Map<String, Object> res = new HashMap<>();
        res.put("myChoice", liked ? "LIKE" : "");
        res.put("LIKE_COUNT", likeCount);
        return res;
    }

    @Override
    public Map<String, Object> toggle(int commentId, String userId) {
        boolean liked = commentLikeDao.exists(commentId, userId);

        if (liked) {
            commentLikeDao.deleteLike(commentId, userId);
        } else {
            commentLikeDao.insertLike(commentId, userId);
        }

        int likeCount = commentLikeDao.countLikes(commentId);
        commentLikeDao.updateCommentLikeCount(commentId, likeCount);

        Map<String, Object> res = new HashMap<>();
        res.put("myChoice", liked ? "" : "LIKE");
        res.put("LIKE_COUNT", likeCount);
        return res;
    }
}

package com.kh.moviediary.like.service;

import java.util.Map;

public interface CommentLikeService {
    Map<String, Object> getStatus(int commentId, String userId);
    Map<String, Object> toggle(int commentId, String userId);
}

package com.kh.moviediary.like.service;

import java.util.Map;

public interface MovieLikeService {

	Map<String, Object> getStatus(int movieId, String userId);

	Map<String, Object> toggle(int movieId, String userId, String action);

}

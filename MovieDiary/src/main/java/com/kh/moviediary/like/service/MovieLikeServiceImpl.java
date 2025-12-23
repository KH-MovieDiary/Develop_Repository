package com.kh.moviediary.like.service;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.like.dao.MovieLikeDao;

@Service
public class MovieLikeServiceImpl implements MovieLikeService{
	
	@Autowired
    private MovieLikeDao movieLikeDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Map<String, Object> getStatus(int movieId, String userId) {
		return movieLikeDao.getStatus(sqlSession, movieId, userId);
	}

	@Override
	public Map<String, Object> toggle(int movieId, String userId, String action) {
		return movieLikeDao.toggle(sqlSession,movieId,userId,action);
	}
}

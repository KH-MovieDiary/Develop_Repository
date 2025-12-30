package com.kh.moviediary.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.mypage.dao.MypageDao;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
    @Autowired
    private MypageDao mypageDao;

  
    @Override
    public List<Map<String, Object>> getWishList(String userId) {
        return mypageDao.selectWishListByUserId(sqlSession, userId);
    }
	
    @Override
	public List<Map<String, Object>> getMyReviewList(String userId) {
        return mypageDao.selectMyReviewListByUserId(sqlSession, userId);
    }
    
    @Override
    public List<Map<String, Object>> getMyCommentList(String userId, int limit) {
        Map<String, Object> param = new HashMap<>();
        param.put("userId", userId);
        param.put("limit", limit);
        return mypageDao.selectMyCommentList(sqlSession, param);
    }

    @Override
    public Map<String, Object> getCommentInfo(int commentId, String userId) {
        Map<String, Object> param = new HashMap<>();
        param.put("commentId", commentId);
        param.put("userId", userId);
        return mypageDao.selectCommentInfo(sqlSession, param);
    }

    @Override
    public int deleteMyComment(int commentId, String userId) {
        Map<String, Object> param = new HashMap<>();
        param.put("commentId", commentId);
        param.put("userId", userId);
        return mypageDao.deleteMyComment(sqlSession, param);
    }
}



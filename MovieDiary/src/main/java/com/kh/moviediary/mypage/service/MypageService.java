package com.kh.moviediary.mypage.service;


import java.util.List;
import java.util.Map;



public interface MypageService {
    List<Map<String, Object>> getWishList(String userId);
    
    //content3
    List<Map<String, Object>> getMyReviewList(String userId);
    
 // content4
    List<Map<String, Object>> getMyCommentList(String userId, int limit);
    Map<String, Object> getCommentInfo(int commentId, String userId);
    int deleteMyComment(int commentId, String userId);
}



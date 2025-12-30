package com.kh.moviediary.mypage.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDao {

 

	
	public List<Map<String, Object>> selectWishListByUserId(SqlSessionTemplate sqlSession, String userId) {
	    return sqlSession.selectList("mypageMapper.selectWishListByUserId", userId);
	}
    
 // ✅ content3
    public List<Map<String, Object>> selectMyReviewListByUserId(SqlSessionTemplate sqlSession, String userId) {
        return sqlSession.selectList("mypageMapper.selectMyReviewListByUserId", userId);
    }
    //content4
    public List<Map<String, Object>> selectMyCommentList(SqlSessionTemplate sqlSession, Map<String, Object> param){
        return sqlSession.selectList("mypageMapper.selectMyCommentList", param);
    }

    public Map<String, Object> selectCommentInfo(SqlSessionTemplate sqlSession, Map<String, Object> param){
        return sqlSession.selectOne("mypageMapper.selectCommentInfo", param);
    }

    public int deleteMyComment(SqlSessionTemplate sqlSession, Map<String, Object> param){
        return sqlSession.delete("mypageMapper.deleteMyComment", param);
    }
}




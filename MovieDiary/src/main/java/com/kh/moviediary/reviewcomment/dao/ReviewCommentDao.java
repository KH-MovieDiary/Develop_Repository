package com.kh.moviediary.reviewcomment.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.reviewcomment.vo.ReviewComment;

@Repository
public class ReviewCommentDao {

	public int insertReply(SqlSessionTemplate sqlSession, ReviewComment rc) {
		return sqlSession.insert("reviewMapper.insertReply",rc);
	}

	public List<ReviewComment> selectList(SqlSessionTemplate sqlSession, int reviewId) {
		return sqlSession.selectList("reviewMapper.selectList",reviewId);
	}

}

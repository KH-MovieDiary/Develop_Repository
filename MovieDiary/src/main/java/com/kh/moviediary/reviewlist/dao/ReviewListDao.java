package com.kh.moviediary.reviewlist.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.common.vo.ReivewPageInfo;
import com.kh.moviediary.reviewlist.vo.ReviewList;

@Repository
public class ReviewListDao {

	public int listcount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("reviewMapper.listCount");
	}

	public ArrayList<ReviewList> reviewList(SqlSessionTemplate sqlSession, ReivewPageInfo pi) {
		
		int limit = pi.getPageLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reviewMapper.reviewList",null,rowBounds);
	}

}

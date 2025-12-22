package com.kh.moviediary.comment.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.comment.vo.MovieComment;

@Repository
public class CommentDao {
	
	@Autowired
    private SqlSessionTemplate sqlSession;

    public List<MovieComment> selectCommentList(SqlSessionTemplate sqlSession, int movieId) {
        return sqlSession.selectList("movieMapper.selectCommentList", movieId);
    }

    public int insertComment(SqlSessionTemplate sqlSession, MovieComment c) {
        return sqlSession.insert("movieMapper.insertComment", c);
    }
}

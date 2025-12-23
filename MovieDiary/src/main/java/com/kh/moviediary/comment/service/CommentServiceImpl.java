package com.kh.moviediary.comment.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.comment.dao.CommentDao;
import com.kh.moviediary.comment.vo.MovieComment;

@Service
public class CommentServiceImpl implements CommentService {
	@Autowired
    private CommentDao commentDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

    @Override
    public List<MovieComment> getCommentList(int movieId) {
        return commentDao.selectCommentList(sqlSession, movieId);
    }
 
    @Override
    public int addComment(MovieComment c) {
        return commentDao.insertComment(sqlSession, c);
    }

	@Override
	public int deleteComment(int commentId) {
		return commentDao.deleteComment(sqlSession, commentId);
	}

}


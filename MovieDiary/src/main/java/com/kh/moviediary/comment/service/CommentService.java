package com.kh.moviediary.comment.service;

import java.util.List;

import com.kh.moviediary.comment.vo.MovieComment;

public interface CommentService {
    List<MovieComment> getCommentList(int movieId);
    int addComment(MovieComment c);
}

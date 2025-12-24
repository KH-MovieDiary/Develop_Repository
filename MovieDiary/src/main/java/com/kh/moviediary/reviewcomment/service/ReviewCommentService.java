package com.kh.moviediary.reviewcomment.service;

import java.util.List;

import com.kh.moviediary.reviewcomment.vo.ReviewComment;

public interface ReviewCommentService {

	int insertReply(ReviewComment rc);

	List<ReviewComment> selectList(int reviewId);

	int deleteReply(int rcId);

}

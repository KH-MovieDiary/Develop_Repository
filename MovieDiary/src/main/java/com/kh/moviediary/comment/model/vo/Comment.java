package com.kh.moviediary.comment.model.vo;

import java.sql.Date;

public class Comment {

	private String commentId; // COMMENT_ID VARCHAR2(100 BYTE)
	private String content; // CONTENT VARCHAR2(1000 BYTE)
	private Date createDate; // CREATE_DATE DATE
	private Date updateDate; // UPDATE_DATE DATE
	private int movieId; // MOVIE_ID NUMBER
	private String userId; // USER_ID VARCHAR2(100 BYTE)
	private int likeCount; // LIKE_COUNT NUMBER

}

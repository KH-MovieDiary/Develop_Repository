package com.kh.moviediary.mypage.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class MyLikeVo {

	private boolean like;     //LIKE_YN boolean	
	private String reviewId;  //REVIEW_ID VARCHAR2(100BYTE)
	private String MovieId;   //MOVIE_ID VARCHAR2(100BYTE)
	private String commentID; //COMMENT_ID VARCHAR2(100BYTE)
	private String userId;    //USER_ID(100BYTE)
	
	
	
	
}

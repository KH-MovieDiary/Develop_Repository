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
public class MyReviewVo {

	private String reviewId; //REVIEW_ID VARCHAR2(100BYTE)
	private String content;  //CONTENT VARCHAR2(2000BYTE)
	private Date createDate; //CREATE_DATE DATETIME
	private Date updateDate; //UPDATE_DATE DATE
	private int VC; 		 //VIEW_COUNT NUMBER
	private int LC; 		 //LIKE_COUNT NUMBER
	private String movieId;  //MOVIE_ID VARCHAR2(100BYTE)
	private String userId;   //USER_ID VARCHAR2(100BYTE)
	
}

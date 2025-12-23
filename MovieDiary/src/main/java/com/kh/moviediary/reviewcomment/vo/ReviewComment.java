package com.kh.moviediary.reviewcomment.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class ReviewComment {
	
	private int reviewCommentId;	//	REVIEW_COMMENT_ID	NUMBER
	private Date createDate;	//	CREATE_DATE	DATE
	private Date updateDate;	//	UPDATE_DATE	DATE
	private String content;	//	CONTENT	VARCHAR2(4000 BYTE)
	private int reviewId;	//	REVIEW_ID	NUMBER
	private String userId;	//	USER_ID	VARCHAR2(30 BYTE)
	private String nickname;

}

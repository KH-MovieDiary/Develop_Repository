package com.kh.moviediary.review.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {
	private int reviewId;			//	REVIEW_ID	NUMBER
	private String content;			//	CONTENT	VARCHAR2(1000 BYTE)
	private Date createDate;			//	CREATE_DATE	DATE
	private Date updateDate;			//	UPDATE_DATE	DATE
	private int viewCount;			//	VIEW_COUNT	NUMBER
	private int likeCount;			//	LIKE_COUNT	NUMBER
	private int movieId;			//	MOVIE_ID	NUMBER
	private String userId;			//	USER_ID	VARCHAR2(20 BYTE)
}

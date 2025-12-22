package com.kh.moviediary.reviewLike.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class Reviewlike {
	private int reviewId;		//	REVIEW_ID	NUMBER
	private String userId;		//	USER_ID	VARCHAR2(30 BYTE)
	private String likeYN;		//	LIKE_YN	VARCHAR2(3 BYTE)
}

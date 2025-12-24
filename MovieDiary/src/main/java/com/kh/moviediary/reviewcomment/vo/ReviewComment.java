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
	
	private int reviewCommentId;
	private Date createDate;
	private Date updateDate;
	private String content;	
	private int reviewId;	
	private String userId;	//댓글 작성자
	private String reviewUserId;  //감상평 작성자(공개 범위 설정용)
	private String nickname;
	private String privateYn;

}

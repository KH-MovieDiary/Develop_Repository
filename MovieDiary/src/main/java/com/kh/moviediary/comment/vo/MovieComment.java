package com.kh.moviediary.comment.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class MovieComment {
//	COMMENT_ID	NUMBER
//	CONTENT	VARCHAR2(1000 BYTE)
//	CREATE_DATE	DATE
//	UPDATE_DATE	DATE
//	MOVIE_ID	NUMBER
//	USER_ID	VARCHAR2(100 BYTE)
//	LIKE_COUNT	NUMBER
	
	private int commentId;        
    private String content;       
    private Date createDate;      
    private Date updateDate;      
    private int movieId;          
    private String userId;        
    private int likeCount;        
}

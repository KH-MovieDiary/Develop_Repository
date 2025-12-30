package com.kh.moviediary.like.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MovieLike {
	//VO복구 
    private int movieId;
    private String likeType;
    private String userId;
}

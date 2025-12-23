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
    private int movieId;
    private String userId;
    // DB 컬럼이 LIKE 라면 문자열 값: 'LIKE' or 'DISLIKE'
    private String likeType;
}

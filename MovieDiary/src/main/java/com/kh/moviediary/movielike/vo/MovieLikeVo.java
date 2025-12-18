package com.kh.moviediary.movielike.vo;

import com.kh.moviediary.movie.vo.Movie;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class MovieLikeVo {

//	MOVIE_ID	NUMBER
//	USER_ID	VARCHAR2(50 BYTE)
//	LIKE_TYPE	VARCHAR2(10 BYTE)
	private String movieId;
	private String userId;
	private String movieLike;
}

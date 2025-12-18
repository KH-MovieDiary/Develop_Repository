package com.kh.moviediary.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Movie {
//	MOVIE_ID	NUMBER
//	MOVIE_TITLE	VARCHAR2(200 BYTE)
//	CATEGORY	VARCHAR2(50 BYTE)
//	DIRECTOR	VARCHAR2(100 BYTE)
//	ADULT	VARCHAR2(5 BYTE)
//	RELEASE_DATE	DATE
//	POPULARITY	NUMBER
//	RATING_SCORE	NUMBER(2,1)
//	REVIEW_COUNT	NUMBER
//	LIKE_COUNT	NUMBER
//	DISLIKE_COUNT	NUMBER
	private int movieId;
	private String movieTitle;
	private String category;
	private String director;
	private String adult;
	private String releaseDate;
	private float popularity;
	private float ratingScore;
	private int likeCount;
	private int dislikeCount;
}

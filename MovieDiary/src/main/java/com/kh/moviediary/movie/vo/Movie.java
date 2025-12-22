package com.kh.moviediary.movie.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import oracle.sql.DATE;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@ToString
public class Movie {
    private int movieId;
    private String movieTitle;
    private String category;
    private String director;
    private String adult;
    private DATE releaseDate;

    // 저장용 문자열 날짜(yyyy-MM-dd)
    private String releaseDateStr;

    private float popularity;
    private float ratingScore;
    private int reviewCount;
    private int likeCount;
    private int dislikeCount;
    private String content;
}

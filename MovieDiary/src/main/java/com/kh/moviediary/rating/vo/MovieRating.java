package com.kh.moviediary.rating.vo;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MovieRating {
	private int ratingId;
    private int movieId;
    private String userId;
    private int score;         
    private Date createDate;
    private Date updateDate;
}

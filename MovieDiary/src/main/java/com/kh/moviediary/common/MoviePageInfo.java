package com.kh.moviediary.common;

import com.kh.moviediary.movie.vo.Movie;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MoviePageInfo {
	private int listCount; //총 게시글 수
	private int currentPage; //현재 페이지
	private int pageLimit; //페이징 바 최대 개수
	private int movieLimit; //한 페이지에 보여줄 감상평 수
	   
	private int maxPage; //마지막 페이지
	private int startPage; //페이징 바 시작 수
	private int endPage; //페이징 바 끝 수
	public MoviePageInfo(int listCount, int currentPage, int pageLimit, int movieLimit) {
        this.listCount = listCount;
        this.currentPage = currentPage;
        this.pageLimit = pageLimit;
        this.movieLimit = movieLimit;

        this.maxPage = (int) Math.ceil((double) listCount / movieLimit);
        this.startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
        this.endPage = startPage + pageLimit - 1;
        if (endPage > maxPage) endPage = maxPage;
    }
}

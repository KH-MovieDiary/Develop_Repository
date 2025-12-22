package com.kh.moviediary.common.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class ReivewPageInfo {
	
	private int listCount; //총 게시글 수
	private int currentPage; //현재 페이지
	private int pageLimit; //페이징 바 최대 개수
	private int boardLimit; //한 페이지에 보여줄 감상평 수
	
	private int maxPage; //마지막 페이지
	private int startPage; //페이징 바 시작 수
	private int endPage; //페이징 바 끝 수

}

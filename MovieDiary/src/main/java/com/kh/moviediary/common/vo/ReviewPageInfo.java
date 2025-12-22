package com.kh.moviediary.common.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class ReviewPageInfo {
	
	private int listCount; 
	private int currentPage; 
	private int pageLimit; 
	private int boardLimit; 
	
	private int maxPage; 
	private int startPage; 
	private int endPage; 

}

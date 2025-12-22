package com.kh.moviediary.common.template;

import com.kh.moviediary.common.vo.ReviewPageInfo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Pagination {
	
	
	public static ReviewPageInfo getPageInfo(int listCount,int currentPage
									  ,int boardLimit,int pageLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		int startPage = (currentPage-1)/pageLimit*pageLimit+1;
		int endPage = startPage+pageLimit-1;
		
		if(maxPage<endPage) {
			endPage = maxPage;
		}
		
		ReviewPageInfo pi = ReviewPageInfo.builder()
							  .listCount(listCount)
							  .currentPage(currentPage)
							  .pageLimit(pageLimit)
							  .boardLimit(boardLimit)
							  .maxPage(maxPage)
							  .startPage(startPage)
							  .endPage(endPage)
							  .build();
		    
		return pi;
	}
	
	
	
}

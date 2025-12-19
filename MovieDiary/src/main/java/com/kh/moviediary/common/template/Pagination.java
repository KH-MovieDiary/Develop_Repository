package com.kh.moviediary.common.template;

import com.kh.moviediary.common.vo.ReivewPageInfo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Pagination {
	
	
	public static ReivewPageInfo getPageInfo(int listCount,int currentPage
									  ,int boardLimit,int pageLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		int startPage = (currentPage-1)/pageLimit*pageLimit+1;
		int endPage = startPage+pageLimit-1;
		
		if(maxPage<endPage) {
			endPage = maxPage;
		}
		
		ReivewPageInfo pi = ReivewPageInfo.builder()
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

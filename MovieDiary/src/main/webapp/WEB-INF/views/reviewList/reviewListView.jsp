<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<style>
body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color:#f4f6f9;
      color: #333;
      margin: 0;
      padding: 0;
      }
      
.board-wrap {
    width: 70%;
    height: 100vh;
    margin: 0 auto;
    padding: 50px;
    border: 1px solid var;
    background: rgba(255,255,255,0.05);
    border-radius: 18px;
	box-shadow: 0 18px 60px rgba(0,0,0,0.1);
}
        
.board-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.custom-select {
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        color: #555;
        outline: none;
        cursor: pointer;
        transition: all 0.2s;
    }
.custom-select:hover, .custom-select:focus {
        border-color: #333;
    }
    
.board-top-left,
.board-top-right {
    display: flex;
    gap: 8px;
}

.board-table {
    width: 100%;
    border-collapse: collapse;
}

.board-table th {
    background-color: #f8f9fa;
    color: #555;
    font-weight: 600;
    text-align: center;
}

.board-table td {
    border-bottom: 1px solid #ddd;
    padding: 12px 8px;
    text-align: center;
}

.paging {
    margin-top: 20px;
    text-align: center;
    align-items: center;
}

.comment-area {
    margin-top: 40px;
}

.comment-input {
    display: flex;
    justify-content: center;   
    align-items: center;
    gap: 10px;                 
}

#commentContent {
    width: 80%;
    height: 40px;
    resize: none;
    padding: 8px;
    font-size: 14px;
}

.btn-comment {
    height: 40px;
    padding: 0 16px;
    font-size: 14px;
    cursor: pointer;
}

.board-table tbody tr {
    cursor: pointer;-
}

.board-table tbody tr:hover {
    background-color: #f5f5f5;
}

.paging{
	display: flex;
	justify-content: center;
}

    .search-area {
        display: flex;
        justify-content: center;
        align-items: center;  
        margin-top: 40px;
        gap: 8px;
        width: 100%;         
    }
    
    .search-area .custom-select {
        width: 100px;       
        height: 45px;        
        padding: 0 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        color: #555;
        outline: none;
        cursor: pointer;
    }

    .search-area input[type="text"] {
        width: 300px;      
        height: 45px;      
        padding: 0 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        outline: none;
        font-size: 14px;
        box-sizing: border-box; 
        transition: border-color 0.2s;
    }
    .search-area input[type="text"]:focus {
        border-color: #333;
    }

    .btn-search {
        height: 45px;    
        padding: 0 25px;    
        background-color: #333;
        color: white;           
        border: none;
        border-radius: 5px;
        font-size: 15px;   
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
    }
    .btn-search:hover {
        background-color: #111; 
    }
    
	#sortOption,
	#searchOption{
		cursor: pointer; 
	}
		
</style>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="board-wrap">

    <h3>감상평 게시판</h3>

    <div class="board-top">
	    <form id="listSort" action="${empty map ? 'reviewList.bo' : 'searchList.bo' }" method="get">
			
			<c:if test="${not empty map}">
				<input type="hidden" name="condition" value="${map.condition}">
				<input type="hidden" name="keyword" value="${map.keyword}">
			</c:if>
			
           <div class="board-top-left">
                <select name="sort" onchange="changeSort()" class="custom-select">
                    <option value="date" ${sort eq 'date' ? 'selected' : ''}>작성일순</option>
                    <option value="count" ${sort eq 'count' ? 'selected' : ''}>조회수순</option>
                    <option value="like" ${sort eq 'like' ? 'selected' : '' }>좋아요순</option>
                </select>
            </div>
            
	    </form>

        <div class="board-top-right">
			<a href="${pageContext.request.contextPath}/insert.review">감상평 작성</a>            
        </div>
    </div>
    
    <script>
    	function changeSort(){
    		document.getElementById("listSort").submit();
    	}
    </script>

    <table class="board-table">
        <thead>
            <tr>
                <th>글번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>좋아요</th>
                <th>작성일</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
					<c:when test="${empty list }">
						<tr>
							<td colspan='6'>조회된 게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list}" var="b">
							<tr>
								<td>${b.reviewId}</td>
			                    <td>${b.reviewTitle}</td>
			                    <td>${b.nickname}</td>
			                    <td>${b.viewCount}</td>
			                    <td>${b.likeCount}</td>
			                    <td>${b.createDate}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
        </tbody>
    </table>
    
    <!-- 상세 페이지 이동 -->
    <c:if test="${not empty list }">
    	<script>
    		$(function(){
    			
    			$(".board-table tbody tr").click(function(){
    				let rno = $(this).children().first().text()
    				location.href = "detail.review?rno="+rno;
    			})
    			
    		});
    	</script>
    </c:if>
    
    <c:url var="url" value="${empty map ? 'reviewList.bo' : 'searchList.bo' }">
    
    	<c:if test="${not empty map}">
			<c:param name="condition" value="${map.condition}"/>    
			<c:param name="keyword" value="${map.keyword}"/>    
    	</c:if>
    	
    	<c:param name="sort" value="${sort}"/>
    	<c:param name="page"></c:param>
    </c:url>
    
    
   <div class="paging">
        <ul class="pagination">
        
	        <c:choose>
		        <c:when test="${pi.currentPage eq 1}">
	    	    	<li class="page-item disabled" ><a class="page-link" href="#">이전</a></li>
	        	</c:when>
	        	<c:otherwise>
	        		<li class="page-item"><a class="page-link" href="${url}${pi.currentPage-1}">이전</a></li>
	        	</c:otherwise>
	        </c:choose>
        
        	<c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="i">
        		<li class="page-item ${i eq pi.currentPage ? 'disabled':''}"><a class="page-link" href="${url}${i}">${i}</a></li>
        	</c:forEach>
        	
        	<c:choose>
        		<c:when test="${pi.currentPage eq pi.maxPage}">
        			<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
        		</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="${url}${pi.currentPage+1}">다음</a></li>
				</c:otherwise>
        	</c:choose>
        </ul>
    </div>
		
	<form action="${contextRoot}/searchList.bo" method="get" class="search-area">
			<select name="condition" class="custom-select">
				<option value="title">제목</option>
				<option value="writer">작성자</option>
			</select>
		
	        <input type="text" name="keyword" value="${map.keyword}" placeholder="검색어 입력">
			<button type="submit" class="btn-search">검색</button>
	</form>	
</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
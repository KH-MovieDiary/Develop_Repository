<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

<style>
/* 전체 레이아웃 */
.board-wrap {
    width: 70%;
    height: 100vh;
    margin: 0 auto;
}

/* 상단 검색 영역 */
.board-top {
    display: flex;
    justify-content: space-between; /* 좌우로 벌림 */
    align-items: center;
    margin-bottom: 15px;
}

.board-top-left,
.board-top-right {
    display: flex;
    gap: 8px;
}

/* 테이블 */
.board-table {
    width: 100%;
    border-collapse: collapse;
}

.board-table th, .board-table td {
    border-bottom: 1px solid #ddd;
    padding: 12px 8px;
    text-align: center;
}

.board-table th {
    background-color: #f9f9f9;
    font-weight: bold;
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
</style>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="board-wrap">

    <h2>게시판</h2>

    <form action="${contextRoot}/board/list" method="get">
        <div class="board-top">

           <!-- 왼쪽: 정렬 -->
            <div class="board-top-left">
                <select name="sort">
                    <option value="date">작성일순</option>
                    <option value="count">조회수순</option>
                </select>
            </div>

            <!-- 오른쪽: 검색 -->
            <div class="board-top-right">
				<a href="${pageContext.request.contextPath}/insert.review">감상평 작성</a>            
            </div>
        </div>
    </form>

    <!-- 🔹 게시글 테이블 -->
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
			                    <td>${b.userId}</td>
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
    
    
    <div class="paging">
        <ul class="pagination">
        	<li class="page-item"><a class="page-link">이전</a></li>
        
        	<c:forEach begin="1" end="10" var="i">
        		<li class="page-item"><a class="page-link">${i}</a></li>
        	</c:forEach>
        	
        	<li class="page-item"><a class="page-link">다음</a></li>
        </ul>
    </div>
			
		<select name="condition">
			<option value="title">제목</option>
			<option value="writer">작성자</option>
		</select>
	
		<!-- 검색어 -->
        <input type="text" name="keyword" placeholder="검색어 입력">
		<button type="submit">검색</button>
             

</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
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

/* 페이지네이션 */
.paging {
    margin-top: 20px;
    text-align: center;
}

.comment-area {
    margin-top: 40px;
}

/* textarea + 버튼 정렬 */
.comment-input {
    display: flex;
    justify-content: center;   /* 가운데 정렬 */
    align-items: center;
    gap: 10px;                 /* textarea와 버튼 사이 간격 */
}

/* textarea 크기 */
#commentContent {
    width: 80%;
    height: 40px;
    resize: none;
    padding: 8px;
    font-size: 14px;
}

/* 등록 버튼 */
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

    <!-- 🔹 검색 / 정렬 영역 (테이블 위, 오른쪽) -->
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
            <c:forEach var="b" items="">
                <tr>
                    <td></td>
                    <td>
                        <a href="">
                            
                        </a>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <c:if test="">
                           
                        </c:if>
                    </td>
                </tr>

            </c:forEach>
        </tbody>
    </table>
    
    <!-- 🔹 페이지네이션 -->
    <div class="paging">
        <a href="#">Previous</a>
        <a href="#">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>
        <a href="#">Next</a>
    </div>
			
		<select name="condition">
			<option value="title">제목</option>
			<option value="writer">작성자</option>
		</select>
	
		<!-- 검색어 -->
        <input type="text" name="keyword" placeholder="검색어 입력">
		<button type="submit">검색</button>
             
    <div class="comment-area">

    <h4>댓글 <span id="commentCount"></span></h4>

    <div class="comment-input">
        <textarea id="commentContent" placeholder="댓글을 입력하세요"></textarea>
        <button class="btn-comment" onclick="insertComment()">등록</button>
    </div>

    <div id="commentList"></div>

    </div>
</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
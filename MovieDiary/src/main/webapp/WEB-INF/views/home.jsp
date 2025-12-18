<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
    <title>Home</title>
</head>
<body>

<h1>
    movieDiary 페이지입니다.
</h1>

<p>The time on the server is ${serverTime}.</p>

<hr>

<!-- ✅ 영화 목록으로 이동 버튼 -->
<form action="${pageContext.request.contextPath}/movies" method="get">
    <button type="submit">🎬 영화 목록 보러 가기</button>
</form>

</body>
</html>

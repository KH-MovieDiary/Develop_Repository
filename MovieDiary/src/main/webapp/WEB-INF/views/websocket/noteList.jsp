<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 쪽지함</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fa; padding: 50px 0; }
    .list-container { max-width: 900px; margin: auto; background: #fff; padding: 40px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
    .list-header { border-bottom: 2px solid #f1f3f5; margin-bottom: 30px; padding-bottom: 10px; }
    .nav-tabs { border-none; margin-bottom: 20px; }
    .nav-link { border: none; color: #adb5bd; font-weight: 600; padding: 10px 20px; }
    .nav-link.active { color: #333 !important; border-bottom: 3px solid #333 !important; background: none !important; }
    .table { margin-top: 10px; }
    .table thead th { border-top: none; color: #888; font-weight: 500; font-size: 14px; }
    .table tbody td { vertical-align: middle; color: #444; font-size: 15px; border-bottom: 1px solid #f8f9fa; }
    .user-id { font-weight: 600; color: #212529; }
    .note-content { max-width: 400px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; cursor: pointer; }
    .note-content:hover { text-decoration: underline; color: #000; }
    .empty-msg { text-align: center; padding: 50px 0; color: #adb5bd; }
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<br>
<div class="list-container">
    <div class="list-header">
        <h3 class="font-weight-bold">✉️ 나의 쪽지함</h3>
    </div>

    <ul class="nav nav-tabs" id="noteTab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="received-tab" data-toggle="tab" href="#received" role="tab">받은 쪽지함</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="sent-tab" data-toggle="tab" href="#sent" role="tab">보낸 쪽지함</a>
        </li>
    </ul>

    <div class="tab-content" id="noteTabContent">
        <div class="tab-pane fade show active" id="received" role="tabpanel">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th width="20%">보낸 사람</th>
                        <th width="55%">내용</th>
                        <th width="25%">날짜</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty receivedList}">
                            <c:forEach var="n" items="${receivedList}">
                                <tr>
                                    <td class="user-id">${n.sendId}</td>
                                    <td><div class="note-content">${n.noteContent}</div></td>
                                    <td><small class="text-muted">${n.time}</small></td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="3" class="empty-msg">받은 쪽지가 없습니다.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

	        <div class="tab-pane fade" id="sent" role="tabpanel">
	            <table class="table table-hover">
	                <thead>
	                    <tr>
	                        <th width="20%">받는 사람</th>
	                        <th width="55%">내용</th>
	                        <th width="25%">날짜</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:choose>
	                        <c:when test="${not empty sentList}">
	                            <c:forEach var="n" items="${sentList}">
	                                <tr>
	                                    <td class="user-id">${n.receiveId}</td>
	                                    <td><div class="note-content">${n.noteContent}</div></td>
	                                    <td><small class="text-muted">${n.time}</small></td>
	                                </tr>
	                            </c:forEach>
	                        </c:when>
	                        <c:otherwise>
	                            <tr><td colspan="3" class="empty-msg">보낸 쪽지가 없습니다.</td></tr>
	                        </c:otherwise>
	                    </c:choose>
	                </tbody>
	            </table>
	            
	            
	            <div id="pagingArea" class="mt-4">
	    <ul class="pagination justify-content-center">
	        <c:choose>
	            <c:when test="${ pi.currentPage eq 1 }">
	                <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
	            </c:when>
	            <c:otherwise>
	                <li class="page-item"><a class="page-link" href="noteList?page=${pi.currentPage - 1}">&lt;</a></li>
	            </c:otherwise>
	        </c:choose>
	
	        <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
	            <li class="page-item ${p eq pi.currentPage ? 'active' : ''}">
	                <a class="page-link" href="noteList?page=${p}">${p}</a>
	            </li>
	        </c:forEach>
	
	        <c:choose>
	            <c:when test="${ pi.currentPage eq pi.maxPage or pi.maxPage eq 0 }">
	                <li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
	            </c:when>
	            <c:otherwise>
	                <li class="page-item"><a class="page-link" href="noteList?page=${pi.currentPage + 1}">&gt;</a></li>
	            </c:otherwise>
	        </c:choose>
	    </ul>
	</div>
	
	<style>
	    .pagination .page-link { color: #333; border: 1px solid #dee2e6; }
	    .pagination .page-item.active .page-link { 
	        background-color: #blue; /* 포인트 노란색 */
	        border-color: #ffc107;
	        color: white;
	    }
	    .pagination .page-link:hover { background-color: #f8f9fa; color: #ffc107; }
	</style>
            
            
        </div>
    </div>
    
    <div class="text-right mt-4">
        <button class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/'">메인으로</button>
    </div>
</div>

</body>
</html>
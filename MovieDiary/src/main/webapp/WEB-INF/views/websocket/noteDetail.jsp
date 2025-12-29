<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 상세보기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fa; padding: 50px 0; }
    .detail-container { max-width: 700px; margin: auto; background: #fff; padding: 50px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
    
    .detail-header { border-bottom: 2px solid #f1f3f5; margin-bottom: 30px; padding-bottom: 20px; }
    .detail-title { font-weight: 700; color: #333; font-size: 24px; margin-bottom: 10px; }
    
    .info-row { display: flex; margin-bottom: 15px; align-items: center; }
    .info-label { width: 100px; font-weight: 600; color: #888; font-size: 14px; }
    .info-value { font-weight: 500; color: #333; font-size: 15px; }
    
    .content-box { 
        min-height: 250px; 
        background-color: #fdfdfd; 
        border: 1px solid #f1f3f5; 
        border-radius: 15px; 
        padding: 25px; 
        line-height: 1.8; 
        color: #444; 
        white-space: pre-wrap;
        font-size: 16px;
    }
    
    .btn-area { display: flex; justify-content: center; gap: 15px; margin-top: 40px; }
    .btn-custom { padding: 10px 30px; border-radius: 12px; font-weight: 600; transition: all 0.3s; }
    .btn-reply { background-color: #333; color: #fff; border: none; }
    .btn-reply:hover { background-color: #000; transform: translateY(-2px); }
    .btn-list { background-color: #fff; border: 1px solid #ddd; color: #666; }
    .btn-list:hover { background-color: #f8f9fa; color: #333; }
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="detail-container">
    <div class="detail-header">
        <div class="detail-title">✉️ 쪽지 읽기</div>
    </div>

    <div class="detail-body">
        <div class="info-row">
            <span class="info-label">보낸 사람</span>
            <span class="info-value">${n.sendNickName}</span>
        </div>
        
        <div class="info-row">
            <span class="info-label">받는 사람</span>
            <span class="info-value">${n.receiveNickName}</span>
        </div>
        
        <div class="info-row">
            <span class="info-label">날짜</span>
            <span class="info-value text-muted">${n.time}</span>
        </div>

        <hr class="my-4" style="border-top: 1px solid #f1f3f5;">

        <div class="content-box">${n.noteContent}</div>
    </div>

    <div class="btn-area">
	    <c:if test="${loginUser.nickName eq n.receiveNickName}">
	        <button class="btn-custom btn-reply" 
	                onclick="location.href='noteHandler?targetId=${n.sendNickName}'">답장하기</button>
	    </c:if>
	    
	    <c:choose>
	        <c:when test="${loginUser.nickName eq n.sendNickName}">
	            <button class="btn-custom btn-list" 
	                    onclick="location.href='noteList?type=sent'">목록으로</button>
	        </c:when>
	        
	        <c:otherwise>
	            <button class="btn-custom btn-list" 
	                    onclick="location.href='noteList?type=received'">목록으로</button>
	        </c:otherwise>
	    </c:choose>
	</div>
</div>

</body>
</html>
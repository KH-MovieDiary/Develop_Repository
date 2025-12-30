<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 실패</title>
<style>
    body {
        background-color: #f8f9fa;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        margin: 0;
        font-family: 'Noto Sans KR', sans-serif;
    }
    .error-container {
        text-align: center;
        background: #ffffff;
        padding: 50px;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.05);
        max-width: 500px;
        width: 90%;
    }
    .error-icon {
        font-size: 60px;
        margin-bottom: 20px;
    }
    .error-title {
        font-size: 24px;
        font-weight: 700;
        color: #343a40;
        margin-bottom: 15px;
    }
    .error-msg {
        color: #6c757d;
        margin-bottom: 30px;
        line-height: 1.6;
    }
    .btn-main {
        display: inline-block;
        padding: 12px 30px;
        background-color: #343a40;
        color: #ffffff;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.3s;
    }
    .btn-main:hover {
        background-color: #212529;
        color: #ffffff;
        text-decoration: none;
    }
</style>
</head>
<body>

    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <div class="error-title">회원가입에 실패하였습니다.</div>
        <p class="error-msg">
            ${errorMsg}<br> 잠시 후 다시 시도해 주시거나,<br>
            문제가 지속되면 관리자에게 문의해 주세요.
        </p>
        
        <a href="${pageContext.request.contextPath}/" class="btn-main">메인화면으로</a>
    </div>

</body>
</html>
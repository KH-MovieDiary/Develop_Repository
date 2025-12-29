<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<!-- jQuery 라이브러리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- 부트스트랩에서 제공하고 있는 스타일 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- 부트스트랩에서 제공하고 있는 스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    body {
        margin: 0;
        padding: 0;
    }

    #header {
        width: 100%;
    }

    #header_1 {
        width: 100%;
        height: 40px;
        background-color: white;
        border-bottom: 1px solid #ddd;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        padding-right: 15%;
        box-sizing: border-box;
    }

    #header_1 a, #header_1 label {
        margin-left: 15px;
        color: black;
        text-decoration: none;
        cursor: pointer;
        font-size: 14px;
    }

    #header_2 {
        width: 100%;
        height: 100px;
        background-color:#e9ecef;
        display: flex;
        justify-content: center;
    }

    .inner-wrap {
        width: 70%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    #header_2 ul {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        align-items: center;
    }

    #header_2 li {
        color: black;
        font-size: 20px;
        font-weight: bold;
        cursor: pointer;
        margin: 0 50px;
        white-space: nowrap;
    }

    #header_2 li a {
        color: black;
        text-decoration: none;
    }

    #header_2 li a:hover {
        color: gray;
    }

    .search-form {
        display: flex;
        align-items: center;
        background-color: white;
        border-radius: 30px;
        padding: 5px 15px;
        width: 350px;
        border: 2px solid black;
        font-weight: normal;
    }

    .search-input {
        border: none;
        outline: none;
        width: 100%;
        padding: 5px;
        font-size: 14px;
        background: transparent;
    }

    .search-btn {
        background: none;
        border: none;
        color: black;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        white-space: nowrap;
    }
    
    
    /* 로그인 모달 전용 스타일 추가 */
	#loginModal .modal-content {
	    border-radius: 20px;
	    border: none;
	    box-shadow: 0 15px 35px rgba(0,0,0,0.1);
	}
	
	#loginModal .modal-header {
	    border-bottom: none;
	    padding: 25px 25px 10px;
	}
	
	#loginModal .modal-title {
	    font-weight: 700;
	}
	
	#loginModal .modal-body {
	    padding: 10px 25px 25px;
	}
	
	#loginModal .modal-footer {
	    border-top: none;
	    padding: 0 25px 25px;
	    justify-content: center;
	    gap: 10px;
	}
	
	/* 입력창 스타일 통일 */
	#loginModal .form-control {
	    height: 48px;
	    border-radius: 8px;
	    border: 1px solid #e1e1e1;
	    padding: 0 15px;
	}
	
	/* 버튼 스타일 통일 (회원가입/탈퇴와 동일) */
	.btn-login-custom {
	    height: 40px;
	    min-width: 100px;
	    background-color: #343a40;
	    color: white;
	    border: none;
	    border-radius: 8px;
	    font-weight: 600;
	    transition: all 0.3s ease;
	}
	
	.btn-login-custom:hover {
	    background-color: #212529 !important;
	}
	
	.btn-cancel-outline {
	    height: 40px;
	    min-width: 100px;
	    background-color: #fff;
	    border: 1px solid #gray;
	    color: #gray !important;
	    border-radius: 8px;
	    font-weight: 600;
	    transition: all 0.3s ease;
	}
	
	.btn-cancel-outline:hover {
	    background-color: #dc3545;
	    color: #fff;
	}
    
    
    
    
    
    
    
    
</style>
	<c:set var="contextRoot" value="${pageContext.request.contextPath}" scope="application"/>
</head>
<body>
	<div id="header">
	    <div id="header_1">
	        <div id="header_1_right">
	
	            <c:choose>
	                <%-- ✅ 로그인 전 --%>
	                <c:when test="${empty loginUser}">
	                    <a href="${pageContext.request.contextPath}/enrollForm.me">회원가입</a>
	                    <a data-toggle="modal" data-target="#loginModal">로그인</a>
	                </c:when>
	
	                <%-- ✅ 로그인 후 --%>
	                <c:otherwise>
	                    <label>${loginUser.nickName}님 환영합니다</label>
	                    <a href="${contextRoot }/websocket/noteList">쪽지함</a>
	                    <a href="${contextRoot }/logout.me">로그아웃</a>
	                </c:otherwise>
	            </c:choose>
	
	        </div>
	    </div>
	
	    <div id="header_2">
	        <div class="inner-wrap">
	            <ul>
	                <li><a href="${contextRoot}">HOME</a></li>
	                <li><a href="${contextRoot}/movieInfo.mo">영화 정보</a></li>
	                <li><a href="${contextRoot}/reviewList.bo">감상평</a></li>
	                <li><a href="${contextRoot }/mypage.me" onclick="return checkLogin();">마이페이지</a></li>
	                <li>
	                    <form action="${contextRoot}/movieInfo.mo" method="get" class="search-form">
					    <input type="text" class="search-input" name="keyword" placeholder="영화 제목을 검색해보세요">
					    <button type="submit" class="search-btn">검색</button>
					</form>
	
	                </li>
	            </ul>
	        </div>
	    </div>
	</div>
	
	<div class="modal fade" id="loginModal">
	    <div class="modal-dialog modal-sm modal-dialog-centered"> <div class="modal-content">
	            <div class="modal-header">
	                <h4 class="modal-title">로그인</h4>
	                <button type="button" class="close" data-dismiss="modal">&times;</button>
	            </div>
	
	            <form action="${contextRoot}/login.me" method="post" style="margin:0;">
	                <div class="modal-body">
	                    <label for="userId" class="mr-sm-2" style="font-weight: 600; color: #666;">아이디</label>
	                    <input type="text" class="form-control mb-3" id="userId" name="userId" placeholder="아이디 입력" required>
	                    
	                    <label for="userPwd" class="mr-sm-2" style="font-weight: 600; color: #666;">비밀번호</label>
	                    <input type="password" class="form-control" id="userPwd" name="userPwd" placeholder="비밀번호 입력" required>
	                </div>
	
	                <div class="modal-footer">
	                    <button type="submit" class="btn-login-custom">로그인</button>
	                    <button type="button" class="btn-cancel-outline" data-dismiss="modal">취소</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
	
	<c:if test="${ not empty alertMsg }">
		<script>
			alert("${alertMsg}");
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>
	
	
	
	
	
	<script>
	    var noteSocket;
	
	    $(document).ready(function() {
	        if("${loginUser}" != "") {
	            connectWS();
	        }
	    });
	
	    function connectWS() {
	        noteSocket = new WebSocket("ws://localhost:8080/moviediary/note-ws");
	        
	        window.noteSocket = noteSocket; 

	        noteSocket.onmessage = function(event) {
	            if(event.data === "newNote") {
	                alert("📩 새로운 쪽지가 도착했습니다!");
	            }
	        };
	    }
	    
	    function checkLogin() {
	        var loginUser = "${loginUser}";
	        
	        if (loginUser == "") {
	            alert("로그인 후 이용 가능합니다.");
	            return false; 
	        }
	        return true;
	    }
	</script>
	
	
</body>
</html>

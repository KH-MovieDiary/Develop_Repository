<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage Home</title>
	
	<style>
	.wrap {
			width : 70%;
            height : 100vh;
            margin: auto;
            background-color:darkbrwon;
            }
            
     .section {
		    margin-bottom: 40px;
		    padding: 20px;
		    border: 1px solid #ccc;
	    	}

     .section-title {
			font-weight: bold;
			margin-bottom: 15px;
			}
			    	
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="wrap">
		
		
		
		<!-- 프로필 / 회원정보수정 버튼 / 회원정보 -->
			<section class="section content1">
	        <div class="section-title">회원 정보</div>
	
	        <div class="profile-area">
	            <!-- 프로필 이미지 -->
	            <div class="profile-img">
	                프로필 사진
	            </div>
	
	            <!-- 회원 정보 -->
	            <div class="profile-info">
	                이름 / 나이 / 좋아하는 장르
	            </div>
	
	            <!-- 버튼 -->
	            <div class="profile-btn">
	                <button>회원 정보 수정</button>
	            </div>
	        </div>
	   	    </section>
		
		
		<!-- 위시리스트 공감(좋아요/싫어요)한 영화 -->
			<section class="section content2">
		        <div class="section-title">
		            위시리스트 (좋아요 / 싫어요 한 영화)
		        </div>
		
		        <div class="list-area">
		            <!-- 영화 카드 반복 -->
		            <div class="item">
		                영화 제목
		            </div>
		        </div>
    	    </section>
		
		<!-- 내가 쓴 감상평 -->
			<section class="section content3">
		        <div class="section-title">내가 쓴 감상평</div>
		
		        <div class="list-area">
		            <!-- 감상평 카드 반복 -->
		            <div class="item">
		                감상평 내용
		            </div>
		        </div>
    	    </section>
		
		<!-- 내가 쓴 댓글/공감(좋아요)한 감상평 -->
			<section class="section content4">
		        <div class="section-title">
		            내가 쓴 댓글 / 좋아요 한 감상평
		        </div>
		
		        <div class="list-area">
		            <!-- 댓글/공감 카드 반복 -->
		            <div class="item">
		                댓글 또는 감상평
		            </div>
		        </div>
   		 	</section>
		
		
		
		
		
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp">
</body>
</html>
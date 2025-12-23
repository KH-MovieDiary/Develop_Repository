<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영화 등록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
        }

        .movie-register-wrapper {
            width: 70%;
            min-height: 100vh;
            margin: 0 auto;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 0;
        }

        .innerOuter {
            width: 100%;
            padding: 50px 60px;
            background-color: #ffffff;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border-radius: 20px;
            border: none;
        }

        .form-title {
            font-weight: 700;
            color: #343a40;
            margin-bottom: 40px;
            text-align: center;
            font-size: 1.8rem;
        }

        .form-group label {
            font-weight: 700;
            color: #495057;
            margin-bottom: 10px;
            font-size: 1rem;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #e9ecef;
            padding: 15px;
            font-size: 1rem;
            background-color: #fcfcfc;
        }
        .form-control:focus {
            background-color: #fff;
            border-color: #ff9fb3;
            box-shadow: 0 0 0 3px rgba(255, 143, 171, 0.2);
        }

    </style>
</head>
<body>
	
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="movie-register-wrapper">
        <div class="innerOuter">
            <h2 class="form-title">영화감상문 작성하기</h2>
            
            <form id="enrollForm" method="post" action="${pageContext.request.contextPath}/insert.review">
   		
   				<div class="form-group">
                    <label for="reviewTitle">감상평 제목</label>
                    <input type="text" id="reviewTitle" class="form-control" name="reviewTitle" placeholder="" required>
                </div>
                
                <div class="form-group">
                    <label for="movieTitle">영화 제목</label>
			     	<c:choose>
			        		<c:when test="${not empty movieTitle}">
			            		<input type="text" name="movieTitle" class="form-control" value="${movieTitle}" readonly>
			            	    <input type="hidden" name="movieId" value="${movieId}">
			       			</c:when>
							<c:otherwise>
			            		 <input type="text" id="movieTitle" class="form-control" name="movieTitle" placeholder="" required>
			            	</c:otherwise>
			        </c:choose>
                </div>
                
                <div class="form-group">
                    <label for="writer">작성자</label>
                    <input type="text" id="writer" class="form-control" value="${loginUser.nickName}" readonly>				
					<input type="hidden" name="userId" value="${loginUser.userId}">
                </div>

                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" class="form-control" rows="15" style="resize:none;" name="content" placeholder="영화에 대한 자유로운 감상평이나 줄거리를 기록해주세요." required></textarea>
                </div>

                <div class="btn-area">
                    <button type="submit" class="btn btn-pink">등록하기</button>
                    <button type="reset" class="btn btn-gray">취소하기</button>
                </div>

            </form>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
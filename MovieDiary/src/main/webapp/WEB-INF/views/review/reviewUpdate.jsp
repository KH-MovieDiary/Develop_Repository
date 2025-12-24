<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            border-radius: 18px;
            border: 1px solid var;
            background: rgba(255,255,255,0.05);
            box-shadow: 0 18px 60px rgba(0,0,0,0.25);
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
        
        .btn-area {
        position: relative; 
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 50px;    
        margin-top: 30px;
        gap: 15px;            
    }
    
    .btn-area button {
        padding: 10px 30px;
        border-radius: 5px;
        font-weight: bold;
        cursor: pointer;
        
        background: linear-gradient(180deg, rgba(255,255,255,.95), rgba(248,250,252,.95));
        border: 1px solid rgba(0,0,0,.08);
        box-shadow: 0 12px 24px rgba(2,6,23,.06);
        transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease, opacity .12s ease;
    }
    
    .btn-area button:hover {
        transform: translateY(-1px);
        border-color: rgba(125,211,252,0.35);
        box-shadow: 0 18px 36px rgba(2,6,23,.08);
    }
    
    .btn-area button:active {
        transform: translateY(0) scale(.99);
    }
    
    .submit {
        background: linear-gradient(180deg,#06b6d4,#0891b2) !important;
        border-color: #06b6d4 !important;
        color: #fff !important;
        box-shadow: 0 18px 40px rgba(6,182,212,.22);
    }
    
    .reset {
        background: linear-gradient(180deg,#fb7185,#ef4444) !important;
        border-color: #fb7185 !important;
        color: #fff !important;
        box-shadow: 0 18px 40px rgba(251,113,133,.22);
    }
        
    
    </style>
</head>
<body>
	
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="movie-register-wrapper">
        <div class="innerOuter">
            <h2 class="form-title">영화감상문 수정하기</h2>
            
            <form id="enrollForm" method="post" action="${contextRoot}/update.review">
   				<input type="hidden" name="reviewId" value="${review.reviewId }">
                	<div class="form-group">
                    <label for="movieTitle">감상문 제목</label>
                    <input type="text" id="reviewTitle" class="form-control" name ="reviewTitle" style="resize:none" value="${review.reviewTitle}">	
                </div>
                
                <div class="form-group">
                    <label for="writer">작성자</label>
                    <input type="text" id="writer" class="form-control" value="${review.nickname}" readonly>			
					<input type="hidden" name="userId" value="${review.userId}">
                </div>

                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" class="form-control" rows="15" style="resize:none;" name="content" required>${review.content}</textarea>
                </div>

                <div class="btn-area">
                    <button type="submit" class="submit">수정하기</button>
                    <button type="reset" class="reset" onclick="javascript:history.go(-1);">취소하기</button>
                </div>

            </form>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
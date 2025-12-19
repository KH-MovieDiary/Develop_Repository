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

        .btn-area {
            margin-top: 40px;
            text-align: center;
        }
        
        .btn-pink {
            background-color: #ff8fab;
            color: white;
            border: none;
            padding: 12px 50px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(255, 143, 171, 0.4);
            transition: all 0.3s ease;
        }

        .btn-pink:hover {
            background-color: #ff7096;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(255, 143, 171, 0.6);
            color: white;
        }

        .btn-gray {
            background-color: #e9ecef;
            color: #495057;
            border: none;
            padding: 12px 50px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 12px;
            margin-left: 10px;
            transition: all 0.3s ease;
        }
        .btn-gray:hover {
            background-color: #dee2e6;
            color: #212529;
        }
        
        input[readonly] {
            background-color: #f8f9fa !important;
            color: #6c757d;
            border: none;
        }

    </style>
</head>
<body>
	
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="movie-register-wrapper">
        <div class="innerOuter">
            <h2 class="form-title">영화감상문 수정하기</h2>
            
            <form id="enrollForm" method="post" action="${pageContext.request.contextPath}/update.review">
   
                <div class="form-group">
                    <label for="movieTitle">영화 제목</label>
                    <input type="text" id="movieTitle" class="form-control" name="movieTitle" value="${review.movieTitle }" readonly>
                </div>
                
                <div class="form-group">
                    <label for="writer">작성자</label>
                    <input type="text" id="writer" class="form-control" value="${review.userId}" name="userId" readonly>
                </div>

                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" class="form-control" rows="15" style="resize:none;" name="content" required>${review.content}</textarea>
                </div>

                <div class="btn-area">
                    <button type="submit" class="btn btn-pink">수정하기</button>
                    <button type="reset" class="btn btn-gray">취소하기</button>
                </div>

            </form>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
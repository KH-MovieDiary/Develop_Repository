<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>감상평 상세보기</title>
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

        .btn-area {
            margin-top: 40px;
            text-align: center;
        }
        
		.btn-blue {
		    background-color: #74c0fc;
		    color: white;
		    border: none;
		    padding: 12px 50px;
		    font-size: 1.1rem;
		    font-weight: 600;
		    border-radius: 12px;
		    box-shadow: 0 4px 10px rgba(116, 192, 252, 0.4); 
		    transition: all 0.3s ease;
		}
		
		.btn-blue:hover {
		    background-color: #4dabf7;
		    transform: translateY(-2px);
		    box-shadow: 0 6px 15px rgba(116, 192, 252, 0.6);
		    color: white;
		}
		
		.btn-red {
		    background-color: #ff8787;  
		    color: white;
		    border: none;
		    padding: 12px 50px;
		    font-size: 1.1rem;
		    font-weight: 600;
		    border-radius: 12px;
		    box-shadow: 0 4px 10px rgba(255, 135, 135, 0.4); 
		    transition: all 0.3s ease;
		    margin-left: 10px;
		}
		
		.btn-red:hover {
		    background-color: #fa5252; 
		    transform: translateY(-2px);
		    box-shadow: 0 6px 15px rgba(255, 135, 135, 0.6);
		    color: white;
		}
    </style>
</head>
<body>
	
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="movie-register-wrapper">
        <div class="innerOuter">
            <h2 class="form-title">감상평 상세보기</h2>
            
           <table id="contentArea" class="table">
                <tr>
                    <th>영화 제목</th>
                    <td colspan="3">${review.movieTitle}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${review.userId}</td>
                    <th>작성일</th>
                    <td>${review.createDate}</td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td colspan="3">${review.viewCount}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td> </tr>
                <tr>
                    <td colspan="4">
                        <p style="min-height: 300px; white-space: pre-wrap;">${review.content}</p>
                    </td>
                </tr>
            </table>
				
				<c:if test="${review.userId eq loginUser.userId }">
	                <div class="btn-area">
	                    <button type="button" id="updateBtn" class="btn btn-blue">수정하기</button>
	                    <button type="button" id= "deleteBtn" class="btn btn-red">삭제하기</button>
	                </div>
				</c:if>
        </div>
    </div>
    
    <script>
    	$(function(){
    		$("#updateBtn").click(function(){
    			let form = $("<form>").attr("action","updateForm.review").attr("method","post");
    			
    			let input = $("<input>").attr("type","hidden").attr("name","rno").attr("value","${review.reviewId}");
    			
    			form.append(input);
    			
    			$("body").append(form);
    			
    			form.submit();
    		
    		});
    	});
    	
    	$(function(){
    		$("#deleteBtn").click(function(){
    			let form = $("<form>").attr("action","delete.review").attr("method","post");
    			
    			let input = $("<input>").attr("type","hidden").attr("name","rno").attr("value","${review.reviewId}");
    			
    			form.append(input);
    			
    			$("body").append(form);
    			
    			form.submit();
    		
    		});
    	});
    </script>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
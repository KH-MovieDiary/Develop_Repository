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

    </style>
</head>
<body>
	
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="movie-register-wrapper">
        <div class="innerOuter">
            <h2 class="form-title">감상평 상세보기</h2>
			<br> <a class="listBtn" id="listBtn" style="float: right;"
				href="${contextRoot}/reviewList.bo">목록으로</a> <br>
			<br>
            
            
           <table id="contentArea" class="table">
           		<tr>
                    <th>감상평 제목</th>
                    <td colspan="3">${review.reviewTitle}</td>
                </tr>
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
                    <td>${review.viewCount}</td>
                    <c:if test="${not empty review.updateDate}">
                    <th>수정일</th>
                    <td>${review.updateDate}</td>
                    </c:if>
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
	                    <button type="button" id="updateBtn" class="btn">수정하기</button>
	                    <button type="button" id= "deleteBtn" class="btn">삭제하기</button>
	                </div>
				</c:if>
				
				<c:if test= "${not empty loginUser }">
					<button type="button" id="likeBtn" class="${likeYn == 'Y' ? 'y' : ''}">좋아요</button><br>
				</c:if>
				<span id="likeCount">${review.likeCount }</span>
				
				<input type="hidden" id="rno" value="${review.reviewId }">
				<input type="hidden" id="uid" value="${loginUser.userId }">
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
    	
    	$(function(){
    		$("#likeBtn").click(function(){
    			
    		$.ajax({
    			url: "like.review",
    			data: {
    				reviewId: $("#rno").val(),
    				userId: $("#uid").val()
    			},
    			success: function(result){
    				if(result>0){
    					let currentCount = parseInt($("#countArea").text());
    					
    					if($("#likeBtn").hasClass("y")){
    						alert("좋아요를 취소하였습니다");
    						$("#countArea").text(currentCount - 1);
                            $("#likeBtn").removeClass("y");
    					} else{
    						alert("좋아요를 눌렀습니다")
    						 $("#countArea").text(currentCount + 1);
    						 $("#likeBtn").addClass("y");
    					}
    				} else{
    					alert("좋아요가 반영되지 않았습니다")
    				}
    			},
    			error: function(){
    				console.log("통신실패");
    			}
    		});
    	});
    });
    </script>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
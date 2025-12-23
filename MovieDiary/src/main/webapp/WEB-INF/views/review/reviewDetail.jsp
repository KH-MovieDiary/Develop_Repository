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
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
        
        .comment-area{
        	width:70%;
        	margin: 0 auto;
        	display: flex;
        	justify-content: center;
        	align-items: center;
        }
        
        .comment-input{
        	width: 100%;
        	display: flex;
        	justify-content: center;
        	gap: 5px;
        }

		#commentContent{
			width: 70%;
        	height: 40px;
        	resize: none;
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
                    <td>${review.nickname}</td>
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
					<style>
						.y {
      						 color: red;
      						 font-weight: bold;
      						}
					</style>
				</c:if>
				좋아요 수 : <span id="likeCount">${review.likeCount }</span>
				
				<input type="hidden" id="rno" value="${review.reviewId }">
				<input type="hidden" id="uid" value="${loginUser.userId }">
    
			<br>
			댓글 : <span id="rCount"></span>
			<table class="replyArea">
				<thead>
					<tr>
						<th>
							<c:choose>
								
								<c:when	test="${empty loginUser}">
									<textarea id="replyContent" placeholder="로그인 후 이용가능합니다." readonly></textarea>
								</c:when>
									
								<c:otherwise>
									<textarea id="replyContent" placeholder="댓글을 작성하세요."></textarea>
								</c:otherwise>
									
							</c:choose>
						</th>
						<th>
							<button id="replyBtn">등록</button>
						</th>
					</tr>
				</thead>
				<tbody>
				    
				</tbody>
			</table>
		</div>
	</div>
    
    <script>
    	
    	replyList();
    
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
    					let currentCount = parseInt($("#likeCount").text());
    					
    					if($("#likeBtn").hasClass("y")){
    						$("#likeCount").text(currentCount - 1);
                            $("#likeBtn").removeClass("y");
    					} else{
    						 $("#likeCount").text(currentCount + 1);
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
    	
    	
		function replyList(){
    		
			$.ajax({
				
				url : "selectList.re",
				data : {
					reviewId : ${review.reviewId}
				},
				success : function(list){
					$(".replyArea tbody").html("");
					if(list.length === 0){
						let tr = $("<tr>");
						tr.append($("<td>").attr("colspan", 2).text("조회된 댓글이 없습니다"));
						$(".replyArea tbody").append(tr);
					}else{
						for(let r of list){
							let tr =$("<tr>");
							tr.append($("<td>").text(r.nickname)
									 ,$("<td>").text(r.content)
									 ,$("<td>").text(r.createDate));
							$(".replyArea tbody").append(tr);
						}
						$("#rCount").text(list.length);
					}
				},
				error : function(){
					alert("통신 오류");
				}
			});
    		
    	}
    	
		$(function(){
    		
    		$("#replyBtn").click(function(){
    			
    			$.ajax({
    				
    				url : "insertReply.re",
    				data : {
    					content : $("#replyContent").val(),
    					userId : "${loginUser.userId}",
    					reviewId : ${review.reviewId}
    				},
    				success : function(result){
    					if(result>0){
    						alert("댓글 등록 성공");
    						$("#replyContent").val("");
    						replyList();
    					}else{
    						alert("댓글 등록 실패");
    					}
    				},
    				error : function(){
    					alert("통신 오류");
    				}
    			});
    		});
    	});
    </script>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
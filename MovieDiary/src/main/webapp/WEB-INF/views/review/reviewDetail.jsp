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
		    background-color:#f4f6f9;
		    color: #333;
		    margin: 0;
		    padding: 0;
        }

         .movie-register-wrapper {
            width: 70%;
		    margin: 0 auto;
		    padding: 50px;
		    border: 1px solid var;
		    background: rgba(255,255,255,0.05);
		    border-radius: 18px;
			box-shadow: 0 18px 60px rgba(0,0,0,0.1);
        } 
		
		.replyArea{
			width: 100%;
			table-layout: fixed;
		}
		
		.replyArea tbody td {
		    padding: 10px;
		    vertical-align: top;
		    font-size: 14px;
		}
		
		.replyArea tbody td:first-child {
		    width: 160px;
		    font-weight: bold;
		    overflow: hidden;
		    text-overflow: ellipsis;
		}
		
		.replyArea tbody td:nth-child(2) {
			width: auto;
		    background-color: #f8f9fa;
		    border-radius: 6px;
		    line-height: 1.5;
		    white-space: pre-wrap;
		}
		
		.replyArea tbody td:nth-child(3) {
			width: 120px;
			text-align: right;
		    border-radius: 6px;
		    line-height: 1.5;
		    white-space: pre-wrap;
		    
		}
		
		.replyArea tbody td:last-child {
			width:40px;
		    padding: 0;
		    text-align: center;
		    vertical-align: middle;
		}
		
		#replyContent1,
		#replyContent2 {
		    width: 100%;
		    min-height: 80px;
		    resize: none;
		    padding: 10px;
		    box-sizing: border-box;
		    font-size: 14px;
		    border: 1px solid #ddd;
        	border-radius: 5px;
		}
		
		.replyArea thead th{
			padding: 10px;
			box-sizing: border-box;
			font-size: 14px;
		}
		
		.replyArea thead th:first-child{
			width: 160px;
		}
		
		.replyArea thead th:nth-child(2){
			width: auto;
			padding: 0;
		}
		
		.replyArea thead th:nth-child(3){
			width: 120px;		
		}
		
		.replyArea thead th:last-child{
			width: 40px;
		}
		
		.replyArea tbody tr {
		    border-bottom: 1px solid lightgrey;
		}
		
		.replyArea tbody td.noReply {
		    font-size: 20px;
		    text-align: center;
		    color: #666;
		    padding: 20px 0;
		}
		
		.delBtn {
		    background: none;
		    border: none;
		    padding: 0;
		}
		
		#replyBtnArea {
			width: 100%;
		    margin: 8px 0;
		    display: flex;
		    justify-content: flex-end;
		}
		
		#replyBtn1,
		#replyBtn2{
			background-color: white; 
	        border: 1px solid #ddd;  
	        padding: 10px 20px;      
	        border-radius: 20px; 
	        font-size: 12px;
	        font-weight: bold;
	        display: flex;
	        align-items: center;
	        
		}
		
		#replyBtn2:hover{
			border: 1px solid #757575;
		}
		
		#privateOption{
			cursor: pointer; 		
		}
		
	.btn-area{
        position: relative; 
        display: flex;
        align-items: center;
        width: 100%;
        height: 50px;    
        margin-top: 30px;   
        justify-content: space-between;     
    }
    
    .right-btns {
        display: flex;
        gap: 15px;
    }
    
    .btn-area button {
        padding: 10px 30px;
        border-radius: 5px;
        font-weight: bold;
        background: linear-gradient(180deg, rgba(255,255,255,.95), rgba(248,250,252,.95));
        border: 1px solid rgba(0,0,0,.08);
        transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease, opacity .12s ease;
    }
    
    .btn-area button:hover {
        transform: translateY(-1px);
        border-color: rgba(125,211,252,0.35);
    }
    
    .btn-area button:active {
        transform: translateY(0) scale(.99);
    }
    
    .submit {
        background: linear-gradient(180deg,#06b6d4,#0891b2) !important;
        border-color: #06b6d4 !important;
        color: #fff !important;
    }
    
    .reset {
        background: linear-gradient(180deg,#fb7185,#ef4444) !important;
        border-color: #fb7185 !important;
        color: #fff !important;
    }
		
    #likeBtn {
        background-color: white; 
        border: 2px solid #ddd;  
        color: #888;             
        padding: 10px 20px;      
        border-radius: 30px; 
        font-size: 16px;
        font-weight: bold;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 5px;
        outline: none; 

    }

    #likeBtn:hover {
        background-color: #f9f9f9;
        border-color: #ccc;
    }

    #likeBtn.y {
        border-color: #ff4757; 
        color: #ff4757;        
        background-color: #fff0f1; 
    }
    
    #likeBtn.y .heart {
        transform: scale(1.1); 
        display: inline-block;
    }
    
    button,
	.delBtn,
	label {
	    cursor: pointer;
	}
	
</style>

</head>
<body>
	
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="movie-register-wrapper">
        <h3>감상평 상세보기</h3>
		<br> 
			<div style="float: right; display: flex; gap: 10px;">
			    <c:if test="${not empty loginUser and review.userId ne loginUser.userId}">
			        <a class="listBtn" id="sendNoteBtn" 
			           href="${contextRoot}/websocket/noteHandler?targetId=${review.nickname}">쪽지 보내기</a>
			    </c:if>
			
			    <a class="listBtn" id="listBtn" href="${contextRoot}/reviewList.bo">목록으로</a>
			</div>
			<br><br>
            
            
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
				<th>수정일</th>
					<td>
					    <c:out value="${review.updateDate}" default="-" />
					</td>
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
				
	     <div class="btn-area">          
			<button type="button" id="likeBtn" class="${likeYn == 'Y' ? 'y' : ''}">
					<span class="heart">♥</span> <span id="likeCount">${review.likeCount }</span>
			</button>
				   
			<div class="right-btns">
				<c:if test="${review.userId eq loginUser.userId }">
				    <button type="button" id="updateBtn" class="submit">수정하기</button>
				    <button type="button" id="deleteBtn" class="reset">삭제하기</button>
				</c:if>
			</div>
	     </div>
				
			<input type="hidden" id="rno" value="${review.reviewId }">
			<input type="hidden" id="uid" value="${loginUser.userId }">
    
		<br>
			
		<table class="replyArea">
			<thead>
				<tr>
					<th>
						댓글(<span id="rCount"></span>)
					</th>
					<th>
						<c:choose>
									
							<c:when	test="${empty loginUser}">
								<textarea id="replyContent1" placeholder="로그인 후 이용가능합니다." disabled></textarea>
							</c:when>
													
							<c:otherwise>
								<div class="replyOption">
									<label id="privateOption">
										<input type="checkbox" id="privateReply" value="Y">
										작성자에게만 표시
									</label>
								</div>	
								<textarea id="replyContent2" placeholder="댓글을 작성하세요."></textarea>
							</c:otherwise>
												
						</c:choose>
										
						
					</th>
					<th>
						<div id="replyBtnArea">
							<c:choose>
								<c:when test="${empty loginUser}">
									<button type="button" id="replyBtn1" disabled>댓글 등록</button>
								</c:when>
								<c:otherwise>
									<button type="button" id="replyBtn2">댓글 등록</button>
								</c:otherwise>
							</c:choose>
						</div>
					</th>
					<th>
					</th>
				</tr>
			</thead>
			<tbody>
				    
			</tbody>
		</table>
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
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
    			
    		if( ${empty loginUser} ) {
    	        alert("로그인 후 이용가능합니다.");
    	        return;
    	       }
    			
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
						tr.append($("<td>")
								.attr("colspan", 4)
								.addClass("noReply")
								.text("조회된 댓글이 없습니다"));
						$(".replyArea tbody").append(tr);
					}else{
						for(let r of list){
							let tr =$("<tr>");
							
							const loginId = "${loginUser.userId}";
							
							let privateYn = (r.privateYn === "N");
							let writer = (r.userId === loginId || r.reviewUserId === loginId);
							
							let content;
							
							if(privateYn || writer){
								content = r.content;
							}else{
								content = "비밀 댓글입니다."
							}
							
							tr.append($("<td>").text(r.nickname)
									 ,$("<td>").text(content)
									 ,$("<td>").text(r.createDate));
							
							if(loginId !== "" && r.userId === loginId){

		                        let delBtn = $("<button>")
		                            .addClass("delBtn")
		                            .text("🗑️")
		                            .data("rcno", r.reviewCommentId);

		                        tr.append(
		                            $("<td>").append(delBtn)
		                        );

		                    } else {
		                        tr.append($("<td>")); // 버튼 없는 자리 맞추기
		                    }
							
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
    		
    		$("#replyBtn2").click(function(){
    			
    			$.ajax({
    				
    				url : "insertReply.re",
    				data : {
    					content : $("#replyContent2").val(),
    					userId : "${loginUser.userId}",
    					reviewId : ${review.reviewId},
    					privateYn : $("#privateReply").is(":checked") ? "Y" : "N"
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
    					alert("댓글을 입력 후 등록하세요");
    				}
    			});
    		});
    	});
		
		$(function(){
			$(document).on("click", ".delBtn", function () {

			    if (!confirm("댓글을 삭제하시겠습니까?")) return;

			    const rcno = $(this).data("rcno");

			    $.ajax({
			        url: "deleteReply.re",
			        data: { rcId : rcno },
			        success: function (result) {
			        	if(result>0){
			        		alert("댓글이 삭제되었습니다.");
			            	replyList();
			        	}else{
			        		alert("댓글 삭제 실패");
			        	}
			        },
			        error: function(){
			        	console.log(rcId);
			        	alert("댓글 삭제 실패");
			        }
			    });
			});
		});
    </script>
    

</body>
</html>
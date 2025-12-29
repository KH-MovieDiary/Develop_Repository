<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage Home</title>

<style>
/* =========================
   Layout
   ========================= */
.wrap {
    width: 70%;
    flex : 1;
    margin: auto;
    background-color: #f4f6f8;
}

.section {
    margin-bottom: 40px;
    padding: 30px;
    border: 1px solid #ccc;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.06);
}

.section-title {
    font-size: 17px;
    font-weight: 700;
    margin-bottom: 20px;
    color: #111827;
}

/* =========================
   content1 : 프로필 / 회원정보
   ========================= */
.content1 {
    background-color: transparent;
}

.content1-body {
    display: flex;
    gap: 40px;
    padding: 30px;
    align-items: stretch;
}

.profile-area {
    width: 280px;
    text-align: center;
}

.profile-img {
    width: 160px;
    height: 160px;
    margin: 0 auto 24px;
    border-radius: 50%;
    overflow: hidden;
    border: 3px solid #e5e7eb;
    background-color: #fafafa;
}

.profile-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.profile-area button {
    width: 100%;
    margin-bottom: 10px;
    padding: 10px 0;
    border-radius: 6px;
    border: 1px solid #d1d5db;
    background-color: #f9fafb;
    color: #111827;
    font-size: 14px;
    cursor: pointer;
}

.profile-area a button:hover {
    background-color: #e5e7eb;
}

.profile-info {
    margin-left: auto;
    width: 600px;
    padding: 28px 32px;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    background-color: #ffffff;
    flex: 1;
}

.profile-info p {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 14px;
    font-size: 15px;
    color: #111827;
}

.profile-info p span {
    width: 80px;
    font-weight: 600;
    color: #6b7280;
}


/* 회원가입 페이지와 동일한 버튼 스타일 이식 */
.custom-btn {
    height: 40px;
    min-width: 100px;
    padding: 0 20px;
    border: none;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 14px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    white-space: nowrap;
}

/* 검정색 메인 버튼 (확인용) */
.btn-primary-custom {
    background-color: #343a40 !important;
    color: white !important;
}
.btn-primary-custom:hover {
    background-color: #212529 !important;
}

/* 흰색/빨간색 테두리 버튼 (취소/탈퇴용) */
.btn-danger-outline {
    background-color: #fff !important;
    border: 1px solid #dc3545 !important;
    color: #dc3545 !important;
}
.btn-danger-outline:hover {
    background-color: #dc3545 !important;
    color: #fff !important;
}

/* 모달 입력창 스타일 개선 */
#deleteUserPwd {
    height: 48px;
    border-radius: 8px;
    border: 1px solid #e1e1e1;
    padding: 0 15px;
    width: 100%;
}












/* =========================
   공통 가로 스크롤 영역
   ========================= */
.horizontal-scroll {
    display: flex;
    gap: 20px;
    overflow-x: auto;
    overflow-y: hidden;
    flex-wrap: nowrap;
    padding-bottom: 10px;
}

.horizontal-scroll .item_content {
    flex: 0 0 auto;
    width: 180px;
    background-color: #ffffff;
    border-radius: 12px;
    padding: 14px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.06);
    cursor: pointer;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    min-height: 140px;
    transition: transform 0.2s;
}

.horizontal-scroll .item_content:hover {
    transform: translateY(-2px);
}

/* =========================
   content2 : 위시리스트
   ========================= */
.poster_item {
    width: 100%;
    height: 260px;
    overflow: hidden;
}

.poster_item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.title_item {
    margin-top: 8px;
    font-size: 14px;
    font-weight: 600;
    text-align: center;
}

/* =========================
   content3 / content4 : 감상평 카드
   ========================= */
.review-title {
    font-size: 14px;
    font-weight: 700;
    margin-bottom: 8px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.review-meta {
    display: flex;
    justify-content: space-between;
    font-size: 12px;
    color: #6b7280;
}

.review-date {
    margin-top: 6px;
    font-size: 11px;
    color: #9ca3af;
}

.empty-area {
    width: 100%;
    text-align: center;
    padding: 40px 0;
    color: #9ca3af;
}
</style>
</head>

<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<br>
<div class="wrap">

    <!-- content1 -->
    <section class="section content1">
        <div class="section-title">회원 정보</div>

        <div class="content1-body">
            <div class="profile-area">
                <div class="profile-img">
                    <img src="${loginUser.picture != null
                        ? loginUser.picture
                        : '/resources/img/default_profile.png'}">
                </div>

                <a href="${pageContext.request.contextPath}/updateForm.me"><button>회원 정보 수정</button></a>
                <button type="button" data-toggle="modal" data-target="#pwdCheckModal">회원 탈퇴</button>
            </div>

            <div class="profile-info">
                <p><span>닉네임</span> ${loginUser.nickName}</p>
                <p><span>생년월일</span>${loginUser.birthday}</p>	
    			<p><span>나이</span> 만 ${loginUser.age}세</p>
                <p><span>성별</span> 
			        <c:choose>
			            <c:when test="${loginUser.gender == 'M'}">남성</c:when>
			            <c:otherwise>여성</c:otherwise>
			        </c:choose>
		    	</p>
				
               <p><span>장르</span> ${loginUser.genreNames }</p>	


                <p><span>가입일</span> 
    			<fmt:formatDate value="${loginUser.createDate}" pattern="yyyy년 MM월 dd일"/>
				</p>


            </div>
        </div>
    </section>

    <!-- content2 -->
    <section class="section content2">
        <div class="section-title">위시리스트 (좋아요 / 싫어요 한 영화)</div>

        <div class="horizontal-scroll">
            <c:forEach var="m" items="${likedMovies}">
                <div class="item_content">
                    <div class="poster_item">
                        <img src="${m.posterUrl}">
                    </div>
                    <div class="title_item">${m.title}</div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- content3 -->
    <section class="section content3">
        <div class="section-title">내가 쓴 감상평</div>

        <div class="horizontal-scroll">
            <c:choose>
                <c:when test="${empty myReviewList}">
                    <div class="empty-area">작성한 감상평이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="r" items="${myReviewList}">
                        <div class="item_content"
                             onclick="location.href='${pageContext.request.contextPath}/review.detail?rno=${r.reviewId}'">
                            <div class="review-title">제목</div>
                            <div class="review-meta">
                                <span>조회수 ${r.viewCount}</span>
                                <span>좋아요 ${r.likeCount}</span>
                            </div>
                            <div class="review-date">${r.createDate}</div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- content4 -->
    <section class="section content4">
        <div class="section-title">내가 쓴 댓글 / 좋아요 한 감상평</div>

        <div class="horizontal-scroll">
            <c:choose>
                <c:when test="${empty myActivityList}">
                    <div class="empty-area">활동 내역이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="a" items="${myActivityList}">
                        <div class="item_content"
                             onclick="location.href='${pageContext.request.contextPath}/review.detail?rno=${a.reviewId}'">
                            <div class="review-title">제목</div>
                            <div class="review-meta">
                                <span>
                                    <c:choose>
                                        <c:when test="${a.activityType == 'COMMENT'}">댓글</c:when>
                                        <c:otherwise>좋아요</c:otherwise>
                                    </c:choose>
                                </span>
                                <span>좋아요 ${a.likeCount}</span>
                            </div>
                            <div class="review-date">${a.createDate}</div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
    
    
    
    <div class="modal fade" id="pwdCheckModal">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content" style="border-radius: 20px; border: none; box-shadow: 0 15px 35px rgba(0,0,0,0.1);">
	            <div class="modal-header" style="border-bottom: none; padding: 25px 25px 10px;">
	                <h4 class="modal-title" style="font-weight: 700;">본인 확인</h4>
	            </div>
	            <div class="modal-body" style="padding: 10px 25px 25px;">
	                <p style="color: #666; margin-bottom: 15px;">보안을 위해 비밀번호를 입력해주세요.</p>
	                <input type="password" id="deleteUserPwd" placeholder="비밀번호 입력">
	                <div id="pwdErrorMsg" style="color:red; font-size:0.8em; margin-top:5px; display:none;">
	                    비밀번호가 일치하지 않습니다.
	                </div>
	            </div>
	            <div class="modal-footer" style="border-top: none; padding: 0 25px 25px; justify-content: center; gap: 10px;">
	                <button type="button" class="custom-btn btn-primary-custom" onclick="validatePwd();">확인</button>
	                <button type="button" class="custom-btn btn-danger-outline" data-dismiss="modal">취소</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<div class="modal fade" id="finalConfirmModal">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content" style="border-radius: 20px; border: none; box-shadow: 0 15px 35px rgba(0,0,0,0.1);">
	            <div class="modal-header" style="border-bottom: none; padding: 25px 25px 10px;">
	                <h4 class="modal-title" style="font-weight: 700; color: #dc3545;">회원 탈퇴 안내</h4>
	            </div>
	            <div class="modal-body text-center" style="padding: 10px 25px 25px;">
	                <p style="font-size: 16px; line-height: 1.6;">정말 탈퇴하시겠습니까?<br><span style="color: #999; font-size: 14px;">탈퇴 후에는 정보를 복구할 수 없습니다.</span></p>
	            </div>
	            <div class="modal-footer" style="border-top: none; padding: 0 25px 25px; justify-content: center; gap: 10px;">
	                <form action="delete.me" method="post" style="margin: 0;">
	                    <input type="hidden" name="userId" value="${loginUser.userId}">
	                    <button type="submit" class="custom-btn btn-danger-outline">탈퇴하기</button>
	                </form>
	                <button type="button" class="custom-btn btn-primary-custom" data-dismiss="modal">취소</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<c:if test="${not empty alertMsg}">
    <script>
        alert("${alertMsg}");
    </script>
    <c:remove var="alertMsg" scope="session" />
</c:if>


    
</div>


<script>
	$(function() {
	    // 모달 내 비밀번호 입력 시 "확인" 버튼 활성화 제어 (선택 사항)
	    $("#deleteUserPwd").on("input", function() {
	        const pwdValue = $(this).val().trim();
	        const $confirmBtn = $("#pwdCheckModal .btn-primary-custom");
	        
	        if(pwdValue !== "") {
	            $confirmBtn.prop("disabled", false).css("opacity", "1");
	        } else {
	            $confirmBtn.prop("disabled", true).css("opacity", "0.5");
	        }
	    });
	
	    // 엔터키를 눌렀을 때도 확인 버튼이 눌리도록 편의 기능 추가
	    $("#deleteUserPwd").on("keyup", function(e) {
	        if(e.key === "Enter" && $(this).val().trim() !== "") {
	            validatePwd();
	        }
	    });
	});
	
	function validatePwd() {
	    const userPwd = $("#deleteUserPwd").val();
	    const $errorMsg = $("#pwdErrorMsg");
	    const $confirmBtn = $("#pwdCheckModal .btn-primary-custom");
	    
	    if(userPwd.trim() === "") {
	        return; // 빈 값일 때는 실행 방지
	    }
	
	    // 통신 중 버튼 중복 클릭 방지
	    $confirmBtn.prop("disabled", true);
	
	    $.ajax({
	        url: "checkPwd.me",
	        type: "post",
	        data: { userPwd: userPwd },
	        success: function(result) {
	        	console.log("서버응답 : "+result)
	            if (result === "true") {
	                $("#pwdCheckModal").modal("hide");
	                $("#finalConfirmModal").modal("show");
	            } else {
	                $errorMsg.show();
	                $("#deleteUserPwd").val("").focus();
	                $confirmBtn.prop("disabled", true).css("opacity", "0.5"); // 틀리면 다시 비활성화
	            }
	        },
	        error: function() {
	            alert("서버와의 통신에 실패했습니다.");
	            $confirmBtn.prop("disabled", false);
	        }
	    });
	}
	
	// 모달이 닫힐 때 입력값 및 에러메시지 초기화 (다시 눌렀을 때 대비)
	$('.modal').on('hidden.bs.modal', function () {
	    $(this).find('input').val('');
	    $("#pwdErrorMsg").hide();
	});

</script>
        
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>


</body>
</html>

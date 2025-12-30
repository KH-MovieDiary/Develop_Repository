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
   Mypage CSS (완성본)
   - 섹션 외 영역은 배경색(회색) 노출
   - 섹션(section)만 흰 카드
   - footer 겹침 방지
   ========================= */

/* 0) 기본 리셋 */
html, body{
  margin: 0;
  padding: 0;
}

/* 1) 페이지 전체 배경은 body가 담당 */
body{
  background: #f4f6f8;
}

/* 2) wrap은 폭만 잡고 배경은 투명(섹션 밖 배경색이 보이게) */
.wrap{
  width: 70%;
  margin: 0 auto;

  background: transparent !important;   /* 기존 wrap 배경 제거 */
  height: auto !important;              /* 100vh 고정 금지 */
  min-height: calc(100vh - 120px);      /* footer까지 자연스럽게 밀리도록 */

  padding-top: 24px;
  padding-bottom: 24px;
  box-sizing: border-box;
}

/* 3) section은 흰색 카드로 고정 (섹션만 흰색) */
.section{
  background: #ffffff;                  /* 카드 배경 */
  margin-bottom: 40px;
  padding: 30px;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.06);

  overflow: hidden;                     /* 섹션 밖으로 비쳐 보이는 현상 방지 */
}

/* 섹션 제목 */
.section-title{
  font-size: 17px;
  font-weight: 700;
  margin-bottom: 20px;
  color: #111827;
}

/* =========================
   content1 : 프로필 / 회원정보
   ========================= */
.content1{
  background: #ffffff; /* section이 흰색이므로 명시적으로 통일 */
}

.content1-body{
  display: flex;
  gap: 40px;
  padding: 30px;
  align-items: stretch;
}

.profile-area{
  width: 280px;
  text-align: center;
}

.profile-img{
  width: 160px;
  height: 160px;
  margin: 0 auto 24px;
  border-radius: 50%;
  overflow: hidden;
  border: 3px solid #e5e7eb;
  background-color: #fafafa;
}

.profile-img img{
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.profile-area button{
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

.profile-area a button:hover{
  background-color: #e5e7eb;
}

.profile-info{
  margin-left: auto;
  width: 600px;
  padding: 28px 32px;
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  background-color: #ffffff;
  flex: 1;
}

.profile-info p{
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 14px;
  font-size: 15px;
  color: #111827;
}

.profile-info p span{
  width: 80px;
  font-weight: 600;
  color: #6b7280;
}

/* =========================
   공통 버튼
   ========================= */
.custom-btn{
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

.btn-primary-custom{
  background-color: #343a40 !important;
  color: white !important;
}
.btn-primary-custom:hover{
  background-color: #212529 !important;
}

.btn-danger-outline{
  background-color: #fff !important;
  border: 1px solid #dc3545 !important;
  color: #dc3545 !important;
}
.btn-danger-outline:hover{
  background-color: #dc3545 !important;
  color: #fff !important;
}

#deleteUserPwd{
  height: 48px;
  border-radius: 8px;
  border: 1px solid #e1e1e1;
  padding: 0 15px;
  width: 100%;
}

/* =========================
   공통 가로 스크롤 영역
   ========================= */
.horizontal-scroll{
  display: flex;
  gap: 20px;
  overflow-x: auto;
  overflow-y: hidden;
  flex-wrap: nowrap;
  padding-bottom: 10px;
}

.horizontal-scroll .item_content{
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

.horizontal-scroll .item_content:hover{
  transform: translateY(-2px);
}

/* =========================
   content2 : 위시리스트
   ========================= */
.poster_item{
  width: 100%;
  height: 260px;
  overflow: hidden;
}

.poster_item img{
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.title_item{
  margin-top: 8px;
  font-size: 14px;
  font-weight: 600;
  text-align: center;
}

.poster_fallback{
  width:100%;
  height:100%;
  display:flex;
  align-items:center;
  justify-content:center;
  font-size:12px;
  color:rgba(0,0,0,0.45);
  background: linear-gradient(135deg,rgba(125,211,252,0.12),rgba(167,139,250,0.10));
}

.title_item .title_txt{
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical; /* 오타 수정: ertical -> vertical */
  overflow: hidden;
}

/* =========================
   content3 / content4 : 감상평 카드
   ========================= */
.review-title{
  font-size: 14px;
  font-weight: 700;
  margin-bottom: 8px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.review-meta{
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #6b7280;
}

.review-date{
  margin-top: 6px;
  font-size: 11px;
  color: #9ca3af;
}

.empty-area{
  width: 100%;
  text-align: center;
  padding: 40px 0;
  color: #9ca3af;
}

/* content3 카드 */
.my-review-scroll{
  overflow-x: auto;
  overflow-y: hidden;
  padding-bottom: 6px;
  box-sizing: border-box;
}

.review-card{
  width: 190px;
  height: 190px;
  flex: 0 0 auto;
  border-radius: 14px;
  border: 1px solid rgba(0,0,0,0.08);
  background: #ffffff;
  box-shadow: 0 10px 28px rgba(0,0,0,0.10);
  padding: 12px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  color: #111;
  cursor: pointer;
}

.review-card .review-title{
  font-size: 13px;
  font-weight: 900;
  line-height: 1.25;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.review-card .review-movie{
  margin-top: 6px;
  font-size: 12px;
  color: #666;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.review-card .review-writer{
  margin-top: 6px;
  font-size: 12px;
  color: #444;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.review-card .review-meta{
  margin-top: 10px;
  display: flex;
  justify-content: space-between;
  gap: 8px;
  font-size: 11px;
  color: #555;
}

.review-card .pill{
  padding: 5px 8px;
  border-radius: 999px;
  background: rgba(0,0,0,0.05);
  border: 1px solid rgba(0,0,0,0.06);
  white-space: nowrap;
}

.review-card .review-date{
  margin-top: 8px;
  font-size: 11px;
  color: #888;
}

/* =========================
   content4(내가 쓴 댓글) UI 개선
   - 카드 폭 확대(날짜 줄바꿈 방지)
   - 삭제 버튼: 더 작게 + "삭제" 가로 표시
   - 감상문 제목: [제목] 형태 + bold + 검정색
   ========================= */

/* content4 카드만 폭 키우기 (기존 180px -> 220px) */
.content4 .horizontal-scroll .item_content{
  width: 220px;              /* 필요하면 230~240까지 올려도 됨 */
  min-height: 150px;
  box-sizing:; border-box;
  overflow: hidden;
}
	.content4 .comment-top{
	flex : 0 0 auto;
	}

/* 날짜가 안 내려가게(줄바꿈 금지 + 폭 충분히) */
.content4 .comment-top span{
  white-space: nowrap;
  font-size: 12px;
}

/* 삭제 버튼: 작게 + 가로 "삭제" */
.content4 .btn-del-comment{
  padding: 4px 8px;          /* 기존보다 작게 */
  font-size: 11px;           /* 글자 작게 */
  line-height: 1.1;
  border-radius: 6px;
  white-space: nowrap;       /* "삭\n제" 방지 */
}


/* 감상문 제목 링크: 파란색 제거 + bold + 눈에 띄게 */
.content4 .comment-review-link{
  color: #111827;            /* 검정 계열 */
  font-weight: 800;
  text-decoration: none;     /* 밑줄 제거(원하면 underline로 변경 가능) */
}

/* 제목 양끝에 [ ] 자동으로 붙이기 */
.content4 .comment-review-link::before{
  content: "[";
  margin-right: 2px;
  color: #111827;
  font-weight: 800;
}
.content4 .comment-review-link::after{
  content: "]";
  margin-left: 2px;
  color: #111827;
  font-weight: 800;
}

	/* (선택) 댓글 본문/제목 간 간격 조금 정리 */
	.content4 .comment-preview{
	  display : -webkit-box;
	  -webkit-line-clamp: 2;
	  -webkit-box-orient: vertical;
	  overflow: hidden;
	  line-height:1.35;
	  max-height:calc(1.35em *2);
	  margin-top: 6px;
	}
	
	.content4 .comment-review-link{
	 white-space:nowrap;
	 overflow: hidden;
	 text-overflow:ellipsis;
	  margin-top: 10px;
	  display: block;
	}


/* =========================
   footer 겹침 방지 (mypage에서만)
   ========================= */
#footer, footer{
  display: block !important;
  width: 100% !important;
  clear: both !important;
  position: static !important;
  float: none !important;
}

/* footer가 fixed 성격일 때 마지막 내용 가림 방지 */
.wrap::after{
  content:"";
  display:block;
  height: 140px;
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

<!-- content2 : 위시리스트 -->
<section class="section content2">
  <div class="section-title">위시리스트 (좋아요 / 싫어요 한 영화)</div>

  <div class="horizontal-scroll">
    <c:choose>
      <c:when test="${empty wishList}">
        <div class="empty-area">위시리스트에 담긴 영화가 없습니다.</div>
      </c:when>

      <c:otherwise>
        <c:forEach var="m" items="${wishList}">
          <div class="item_content" data-movie-id="${m.movieId}">
            <div class="poster_item js-poster" data-movie-id="${m.movieId}">
  				<div class="poster_fallback">LOADING...</div>	
			</div>
            
            

            <div class="title_item">
              <div class="title_txt">
                <c:out value="${m.movieTitle}" />
              </div>
            </div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>
</section>





    <!-- content3 : 내가 쓴 감상평 (실시간 감상문 카드 스타일) -->
	<section class="section content3">
	    <div class="section-title">내가 쓴 감상평</div>
	
	    <div class="horizontal-scroll my-review-scroll">
	        <c:choose>
	            <c:when test="${empty myReviewList}">
	                <div class="empty-area">작성한 감상평이 없습니다.</div>
	            </c:when>
	
	            <c:otherwise>
	                <c:forEach var="r" items="${myReviewList}">
	                    <div class="review-card"
	                         onclick="location.href='${pageContext.request.contextPath}/detail.review?rno=${r.reviewId}'">
	
	                        <div>
	                            <div class="review-title">
	                                <c:out value="${r.reviewTitle}" />
	                            </div>
	
	                            <div class="review-movie">
	                                🎬 <c:out value="${r.movieTitle}" />
	                            </div>
	
	                            <div class="review-writer">
	                                ✍️
	                                <c:choose>
	                                    <c:when test="${not empty r.nickname}">
	                                        <c:out value="${r.nickname}" />
	                                    </c:when>
	                                    <c:otherwise>
	                                        <c:out value="${r.userId}" />
	                                    </c:otherwise>
	                                </c:choose>
	                            </div>
	                        </div>
	
	                        <div>
	                            <div class="review-meta">
	                                <div class="pill">👀 ${r.viewCount}</div>
	                                <div class="pill">👍 ${r.likeCount}</div>
	                            </div>
	
	                            <div class="review-date">
	                                📅 <fmt:formatDate value="${r.createDate}" pattern="MM월 dd일, yy"/>
	                            </div>
	                        </div>
	                    </div>
	                </c:forEach>
	            </c:otherwise>
	        </c:choose>
	    </div>
	</section>


    <!-- content4 -->
    <!-- content4 -->
<section class="section content4">
  <div class="section-title">내가 쓴 댓글</div>

  <div class="horizontal-scroll">
    <c:choose>
      <c:when test="${empty myCommentList}">
        <div class="empty-area">작성한 댓글이 없습니다.</div>
      </c:when>

      <c:otherwise>
        <c:forEach var="cmt" items="${myCommentList}">
          <div class="item_content">

            <div class="comment-top">
              <span>
                <fmt:formatDate value="${cmt.createDate}" pattern="yyyy-MM-dd"/>
              </span>
              <button type="button"
                      class="btn-del-comment"
                      data-comment-id="${cmt.commentId}">
                삭제
              </button>
            </div>

            <div class="comment-preview">
              <c:out value="${cmt.content}" />
            </div>

            <a class="comment-review-link"
               href="${pageContext.request.contextPath}/detail.review?rno=${cmt.reviewId}">
              <c:out value="${cmt.reviewTitle}" />
            </a>

          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>
</section>

<!-- 삭제 확인 모달 (Bootstrap4 기준) -->
<div class="modal fade" id="commentDeleteModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius: 14px;">
      <div class="modal-header">
        <h5 class="modal-title">댓글 삭제</h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <div class="modal-body">
        <div style="font-size:13px; color:#111; margin-bottom:10px;">
          정말로 삭제하시겠습니까?
        </div>

        <div id="delCommentFullText"
             style="white-space:pre-wrap; background:#f8f9fa; padding:10px; border-radius:10px; font-size:13px;">
        </div>
        
			<!-- TODO: REVIEW_COMMENT_LIKE 테이블 생성 후 반영 -->
<!--         <div style="margin-top:10px; font-size:12px; color:#6b7280;"> -->
<!--           좋아요 <span id="delLikeCount">0</span> / -->
<!--           싫어요 <span id="delDislikeCount">0</span> -->
<!--         </div> -->

        <input type="hidden" id="delCommentId" />
      </div>

      <div class="modal-footer">
        <button type="button" class="custom-btn btn-danger-outline" id="btnConfirmDeleteComment">삭제</button>
        <button type="button" class="custom-btn btn-primary-custom" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

    
    
    
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
$(function () {

  /* =========================
     (1) 탈퇴 비밀번호 모달 UX
     ========================= */
  $("#deleteUserPwd").on("input", function() {
    const pwdValue = $(this).val().trim();
    const $confirmBtn = $("#pwdCheckModal .btn-primary-custom");

    if (pwdValue !== "") {
      $confirmBtn.prop("disabled", false).css("opacity", "1");
    } else {
      $confirmBtn.prop("disabled", true).css("opacity", "0.5");
    }
  });

  $("#deleteUserPwd").on("keyup", function(e) {
    if (e.key === "Enter" && $(this).val().trim() !== "") {
      validatePwd();
    }
  });

  // 모달 닫히면 초기화
  $('.modal').on('hidden.bs.modal', function () {
    $(this).find('input').val('');
    $("#pwdErrorMsg").hide();
  });


  /* =========================
     (2) 댓글 삭제 모달
     ========================= */
  $(document).on("click", ".btn-del-comment", function () {
    var commentId = $(this).data("comment-id");

    $.ajax({
      url: "${pageContext.request.contextPath}/mypage/comment/info",
      type: "get",
      dataType: "json",
      data: { commentId: commentId },
      success: function (res) {
        if (res.result === "LOGIN") {
          location.href = "${pageContext.request.contextPath}/login.me";
          return;
        }

        $("#delCommentId").val(commentId);
        $("#delCommentFullText").text(res.content || "");
        $("#delLikeCount").text(res.likeCount == null ? 0 : res.likeCount);
        $("#delDislikeCount").text(res.dislikeCount == null ? 0 : res.dislikeCount);

        $("#commentDeleteModal").modal("show");
      },
      error: function (xhr) {
        alert("댓글 정보를 불러오지 못했습니다. (" + xhr.status + ")");
      }
    });
  });

  $("#btnConfirmDeleteComment").on("click", function () {
    var commentId = $("#delCommentId").val();

    $.ajax({
      url: "${pageContext.request.contextPath}/mypage/comment/delete",
      type: "post",
      data: { commentId: commentId },
      success: function (res) {
        if (res === "LOGIN") {
          location.href = "${pageContext.request.contextPath}/login.me";
          return;
        }
        if (res === "OK") {
          $("#commentDeleteModal").modal("hide");
          location.reload();
        } else {
          alert("삭제 실패");
        }
      },
      error: function (xhr) {
        alert("삭제 요청 실패 (" + xhr.status + ")");
      }
    });
  });


  /* =========================
     (3) 위시리스트 포스터 비동기 로딩
     ========================= */
  loadWishListPostersAsync();

}); // $(function) 끝


/* =========================
   (A) 비밀번호 검증 함수
   ========================= */
function validatePwd() {
  const userPwd = $("#deleteUserPwd").val();
  const $errorMsg = $("#pwdErrorMsg");
  const $confirmBtn = $("#pwdCheckModal .btn-primary-custom");

  if (userPwd.trim() === "") return;

  $confirmBtn.prop("disabled", true);

  $.ajax({
    url: "checkPwd.me",
    type: "post",
    data: { userPwd: userPwd },
    success: function (result) {
      if (result === "true") {
        $("#pwdCheckModal").modal("hide");
        $("#finalConfirmModal").modal("show");
      } else {
        $errorMsg.show();
        $("#deleteUserPwd").val("").focus();
        $confirmBtn.prop("disabled", true).css("opacity", "0.5");
      }
    },
    error: function () {
      alert("서버와의 통신에 실패했습니다.");
      $confirmBtn.prop("disabled", false);
    }
  });
}


/* =========================
   (B) 위시리스트 포스터 로딩 함수
   ========================= */
function loadWishListPostersAsync() {

  // 1) 화면에 있는 movieId 수집
  var ids = [];
  $(".content2 .item_content").each(function () {
    var id = $(this).data("movie-id");
    if (id != null && String(id).trim() !== "") ids.push(String(id));
  });

  if (ids.length === 0) return;

  // 2) 서버에 포스터 URL 요청
  $.ajax({
    url: "${pageContext.request.contextPath}/mypage/wishlist/posters",
    type: "post",
    contentType: "application/json; charset=UTF-8",
    dataType: "json",
    data: JSON.stringify({ movieIds: ids }),
    success: function (res) {

      if (!res) return;

      if (res.result === "LOGIN") {
        location.href = "${pageContext.request.contextPath}/login.me";
        return;
      }

      if (res.result !== "OK") return;

      var posters = res.posters || {};

      // 3) posters 반영
      Object.keys(posters).forEach(function (movieId) {
        var url = posters[movieId];

        var $card = $(".content2 .item_content[data-movie-id='" + movieId + "']");
        if ($card.length === 0) return;

        var $poster = $card.find(".poster_item");

        if (url && String(url).trim() !== "") {
          // 이미지로 교체 + onerror fallback
          $poster.html(
            '<img src="' + url + '" alt="poster" ' +
            'onerror="this.onerror=null; this.parentElement.innerHTML=\\\'<div class=&quot;poster_fallback&quot;>NO POSTER</div>\\\';">'
          );
        } else {
          // 포스터 없음
          $poster.html('<div class="poster_fallback">NO POSTER</div>');
        }
      });
    },
    error: function () {
      // 실패해도 페이지는 정상 동작해야 함
      $(".content2 .poster_item").html('<div class="poster_fallback">NO POSTER</div>');
    }
  });
}
</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>

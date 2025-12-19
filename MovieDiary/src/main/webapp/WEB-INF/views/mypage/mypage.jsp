<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    height: 100vh;
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

.profile-area a button {
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

                <a href="/member/update"><button>회원 정보 수정</button></a>
                <a href="/member/delete"><button>회원 탈퇴</button></a>
            </div>

            <div class="profile-info">
                <p><span>닉네임</span> ${loginUser.nickname}</p>
                <p><span>나이</span> ${loginUser.age}</p>
                <p><span>성별</span> ${loginUser.gender}</p>
                <p><span>장르</span> ${loginUser.favoriteGenre}</p>
                <p><span>가입일</span> ${loginUser.createDate}</p>
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

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>

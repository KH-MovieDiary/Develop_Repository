<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MainPage</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        :root{
            --bg: #0b1220;
            --panel: rgba(255,255,255,0.06);
            --panel2: rgba(255,255,255,0.08);
            --text: rgba(255,255,255,0.92);
            --muted: rgba(255,255,255,0.65);
            --line: rgba(255,255,255,0.10);
            --accent: #7dd3fc;
        }

        body{
            background: radial-gradient(1200px 600px at 20% 0%, rgba(125,211,252,0.20), transparent 55%),
                        radial-gradient(900px 500px at 90% 10%, rgba(167,139,250,0.18), transparent 55%),
                        radial-gradient(900px 500px at 50% 100%, rgba(52,211,153,0.12), transparent 55%),
                        var(--bg);
            color: var(--text);
        }

        #wrap {
            width: 70%;
            height: 100vh;
            margin: auto;
            padding-top: 24px;
            padding-bottom: 24px;
            box-sizing: border-box;
        }

        #content {
            width: 90%;
            height: 100%;
            margin: auto;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        /* 메인 패널 */
        #movieRank {
            width: 100%;
            height: 62%;
            margin: auto;
            display: flex;
            flex-direction: column;
            background: linear-gradient(180deg, rgba(255,255,255,0.06), rgba(255,255,255,0.04));
            border: 1px solid var(--line);
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 18px 60px rgba(0,0,0,0.35);
        }

        #live_comment {
            width: 100%;
            height: 32%;
            margin: auto;
            border-radius: 18px;
            border: 1px solid var(--line);
            background: rgba(255,255,255,0.05);
            box-shadow: 0 18px 60px rgba(0,0,0,0.25);
        }

        /* 헤더 */
        #header_movieRank {
            width: 100%;
            height: 72px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 18px;
            box-sizing: border-box;
            background: rgba(255,255,255,0.06);
            border-bottom: 1px solid var(--line);
        }

        .rank-title{
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .rank-title .h1{
            font-size: 18px;
            font-weight: 800;
            letter-spacing: -0.2px;
        }

        .rank-title .sub{
            font-size: 12px;
            color: var(--muted);
        }

        .more-btn{
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 12px;
            border-radius: 12px;
            border: 1px solid var(--line);
            background: rgba(255,255,255,0.06);
            color: var(--text);
            font-size: 12px;
            cursor: pointer;
            user-select: none;
        }

        .more-btn:hover{
            background: rgba(255,255,255,0.10);
        }

        /* 컨텐츠 영역 */
        #content_movieRank {
            width: 100%;
            height: calc(100% - 72px);
            padding: 16px 16px 18px 16px;
            box-sizing: border-box;
            position: relative;
            overflow: hidden;
        }

        /* 페이드 마스크(양쪽 흐림) */
        #content_movieRank::before,
        #content_movieRank::after{
            content:"";
            position:absolute;
            top:0;
            width: 80px;
            height: 100%;
            z-index: 5;
            pointer-events: none;
        }
        #content_movieRank::before{
            left:0;
            background: linear-gradient(90deg, rgba(11,18,32,1), rgba(11,18,32,0));
        }
        #content_movieRank::after{
            right:0;
            background: linear-gradient(270deg, rgba(11,18,32,1), rgba(11,18,32,0));
        }

        /* 자동 슬라이드 트랙 */
        .slider{
            width: 100%;
            height: 100%;
            display:flex;
            align-items:center;
            position: relative;
        }

        .track{
            display: flex;
            align-items: center;
            gap: 14px;
            will-change: transform;
            animation: scrollX 38s linear infinite;
        }

        /* 마우스 올리면 잠깐 멈춤(자연스러운 UX) */
        .slider:hover .track{
            animation-play-state: paused;
        }

        @keyframes scrollX{
            0%   { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        /* 카드 */
        .item_content {
            width: 165px;
            height: 260px;
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.10);
            background: rgba(255,255,255,0.06);
            cursor: pointer;
            flex: 0 0 auto;
            box-shadow: 0 14px 40px rgba(0,0,0,0.25);
            transform: translateZ(0);
        }

        .item_content:hover{
            border-color: rgba(125,211,252,0.35);
            box-shadow: 0 18px 55px rgba(0,0,0,0.35);
        }

        .poster_item {
            width: 100%;
            height: 78%;
            background: rgba(255,255,255,0.04);
            position: relative;
        }

        .poster_item img{
            width: 100%;
            height: 100%;
            object-fit: cover;
            display:block;
        }

        .poster_fallback{
            width:100%;
            height:100%;
            display:flex;
            align-items:center;
            justify-content:center;
            color: rgba(255,255,255,0.55);
            font-size: 12px;
            background: linear-gradient(135deg, rgba(125,211,252,0.12), rgba(167,139,250,0.10));
        }

        .title_item {
            width: 100%;
            height: 22%;
            padding: 10px 10px;
            box-sizing: border-box;
            display:flex;
            align-items:center;
            justify-content:center;
            text-align:center;
            font-weight: 700;
            font-size: 13px;
            line-height: 1.2;
            color: rgba(255,255,255,0.92);
            background: rgba(0,0,0,0.18);
        }

        /* 2줄까지만 보이게 */
        .title_item .title_txt{
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* live_comment 자리 기본 UI(기능 없음, 틀만) */
        #live_comment{
            padding: 18px;
            box-sizing: border-box;
        }
        .live-header{
            display:flex;
            align-items:center;
            justify-content:space-between;
            margin-bottom: 12px;
        }
        .live-header .h{
            font-size: 15px;
            font-weight: 800;
        }
        .live-header .sub{
            font-size: 12px;
            color: var(--muted);
        }
        .live-body{
            height: calc(100% - 30px);
            border-radius: 14px;
            border: 1px dashed rgba(255,255,255,0.14);
            display:flex;
            align-items:center;
            justify-content:center;
            color: rgba(255,255,255,0.55);
            background: rgba(255,255,255,0.03);
        }
    </style>
</head>

<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div id="wrap">
        <div id="content">
            <div id="movieRank">
                <div id="header_movieRank">
                    <div class="rank-title">
                        <div class="h1">현재 상영작</div>
                        <div class="sub">마우스를 올리면 잠깐 멈추고, 클릭하면 상세 모달이 열려요</div>
                    </div>
                    <div><a href="${contextRoot}/movieInfo.mo">더보기</a></div>              
                </div>

                <div id="content_movieRank">

                    
                    <div class="slider">
                        <div class="track">

                            <!-- 1회차 -->
                            <c:forEach var="m" items="${top5}" varStatus="st">
                                <div class="item_content" data-tmdb-id="${m.tmdbId}">
                                    <div class="poster_item">
                                        <c:choose>
                                            <c:when test="${not empty m.posterUrl}">
                                                <img src="${m.posterUrl}" alt="poster" />
                                            </c:when>
                                            <c:otherwise>
                                                <div class="poster_fallback">NO POSTER</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="title_item">
                                        <div class="title_txt"><c:out value="${m.title}" /></div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- 2회차(복제) -->
                            <c:forEach var="m" items="${top5}" varStatus="st">
                                <div class="item_content" data-tmdb-id="${m.tmdbId}">
                                    <div class="poster_item">
                                        <c:choose>
                                            <c:when test="${not empty m.posterUrl}">
                                                <img src="${m.posterUrl}" alt="poster" />
                                            </c:when>
                                            <c:otherwise>
                                                <div class="poster_fallback">NO POSTER</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="title_item">
                                        <div class="title_txt"><c:out value="${m.title}" /></div>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </div>

                </div>
            </div>

            <div id="live_comment">
                <div class="live-header">
                    <div class="h">실시간 감상문</div>
                    <div class="sub">여기는 나중에 기능 붙이면 돼요</div>
                </div>
                <div class="live-body">Live comment area</div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <jsp:include page="/WEB-INF/views/common/movieModal.jsp" />

    <script>
        document.addEventListener("click", function(e){
            var card = e.target.closest(".item_content");
            if(!card) return;

            var tmdbId = card.getAttribute("data-tmdb-id");
            if(!tmdbId) return;

            openModal(tmdbId);
        });
    </script>

</body>
</html>

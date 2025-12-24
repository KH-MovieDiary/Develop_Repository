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
            padding: 18px;
            box-sizing: border-box;
        }

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

        #content_movieRank {
            width: 100%;
            height: calc(100% - 72px);
            padding: 16px 16px 18px 16px;
            box-sizing: border-box;
            position: relative;
            overflow: hidden;
        }

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

        .slider:hover .track{
            animation-play-state: paused;
        }

        @keyframes scrollX{
            0%   { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

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

        .poster_item { width: 100%; height: 78%; background: rgba(255,255,255,0.04); }
        .poster_item img{ width: 100%; height: 100%; object-fit: cover; display:block; }
        .poster_fallback{
            width:100%; height:100%;
            display:flex; align-items:center; justify-content:center;
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
        .title_item .title_txt{
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .live-header{
            display:flex;
            align-items:flex-end;
            justify-content:space-between;
            margin-bottom: 12px;
        }
        .live-header .h{
            font-size: 15px;
            font-weight: 800;
        }
        .live-header .sub{
            font-size: 12px;
            color: rgba(255,255,255,0.65);
        }

        .live-body{
            height: calc(100% - 30px);
            border-radius: 14px;
            border: 1px dashed rgba(255,255,255,0.14);
            background: rgba(255,255,255,0.95); /* 흰 박스 */
            padding: 12px;
            box-sizing: border-box;
            overflow: hidden;
        }

        #sub{
            height: 100%;
            display: flex;
            gap: 12px;
            align-items: stretch;
            overflow-x: auto;   
            overflow-y: hidden;
            padding-bottom: 6px;
            box-sizing: border-box;
        }

        #sub::-webkit-scrollbar{ height: 8px; }
        #sub::-webkit-scrollbar-thumb{ background: rgba(0,0,0,0.15); border-radius: 8px; }
        #sub::-webkit-scrollbar-track{ background: transparent; }

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
        }

        .review-title{
            font-size: 13px;
            font-weight: 900;
            line-height: 1.25;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .review-movie{
            margin-top: 6px;
            font-size: 12px;
            color: #666;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .review-writer{
            margin-top: 6px;
            font-size: 12px;
            color: #444;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .review-meta{
            margin-top: 10px;
            display: flex;
            justify-content: space-between;
            gap: 8px;
            font-size: 11px;
            color: #555;
        }

        .review-meta .pill{
            padding: 5px 8px;
            border-radius: 999px;
            background: rgba(0,0,0,0.05);
            border: 1px solid rgba(0,0,0,0.06);
            white-space: nowrap;
        }

        .review-date{
            margin-top: 8px;
            font-size: 11px;
            color: #888;
        }

        .empty-box{
            width: 100%;
            height: 100%;
            display:flex;
            align-items:center;
            justify-content:center;
            color:#777;
            font-size: 13px;
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
                            <c:forEach var="m" items="${top5}">
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
                            <c:forEach var="m" items="${top5}">
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
                    <div class="sub"></div>
                </div>

                <div class="live-body">
                    <div id="sub"></div>
                </div>
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

        function formatDate(v){
            if(!v) return "";
            try{
                var s = String(v);
                if(s.length >= 10) return s.substring(0,10);
                return s;
            }catch(e){
                return "";
            }
        }

        $(function(){
            $.ajax({
                url: "<c:url value='/reviewGet'/>",
                dataType: "json",
                success: function(data){
                    console.log("ajax success:", data);

                    if(!data || data.length === 0){
                        $("#sub").html("<div class='empty-box'>아직 감상문이 없습니다</div>");
                        return;
                    }

                    var html = "";

                    var limit = Math.min(5, data.length);

                    for(var i=0; i<limit; i++){
                        var r = data[i];

                        var reviewTitle = (r.reviewTitle == null) ? "" : r.reviewTitle;
                        var movieTitle  = (r.movieTitle  == null) ? "" : r.movieTitle;
                        var writer      = (r.nickname   == null || r.nickname === "") ? (r.userId == null ? "" : r.userId) : r.nickname;

                        var viewCount   = (r.viewCount == null) ? 0 : r.viewCount;
                        var likeCount   = (r.likeCount == null) ? 0 : r.likeCount;
                        var createDate  = formatDate(r.createDate);

                        html += ""
                          + "<div class='review-card'>"
                          +   "<div>"
                          +     "<div class='review-title'>" + reviewTitle + "</div>"
                          +     "<div class='review-movie'>🎬 " + movieTitle + "</div>"
                          +     "<div class='review-writer'>✍️ " + writer + "</div>"
                          +   "</div>"
                          +   "<div>"
                          +     "<div class='review-meta'>"
                          +       "<div class='pill'>👀 " + viewCount + "</div>"
                          +       "<div class='pill'>👍 " + likeCount + "</div>"
                          +     "</div>"
                          +     "<div class='review-date'>📅 " + createDate + "</div>"
                          +   "</div>"
                          + "</div>";
                    }

                    $("#sub").html(html);
                },
                error: function(xhr){
                    console.log("ajax error:", xhr.status, xhr.responseText);
                    $("#sub").html("<div class='empty-box'>불러오기 실패 ("+xhr.status+")</div>");
                }
            });
        });
    </script>

</body>
</html>

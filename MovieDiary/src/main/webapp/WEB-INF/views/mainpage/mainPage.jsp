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
	        background:
	            radial-gradient(1200px 600px at 20% 0%, rgba(125,211,252,0.20), transparent 55%),
	            radial-gradient(900px 500px at 90% 10%, rgba(167,139,250,0.18), transparent 55%),
	            radial-gradient(900px 500px at 50% 100%, rgba(52,211,153,0.12), transparent 55%),
	            var(--bg);
	        color: var(--text);
	    }
	
	    #wrap{
	        width: 70%;
	        min-height: 100vh;
	        margin: auto;
	        padding: 24px 0;
	        box-sizing: border-box;
	    }
	
	    #content{
	        width: 90%;
	        margin: auto;
	        display: flex;
	        flex-direction: column;
	        gap: 22px;
	    }
	
	
	    #movieRank{
	        width: 100%;
	        height: 430px;
	        display: flex;
	        flex-direction: column;
	        background: linear-gradient(180deg, rgba(255,255,255,0.06), rgba(255,255,255,0.04));
	        border: 1px solid var(--line);
	        border-radius: 18px;
	        overflow: hidden;
	        box-shadow: 0 18px 60px rgba(0,0,0,0.35);
	    }
	
	    #header_movieRank{
	        height: 72px;
	        display: flex;
	        align-items: center;
	        justify-content: space-between;
	        padding: 0 18px;
	        background: rgba(255,255,255,0.06);
	        border-bottom: 1px solid var(--line);
	        position: relative;
	    }
	
	    #header_movieRank::after{
	        content:"";
	        position:absolute;
	        bottom:0;
	        left:18px;
	        width:60px;
	        height:3px;
	        background: linear-gradient(90deg, var(--accent), transparent);
	        border-radius: 999px;
	    }
	
	    .rank-title{
	        display: flex;
	        flex-direction: column;
	        gap: 4px;
	    }
	
	    .rank-title .h1{
	        font-size: 18px;
	        font-weight: 800;
	        letter-spacing: -0.3px;
	    }
	
	    #content_movieRank{
	        height: calc(100% - 72px);
	        padding: 22px 16px;
	        position: relative;
	        overflow: hidden;
	    }
	
	    #content_movieRank::before,
	    #content_movieRank::after{
	        content:"";
	        position:absolute;
	        top:0;
	        width:80px;
	        height:100%;
	        z-index:5;
	        pointer-events:none;
	    }
	
	    #content_movieRank::before{
	        left:0;
	        background: linear-gradient(90deg, #0b1220, transparent);
	    }
	
	    #content_movieRank::after{
	        right:0;
	        background: linear-gradient(270deg, #0b1220, transparent);
	    }
	
	    .slider{
	        height:100%;
	        display:flex;
	        align-items:center;
	    }
	
	    .track{
	        display:flex;
	        gap:14px;
	        animation: scrollX 38s linear infinite;
	        will-change: transform;
	    }
	
	    .slider:hover .track{
	        animation-play-state: paused;
	    }
	
	    @keyframes scrollX{
	        0%{ transform: translateX(0); }
	        100%{ transform: translateX(-50%); }
	    }
	
	    .item_content{
	        width:175px;
	        height:300px;
	        border-radius:16px;
	        overflow:hidden;
	        background: rgba(255,255,255,0.06);
	        border:1px solid rgba(255,255,255,0.10);
	        box-shadow:0 14px 40px rgba(0,0,0,0.25);
	        cursor:pointer;
	        transition: transform 0.2s ease, box-shadow 0.2s ease;
	    }
	
	    .item_content:hover{
	        transform: translateY(-6px) scale(1.02);
	        box-shadow:0 20px 48px rgba(0,0,0,0.38);
	    }
	
	    .poster_item{
	        height:82%;
	        position:relative;
	    }
	
	    .poster_item::after{
	        content:"";
	        position:absolute;
	        bottom:0;
	        left:0;
	        width:100%;
	        height:40%;
	        background: linear-gradient(to top, rgba(0,0,0,0.45), transparent);
	    }
	
	    .poster_item img{
	        width:100%;
	        height:100%;
	        object-fit:cover;
	        display:block;
	    }
	
	    .poster_fallback{
	        height:100%;
	        display:flex;
	        align-items:center;
	        justify-content:center;
	        font-size:12px;
	        color:rgba(255,255,255,0.6);
	        background: linear-gradient(135deg, rgba(125,211,252,0.12), rgba(167,139,250,0.10));
	    }
	
	    .title_item{
	        height:18%;
	        padding:12px 10px;
	        display:flex;
	        align-items:center;
	        justify-content:center;
	        font-size:13px;
	        font-weight:700;
	        text-align:center;
	        background: rgba(0,0,0,0.25);
	    }

	    #live_comment,
	    #popular_review{
	        border-radius:18px;
	        border:1px solid var(--line);
	        background: rgba(255,255,255,0.05);
	       box-shadow: 0 0 30px rgba(0,0,0,0.2);
	        padding:18px;
	    }
	
	    .live-header{
	        display:flex;
	        justify-content:space-between;
	        margin-bottom:12px;
	    }
	
	    .live-header .h{
	        font-size:15px;
	        font-weight:800;
	    }
	
	    .live-body{
	        background:#fff;
	        border-radius:14px;
	        padding:12px;
	        height: calc(100% - 30px);
	        overflow:hidden;
	    }
	
	    #sub,
	    #popular_sub{
	        display:flex;
	        gap:12px;
	        overflow-x:auto;
	        padding-bottom:6px;
	    }
	
	    #sub::-webkit-scrollbar,
	    #popular_sub::-webkit-scrollbar{
	        height:8px;
	    }
	
	    #sub::-webkit-scrollbar-thumb,
	    #popular_sub::-webkit-scrollbar-thumb{
	        background: linear-gradient(180deg, #bbb, #999);
	        border-radius:8px;
	    }
	
	    .review-card{
	        width:190px;
	        height:190px;
	        padding:12px;
	        border-radius:14px;
	        background: linear-gradient(180deg, #ffffff, #f8f8f8);
	        border:1px solid rgba(0,0,0,0.08);
	        box-shadow:0 10px 28px rgba(0,0,0,0.10);
	        display:flex;
	        flex-direction:column;
	        justify-content:space-between;
	        cursor:pointer;
	        transition: transform 0.15s ease, box-shadow 0.15s ease;
	    }
	
	    .review-card:hover{
	        transform: translateY(-6px);
	        box-shadow:0 16px 36px rgba(0,0,0,0.22);
	    }
	
	    .review-title{
	        font-size:13px;
	        font-weight:900;
	        line-height:1.25;
	        overflow:hidden;
	        display:-webkit-box;
	        -webkit-line-clamp:2;
	        -webkit-box-orient:vertical;
	    }
	
	    .review-movie,
	    .review-writer{
	        font-size:12px;
	        color:#555;
	        margin-top:6px;
	        white-space:nowrap;
	        overflow:hidden;
	        text-overflow:ellipsis;
	    }
	
	    .review-meta{
	        display:flex;
	        justify-content:space-between;
	        font-size:11px;
	        margin-top:8px;
	    }
	
	    .review-meta .pill{
	        padding:5px 8px;
	        border-radius:999px;
	        background:#f1f1f1;
	        border:1px solid #e5e5e5;
	    }
	
	    .review-date{
	        font-size:11px;
	        color:#888;
	        margin-top:6px;
	    }
	
	    .empty-box{
	        height:100%;
	        display:flex;
	        align-items:center;
	        justify-content:center;
	        color:#777;
	        font-size:13px;
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
                        <div class="sub"></div>
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
            <div id="popular_review">
		    <div class="live-header">
		        <div class="h">인기글 TOP 5</div>
		        <div class="sub"></div>
		    </div>
		
		    <div class="live-body">
		        <div id="popular_sub"></div>
    </div>
</div>
            
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/movieModal.jsp" />

    <script>
    document.addEventListener("click", function(e){

        var movieCard = e.target.closest(".item_content");
        if(movieCard){
            var tmdbId = movieCard.getAttribute("data-tmdb-id");
            if(tmdbId) openModal(tmdbId);
            return; 
        }

        var reviewCard = e.target.closest(".review-card");
        if(reviewCard){
            var reviewId = reviewCard.getAttribute("data-review-id");
            if(!reviewId) return;

            location.href = "<c:url value='/detail.review'/>?rno=" + reviewId;
            return;
        }
    });

    
    function formatDate(v){
        if(!v) return "";

        var nums = String(v).match(/\d+/g);

        // 예: ["12","29","20"] 또는 ["2025","12","29"]
        if(nums.length === 3){
            // 12월 29, 20  → 2020-12-29 처럼 오면
            if(nums[0].length === 2){
                return nums[2] + "-" +
                       nums[0].padStart(2, "0") + "-" +
                       nums[1].padStart(2, "0");
            }
        }

        // 2025-12-29 같은 정상 형태
        if(nums.length >= 3){
            return nums[0] + "-" +
                   nums[1].padStart(2, "0") + "-" +
                   nums[2].padStart(2, "0");
        }

        return v;
    }

    function renderReviewCards(targetSelector, data){
        if(!data || data.length === 0){
            $(targetSelector).html("<div class='empty-box'>아직 글이 없습니다</div>");
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
              + "<div class='review-card' data-review-id='" + r.reviewId + "' style='cursor:pointer;'>"
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

        $(targetSelector).html(html);
    }

    $(function(){
        $.ajax({
            url: "<c:url value='/reviewGet'/>",
            dataType: "json",
            success: function(data){
                renderReviewCards("#sub", data);
            },
            error: function(xhr){
                $("#sub").html("<div class='empty-box'>불러오기 실패 ("+xhr.status+")</div>");
            }
        });

        $.ajax({
            url: "<c:url value='/reviewPopularTop5'/>",
            dataType: "json",
            success: function(data){
                renderReviewCards("#popular_sub", data);
            },
            error: function(xhr){
                $("#popular_sub").html("<div class='empty-box'>불러오기 실패 ("+xhr.status+")</div>");
            }
        });
    });
	</script>


</body>
</html>

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

        #wrap {
            width: 70%;
            height: 100vh;
            margin: auto;
            background-color: lightblue;
        }

        #content {
            width: 90%;
            height: 100vh;
            margin: auto;
            background-color: aquamarine;
            display: flex;
            flex-direction: column;
        }

        #movieRank {
            width: 100%;
            height: 60%;
            border-style: dashed;
            background-color: burlywood;
            margin: auto;
            display: flex;
            flex-direction: column;
        }

        #live_comment {
            width: 100%;
            height: 30%;
            background-color: khaki;
            margin: auto;
            border-style: dashed;
        }

        #header_movieRank {
            width: 100%;
            height: 12%;
            background-color: white;
        }

        #content_movieRank {
            width: 100%;
            height: 88%;
            background-color: white;
            border: 2px solid red;

            display: flex;
            justify-content: flex-start;
            gap: 20px;
            margin: auto;
            align-items: center;
        }

        .item_content {
            width: 25%;
            height: 60%;
            background-color: white;
            border: 2px dashed blue;
            margin: 10px;
            display: flex;
            flex-direction: column;
            cursor: pointer;
        }

        .poster_item {
            border: 2px dashed pink;
            width: 100%;
            height: 70%;
        }

        .title_item {
            border: 2px dashed green;
            width: 100%;
            height: 30%;
        }

        .modal-backdrop{
            display:none;
            position:fixed;
            left:0; top:0;
            width:100%; height:100%;
            background: rgba(0,0,0,.45);
            z-index:9999;
            justify-content:center;
            align-items:center;
            padding: 20px;
            box-sizing:border-box;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif;
        }
        .modal-box{
            width: min(900px, 95vw);
            height: min(720px, 92vh);
            background:#fff;
            border-radius: 18px;
            overflow:hidden;
            box-shadow: 0 18px 60px rgba(0,0,0,.25);
            display:flex;
            flex-direction: column;
        }
        .modal-top{
            height: 56px;
            display:flex;
            align-items:center;
            justify-content:space-between;
            padding: 0 18px;
            border-bottom: 1px solid #eee;
            box-sizing:border-box;
            font-weight: 800;
        }
        .modal-close{
            border:none;
            background:#111;
            color:#fff;
            padding: 10px 14px;
            border-radius: 12px;
            font-weight: 700;
            cursor:pointer;
        }
        .modal-main{
            flex:1;
            display:flex;
            flex-direction:column;
            background:#fff;
        }

        .modal-movie-area{
            height: 52%;
            border-bottom: 1px solid #eee;
            display:flex;
            gap: 18px;
            padding: 18px;
            box-sizing:border-box;
        }
        .modal-poster{
            width: 32%;
            min-width: 220px;
            background:#f3f4f6;
            border-radius: 14px;
            overflow:hidden;
            display:flex;
            align-items:center;
            justify-content:center;
            color:#666;
            font-weight:700;
        }
        .modal-poster img{
            width:100%;
            height:100%;
            object-fit:cover;
            display:block;
        }

        .modal-info{
            flex:1;
            display:flex;
            flex-direction:column;
            gap: 10px;
            padding-top: 4px;
            box-sizing:border-box;
        }
        .modal-title{
            font-size: 22px;
            font-weight: 900;
            color:#111;
            margin-bottom: 6px;
        }
        .info-row{
            display:flex;
            gap: 10px;
            align-items:center;
        }
        .info-label{
            width: 120px;
            font-weight: 800;
            color:#333;
        }
        .info-value{
            flex: 1;
            color:#222;
            background:#f8fafc;
            border: 1px solid #eef2f7;
            border-radius: 12px;
            padding: 10px 12px;
            box-sizing:border-box;
            font-size: 14px;
        }
        .chip{
            display:inline-block;
            padding: 5px 10px;
            background:#f5f5f5;
            border:1px solid #e8e8e8;
            border-radius:999px;
            margin-right:6px;
            margin-top:6px;
            font-size:12px;
        }

        .modal-review-area{
            flex:1;
            padding: 18px;
            box-sizing:border-box;
            background:#fff;
        }
        .modal-review-box{
            width:100%;
            height:100%;
            border-radius: 12px;
            background: chartreuse;
        }

        .loading{
            padding:10px 12px;
            background:#fff7d6;
            border:1px solid #ffe7a1;
            border-radius:10px;
            font-size:13px;
            margin-bottom: 10px;
        }

        #button_area{
            display:flex;
            gap:10px;
            align-items:center;
            justify-content:flex-start;
            margin-top: 8px;
        }
        #button_area button{
            border:1px solid #e5e7eb;
            background:#fff;
            padding: 10px 12px;
            border-radius: 12px;
            cursor:pointer;
            font-weight: 800;
            font-size: 13px;
        }
        #button_area button:hover{
            background:#f5f5f5;
        }

    </style>
</head>

<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div id="wrap">
        <div id="content">
            <div id="movieRank">
                <div id="header_movieRank">
                    영화 순위 / 더보기
                </div>

                <div id="content_movieRank">
                    <c:forEach var="m" items="${top5}" varStatus="st">
                        <div class="item_content" data-tmdb-id="${m.tmdbId}">
                            <div class="poster_item" style="display:flex; align-items:center; justify-content:center;">
                                <c:choose>
                                    <c:when test="${not empty m.posterUrl}">
                                        <img src="${m.posterUrl}"
                                             alt="poster"
                                             style="width:100%; height:100%; object-fit:cover;" />
                                    </c:when>
                                    <c:otherwise>
                                        포스터
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="title_item"
                                 style="display:flex; align-items:center; justify-content:center; padding:6px; text-align:center;">
                                <c:out value="${m.title}" />
                            </div>
                        </div>
                    </c:forEach>

                    <c:set var="len" value="${empty top5 ? 0 : fn:length(top5)}" />
                    <c:set var="remain" value="${5 - len}" />

                    <c:if test="${remain > 0}">
                        <c:forEach begin="1" end="${remain}">
                            <div class="item_content">
                                <div class="poster_item"></div>
                                <div class="title_item"></div>
                            </div>
                        </c:forEach>
                    </c:if>

                </div>
            </div>

            <div id="live_comment"></div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <div id="movieModal" class="modal-backdrop" onclick="backdropClose(event)">
        <div class="modal-box">
            <div class="modal-top">
                <span id="modalTitle">영화 상세</span>
                <button class="modal-close" type="button" onclick="closeModal()">닫기</button>
            </div>

            <div class="modal-main">
                <div class="modal-movie-area">
                    <div class="modal-poster" id="modalPosterWrap">포스터</div>

                    <div class="modal-info" style="overflow-y:auto;">
                        <div id="modalLoading" class="loading" style="display:none;">불러오는 중...</div>

                        <div class="modal-title" id="modalMovieName">영화 이름</div>

                        <div class="info-row">
                            <div class="info-label">개봉일</div>
                            <div class="info-value" id="modalReleaseDate">-</div>
                        </div>

                        <div class="info-row" style="align-items:flex-start;">
                            <div class="info-label">영화 장르</div>
                            <div class="info-value" id="modalGenres">-</div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">감독</div>
                            <div class="info-value" id="modalDirector">-</div>
                        </div>

                        <div class="info-row" style="align-items:flex-start;">
                            <div class="info-label">배우</div>
                            <div class="info-value" id="modalActors">-</div>
                        </div>

                        <div class="info-row" style="align-items:flex-start;">
                            <div class="info-label">줄거리</div>
                            <div class="info-value" id="modalContent">-</div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">인기도</div>
                            <div class="info-value" id="modalPopularity">-</div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">평점</div>
                            <div class="info-value" id="modalUserScore">평점(유저가 매긴 점수)</div>
                        </div>

                        <div id="button_area">
                            <button id="btnLike" type="button">👍 좋아요(20)</button>
                            <button id="btnDislike" type="button">👎 싫어요(3)</button>
                            <button id="btnWriteReview" type="button">✍️ 감상문 쓰기</button>
                        </div>
                    </div>
                </div>

                <div class="modal-review-area">
                    <div class="modal-review-box"></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("click", function(e){
            var card = e.target.closest(".item_content");
            if(!card) return;

            var tmdbId = card.getAttribute("data-tmdb-id");
            if(!tmdbId) return;

            openModal(tmdbId);
        });

        function openModal(tmdbId){
            var modal = document.getElementById("movieModal");
            modal.style.display = "flex";

            setLoading(true);
            setPoster("");

            document.getElementById("modalTitle").innerText = "영화 상세";
            document.getElementById("modalMovieName").innerText = "영화 이름";
            document.getElementById("modalReleaseDate").innerText = "-";
            document.getElementById("modalGenres").innerHTML = "-";
            document.getElementById("modalPopularity").innerText = "-";
            document.getElementById("modalDirector").innerText = "-";
            document.getElementById("modalActors").innerHTML = "-";
            document.getElementById("modalContent").innerText = "-";

            var url = "<c:url value='/tmdb/movieDetail.mo'/>" + "?tmdbId=" + encodeURIComponent(tmdbId);

            fetch(url, { method: "GET" })
              .then(resp => resp.json())
              .then(data => {
                  if(!data || data.ok !== true){
                      throw new Error((data && data.message) ? data.message : "detail fetch failed");
                  }

                  var title = data.title || data.original_title || "제목 없음";
                  document.getElementById("modalTitle").innerText = title;
                  document.getElementById("modalMovieName").innerText = title;

                  document.getElementById("modalReleaseDate").innerText = data.release_date || "-";

                  document.getElementById("modalPopularity").innerText =
                      (data.popularity !== undefined && data.popularity !== null) ? data.popularity : "-";

                  var genres = data.genres || [];
                  if(Array.isArray(genres) && genres.length > 0){
                      var html = "";
                      genres.forEach(g => {
                          html += "<span class='chip'>" + escapeHtml(g.name) + "</span>";
                      });
                      document.getElementById("modalGenres").innerHTML = html;
                  } else {
                      document.getElementById("modalGenres").innerHTML = "-";
                  }

                  document.getElementById("modalContent").innerText =
                      (data.overview !== undefined && data.overview !== null && String(data.overview).trim() !== "")
                      ? data.overview
                      : "-";

                  setPoster(data.posterUrl || "");
                  setLoading(false);

                  fetchCreditsAndRender(tmdbId);

                  saveMovieToDb(tmdbId, data);
              })
              .catch(err => {
                  setLoading(false);
                  document.getElementById("modalMovieName").innerText = "불러오기 실패";
              });
        }

        function saveMovieToDb(tmdbId, detail){
            var payload = {
                tmdbId: tmdbId,
                title: detail.title || detail.original_title || "",
                adult: (detail.adult === true || detail.adult === "true") ? "Y" : "N",
                releaseDate: detail.release_date || "",
                popularity: (detail.popularity !== undefined && detail.popularity !== null) ? detail.popularity : 0,
                category: (Array.isArray(detail.genres) && detail.genres.length > 0) ? detail.genres[0].name : "",
                content: detail.overview || ""
            };

            fetch("<c:url value='/movie/saveFromTmdb.mo'/>", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(payload)
            })
            .then(resp => resp.json())
            .then(r => {
            })
            .catch(e => {
            });
        }

        function fetchCreditsAndRender(tmdbId){
            var url = "<c:url value='/tmdb/movieCredits.mo'/>" + "?tmdbId=" + encodeURIComponent(tmdbId);

            fetch(url, { method: "GET" })
              .then(resp => resp.json())
              .then(data => {
                  if(!data || data.ok !== true){
                      throw new Error((data && data.message) ? data.message : "credits fetch failed");
                  }

                  document.getElementById("modalDirector").innerText = data.director || "-";

                  var actors = data.actors || [];
                  if(Array.isArray(actors) && actors.length > 0){
                      var html = "";
                      actors.forEach(name => {
                          html += "<span class='chip'>" + escapeHtml(name) + "</span>";
                      });
                      document.getElementById("modalActors").innerHTML = html;
                  } else {
                      document.getElementById("modalActors").innerHTML = "-";
                  }
              })
              .catch(err => {
                  document.getElementById("modalDirector").innerText = "-";
                  document.getElementById("modalActors").innerHTML = "-";
              });
        }

        function closeModal(){
            document.getElementById("movieModal").style.display = "none";
        }

        function backdropClose(e){
            if(e.target.id === "movieModal"){
                closeModal();
            }
        }

        function setLoading(isLoading){
            document.getElementById("modalLoading").style.display = isLoading ? "block" : "none";
        }

        function setPoster(url){
            var wrap = document.getElementById("modalPosterWrap");
            if(url){
                wrap.innerHTML = "<img src='" + url + "' alt='poster'/>";
            }else{
                wrap.innerHTML = "포스터";
            }
        }

        function escapeHtml(str){
            if(str === null || str === undefined) return "";
            return String(str)
              .replaceAll("&","&amp;")
              .replaceAll("<","&lt;")
              .replaceAll(">","&gt;")
              .replaceAll("\"","&quot;")
              .replaceAll("'","&#039;");
        }
    </script>

</body>
</html>

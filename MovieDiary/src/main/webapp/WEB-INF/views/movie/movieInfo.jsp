<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Info</title>

    <style>
        #wrap{
            width : 80%;
            height: 200vh;
            margin : auto;
            border : 2px solid red;
            display: flex;
            flex-direction: column;
            gap:10px;
        }
        #button_header{
            width : 100%;
            height : 5%;
            display: flex;
            order : between;
            justify-content: space-between;
            align-items: center;
        }
        .movie_content{
            width: 100%;
            height:30%;
            border : 2px dashed purple;
            display: flex;
            gap:10px;
        }
        #pageinfo_area{
            width : 100%;
            height : 10%;
            border : 2px dashed blue;
            display:flex;
            justify-content:center;
            align-items:center;
            gap:6px;
        }
        .movie_item{
            width:15%;
            height: 90%;
            border : 2px dashed green;
            flex : 1;
            margin:15px;
            display:flex;
            flex-direction:column;
            overflow:hidden;
            cursor:pointer;
            transition: transform .15s ease, box-shadow .15s ease;
            background:#fff;
        }
        .movie_item:hover{
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(0,0,0,.12);
        }
        .poster_box{
            width:100%;
            height:75%;
            display:flex;
            justify-content:center;
            align-items:center;
            background:#f2f2f2;
        }
        .poster_box img{
            width:100%;
            height:100%;
            object-fit:cover;
        }
        .title_box{
            width:100%;
            height:25%;
            display:flex;
            justify-content:center;
            align-items:center;
            text-align:center;
            padding:6px;
            box-sizing:border-box;
            font-size:14px;
            font-weight:600;
        }
        .pageBtn{
            padding:6px 10px;
            border:1px solid #333;
            background:#fff;
            cursor:pointer;
            text-decoration:none;
            color:#333;
        }
        .pageBtn.active{
            background:#333;
            color:#fff;
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
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div id="wrap">

        <div id="button_header">
            <div id="genre_content">
                <label for="genre_movie">장르 선택</label><br>
                <select id="genre" onchange="goSearch(1)">
                    <option value="" ${empty genreId ? "selected" : ""}>없음</option>
                    <option value="28" ${genreId==28 ? "selected" : ""}>액션</option>
                    <option value="12" ${genreId==12 ? "selected" : ""}>모험</option>
                    <option value="35" ${genreId==35 ? "selected" : ""}>코미디</option>
                    <option value="80" ${genreId==80 ? "selected" : ""}>범죄</option>
                    <option value="99" ${genreId==99 ? "selected" : ""}>다큐멘터리</option>
                    <option value="18" ${genreId==18 ? "selected" : ""}>드라마</option>
                    <option value="10751" ${genreId==10751 ? "selected" : ""}>가족</option>
                    <option value="14" ${genreId==14 ? "selected" : ""}>판타지</option>
                    <option value="36" ${genreId==36 ? "selected" : ""}>역사</option>
                    <option value="27" ${genreId==27 ? "selected" : ""}>공포</option>
                    <option value="10402" ${genreId==10402 ? "selected" : ""}>음악</option>
                    <option value="9648" ${genreId==9648 ? "selected" : ""}>미스터리</option>
                    <option value="10749" ${genreId==10749 ? "selected" : ""}>로맨스</option>
                    <option value="878" ${genreId==878 ? "selected" : ""}>SF</option>
                    <option value="10770" ${genreId==10770 ? "selected" : ""}>TV 영화</option>
                    <option value="53" ${genreId==53 ? "selected" : ""}>스릴러</option>
                    <option value="10752" ${genreId==10752 ? "selected" : ""}>전쟁</option>
                    <option value="37" ${genreId==37 ? "selected" : ""}>서부</option>
                </select>
            </div>

            <div id="filter_content">
                <label for="filter_movie">필터링 기준</label><br>
                <select id="filter" onchange="goSearch(1)">
                    <option value="release_date" ${sort=="release_date" ? "selected" : ""}>개봉일(최신)</option>
                    <option value="popularity" ${sort=="popularity" ? "selected" : ""}>인기</option>
                    <option value="vote_average" ${sort=="vote_average" ? "selected" : ""}>평점</option>
                </select>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div style="color:red; padding:10px;">${error}</div>
        </c:if>

        <c:set var="idx" value="0" />

        <c:forEach begin="1" end="3" var="row">
            <div class="movie_content">
                <c:forEach begin="1" end="5" var="col">
                    <c:choose>
                        <c:when test="${idx < movies.size()}">
                            <c:set var="m" value="${movies[idx]}" />
                            <div class="movie_item"
                                 data-tmdb-id="${m.tmdbId}">
                                <div class="poster_box">
                                    <img src="${m.posterUrl}" alt="poster" />
                                </div>
                                <div class="title_box">${m.title}</div>
                            </div>
                            <c:set var="idx" value="${idx + 1}" />
                        </c:when>
                        <c:otherwise>
                            <div class="movie_item" style="cursor:default;">
                                <div class="poster_box"></div>
                                <div class="title_box"></div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </c:forEach>

        <div id="pageinfo_area">
            <c:set var="pi" value="${pi}" />

            <c:choose>
                <c:when test="${pi.currentPage > 1}">
                    <a class="pageBtn" href="javascript:void(0)" onclick="goSearch(${pi.currentPage - 1})">&lt;</a>
                </c:when>
                <c:otherwise>
                    <span class="pageBtn" style="opacity:.4; cursor:default;">&lt;</span>
                </c:otherwise>
            </c:choose>

            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                <c:choose>
                    <c:when test="${p == pi.currentPage}">
                        <span class="pageBtn active">${p}</span>
                    </c:when>
                    <c:otherwise>
                        <a class="pageBtn" href="javascript:void(0)" onclick="goSearch(${p})">${p}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:choose>
                <c:when test="${pi.currentPage < pi.maxPage}">
                    <a class="pageBtn" href="javascript:void(0)" onclick="goSearch(${pi.currentPage + 1})">&gt;</a>
                </c:when>
                <c:otherwise>
                    <span class="pageBtn" style="opacity:.4; cursor:default;">&gt;</span>
                </c:otherwise>
            </c:choose>
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
                            <button id="btnLike">👍 좋아요(20)</button>
                            <button id="btnDislike">👎 싫어요(3)</button>
                            <button id="btnWriteReview">✍️ 감상문 쓰기</button>
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
	    function goSearch(page){
	        var genreId = document.getElementById("genre").value;
	        var sort = document.getElementById("filter").value;
	        var keyword = "${keyword}";
	
	        var url = "<c:url value='/movieInfo.mo'/>" + "?cPage=" + page;
	
	        if(genreId && genreId !== ""){
	            url += "&genreId=" + encodeURIComponent(genreId);
	        }
	        if(sort && sort !== ""){
	            url += "&sort=" + encodeURIComponent(sort);
	        }
	        if(keyword && String(keyword).trim() !== ""){
	            url += "&keyword=" + encodeURIComponent(keyword);
	        }
	
	        location.href = url;
    }

        document.addEventListener("click", function(e){
            var card = e.target.closest(".movie_item");
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
            document.getElementById("modalDirector").innerText = "-";
            document.getElementById("modalActors").innerHTML = "-";
            document.getElementById("modalContent").innerText = "-";
            document.getElementById("modalPopularity").innerText = "-";

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
                // console.log("save result", r);
            })
            .catch(e => {
                // console.log("save fail", e);
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
                  // 실패해도 화면/기존 기능 영향 없게 처리
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

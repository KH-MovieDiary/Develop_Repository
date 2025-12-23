<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>Movie Modal</title>

    <style>
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
            padding: 12px;
            box-sizing:border-box;
            display:flex;
            flex-direction:column;
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

        /* 리뷰 UI */
        .review-header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:10px;
            font-weight:900;
        }
        .review-count{
            font-size:12px;
            color:#333;
            font-weight:800;
        }
        .review-list{
            flex:1;
            overflow-y:auto;
            padding-right:6px;
        }
        .review-item{
            background:#fff;
            border:1px solid #e5e7eb;
            border-radius:12px;
            padding:10px;
            margin-bottom:8px;
        }
        .review-top{
            display:flex;
            justify-content:space-between;
            font-size:12px;
            margin-bottom:6px;
        }
        .review-content{
            white-space:pre-wrap;
            margin-bottom:8px;
            font-size:13px;
        }
        .review-actions{
            display:flex;
            gap:8px;
            align-items:center;
        }
        .review-actions button{
            border:1px solid #ddd;
            background:#fff;
            border-radius:10px;
            padding:6px 10px;
            cursor:not-allowed;
            font-weight:800;
            font-size:12px;
        }

        /* 삭제 버튼 활성 스타일 */
        .btnCommentDelete{
            cursor:pointer !important;
            border:1px solid #e5e7eb;
            background:#fff;
        }
        .btnCommentDelete:hover{
            background:#f5f5f5;
        }

        .review-input-wrap{
            display:flex;
            gap:8px;
            margin-top:10px;
        }
        #commentInput{
            flex:1;
            height:70px;
            resize:none;
            border:1px solid #d1d5db;
            border-radius:12px;
            padding:10px;
            box-sizing:border-box;
            outline:none;
        }
        #btnCommentSubmit{
            width:90px;
            border:none;
            background:#111;
            color:#fff;
            border-radius:12px;
            font-weight:900;
            cursor:pointer;
        }
		#btnLike, #btnDislike{
		    cursor:pointer !important;
		    border: 1px solid #e5e7eb;
		    background:#fff;
		    transition: all .15s ease;
		}
		#btnLike:hover{ background:#ecfeff; border-color:#06b6d4; }
		#btnDislike:hover{ background:#fff1f2; border-color:#fb7185; }
		
		#btnLike.active{
		    background:#06b6d4;
		    border-color:#06b6d4;
		    color:#fff;
		}
		#btnDislike.active{
		    background:#fb7185;
		    border-color:#fb7185;
		    color:#fff;
		}
        
    </style>
</head>
<body>

    <!-- 로그인 유저 아이디 JSP로 변수화 -->
    <c:set var="loginUserId" value="${empty loginUser ? '' : loginUser.userId}" />

    <div id="movieModal" class="modal-backdrop" onclick="backdropClose(event)">
        <div class="modal-box">
            <div class="modal-top">
                <span id="modalTitle">영화 상세</span>
                <button class="modal-close" type="button" onclick="closeModal()">닫기</button>
            </div>

            <div class="modal-main" style="overflow-y:auto;">
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

                <div class="modal-review-area" style="overflow-y:auto;">
                    <div class="modal-review-box">

                        <div class="review-header">
                            <div>리뷰</div>
                            <div id="commentCount" class="review-count">0개</div>
                        </div>

                        <div id="commentList" class="review-list"></div>

                        <div class="review-input-wrap">
                            <c:choose>
                                <c:when test="${empty loginUser}">
                                    <textarea id="commentInput" placeholder="로그인 후 입력 가능합니다." disabled></textarea>
                                </c:when>
                                <c:otherwise>
                                    <textarea id="commentInput" placeholder="리뷰를 입력하세요"></textarea>
                                </c:otherwise>
                            </c:choose>

                            <button id="btnCommentSubmit" type="button" onclick="submitComment()">등록</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const LOGIN_USER_ID = "${loginUserId}";
    </script>

    <script>
        const TMDB_DETAIL_URL  = "<c:url value='/tmdb/movieDetail.mo'/>";
        const TMDB_CREDITS_URL = "<c:url value='/tmdb/movieCredits.mo'/>";
        const MOVIE_SAVE_URL   = "<c:url value='/movie/saveFromTmdb.mo'/>";

        const COMMENT_LIST_URL   = "<c:url value='/comment/list.mo'/>";
        const COMMENT_INSERT_URL = "<c:url value='/comment/insert.mo'/>";
        const COMMENT_DELETE_URL = "<c:url value='/comment/delete.mo'/>";
        const LIKE_STATUS_URL = "<c:url value='/like/status.mo'/>";
        const LIKE_TOGGLE_URL = "<c:url value='/like/toggle.mo'/>";


        let CURRENT_MOVIE_ID = null;

        function openModal(tmdbId){
            var modal = document.getElementById("movieModal");
            if(!modal) return;

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

            CURRENT_MOVIE_ID = parseInt(tmdbId, 10);
            loadLikeState(CURRENT_MOVIE_ID);

            loadComments(CURRENT_MOVIE_ID);

            var url = TMDB_DETAIL_URL + "?tmdbId=" + encodeURIComponent(tmdbId);

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

            fetch(MOVIE_SAVE_URL, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(payload)
            })
            .then(resp => resp.json())
            .then(r => {})
            .catch(e => {});
        }

        function fetchCreditsAndRender(tmdbId){
            var url = TMDB_CREDITS_URL + "?tmdbId=" + encodeURIComponent(tmdbId);

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

        function loadComments(movieId){
            if(!movieId) return;

            fetch(COMMENT_LIST_URL + "?movidId=" + encodeURIComponent(movieId))
              .then(resp => resp.json())
              .then(list => {
                  list = Array.isArray(list) ? list : [];

                  document.getElementById("commentCount").innerText = list.length + "개";

                  var html = "";
                  for(var i=0; i<list.length; i++){
                      var c = list[i];

                      var commentId = c.commentId || c.id || ""; 
                      var userId = c.userId ? c.userId : "익명";
                      var content = c.content ? c.content : "";
                      var dateStr = c.createDate ? String(c.createDate).substring(0,10) : "";

                      var canDelete = (LOGIN_USER_ID && String(LOGIN_USER_ID) === String(userId));

                      var deleteBtnHtml = "";
                      if(canDelete){
                          deleteBtnHtml =
                              "<button type='button' class='btnCommentDelete' data-comment-id='" + escapeHtml(commentId) + "'>"
                            + "  🗑️ 삭제하기"
                            + "</button>";
                      }

                      html += ""
                        + "<div class='review-item'>"
                        + "  <div class='review-top'>"
                        + "    <b>[" + escapeHtml(userId) + "]</b>"
                        + "    <span>" + escapeHtml(dateStr) + "</span>"
                        + "  </div>"
                        + "  <div class='review-content'>" + escapeHtml(content) + "</div>"
                        + "  <div class='review-actions'>"
                        + "    <button type='button' disabled>👍 좋아요</button>"
                        +      deleteBtnHtml
                        + "  </div>"
                        + "</div>";
                  }

                  if(list.length === 0){
                      html = "<div style='color:#333; font-weight:800; font-size:13px;'>아직 리뷰가 없습니다</div>";
                  }

                  document.getElementById("commentList").innerHTML = html;
              })
              .catch(err => {
                  console.error(err);
                  document.getElementById("commentList").innerHTML =
                    "<div style='color:red; font-weight:900;'>리뷰 불러오기 실패</div>";
              });
        }

        function submitComment(){
            if(!CURRENT_MOVIE_ID){
                alert("영화 ID가 없습니다");
                return;
            }

            var content = document.getElementById("commentInput").value.trim();
            if(content === ""){
                alert("내용을 입력하세요");
                return;
            }

            const params = new URLSearchParams();
            params.append("movieId", CURRENT_MOVIE_ID);
            params.append("content", content);
            if(LOGIN_USER_ID){
                params.append("userId", LOGIN_USER_ID);
            }

            fetch(COMMENT_INSERT_URL, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
                body: params.toString()
            })
            .then(resp => resp.text())
            .then(txt => {
                const result = parseInt(txt, 10) || 0;
                if(result <= 0){
                    alert("리뷰 등록 실패");
                    return;
                }
                document.getElementById("commentInput").value = "";
                loadComments(CURRENT_MOVIE_ID);
            })
            .catch(err => {
                console.error(err);
                alert("리뷰 등록 실패");
            });
        }

        function closeModal(){
            var modal = document.getElementById("movieModal");
            if(modal) modal.style.display = "none";
        }

        function backdropClose(e){
            if(e && e.target && e.target.id === "movieModal"){
                closeModal();
            }
        }

        function setLoading(isLoading){
            var el = document.getElementById("modalLoading");
            if(!el) return;
            el.style.display = isLoading ? "block" : "none";
        }

        function setPoster(url){
            var wrap = document.getElementById("modalPosterWrap");
            if(!wrap) return;

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


        document.addEventListener("click", function(e){
            const btn = e.target.closest(".btnCommentDelete");
            if(!btn) return;

            const commentId = btn.dataset.commentId;
            if(!commentId){
                alert("commentId가 없습니다");
                return;
            }

            if(!confirm("정말 삭제할까요?")) return;

            deleteComment(commentId);
        });

        function deleteComment(commentId){
            const url = COMMENT_DELETE_URL + "?commentId=" + encodeURIComponent(commentId);

            fetch(url, { method: "GET" })
              .then(resp => resp.text())
              .then(txt => {
                  console.log("delete resp:", txt);
                  loadComments(CURRENT_MOVIE_ID);
              })
              .catch(err => {
                  console.error(err);
                  alert("삭제 실패");
              });
        }
        function loadLikeState(movieId){
            fetch(LIKE_STATUS_URL + "?movieId=" + encodeURIComponent(movieId))
              .then(r => r.text())
              .then(txt => {
                  // txt: "LIKE,3,1" / "DISLIKE,3,1" / ",3,1"
                  const parts = String(txt || "").split(",");
                  const myChoice = (parts[0] || "").trim(); // LIKE/DISLIKE/""
                  const likeCount = parseInt(parts[1], 10) || 0;
                  const dislikeCount = parseInt(parts[2], 10) || 0;
                  applyLikeUI(likeCount, dislikeCount, myChoice);
              })
              .catch(e => console.error(e));
        }

        function applyLikeUI(likeCount, dislikeCount, myChoice){
            const btnLike = document.getElementById("btnLike");
            const btnDislike = document.getElementById("btnDislike");
            if(!btnLike || !btnDislike) return;

            btnLike.textContent = "👍 좋아요(" + likeCount + ")";
            btnDislike.textContent = "👎 싫어요(" + dislikeCount + ")";

            btnLike.classList.remove("active");
            btnDislike.classList.remove("active");

            if(String(myChoice).toUpperCase() === "LIKE") btnLike.classList.add("active");
            if(String(myChoice).toUpperCase() === "DISLIKE") btnDislike.classList.add("active");

            // 로그인 안 했으면 클릭 막기(보이긴 보이되)
            if(!LOGIN_USER_ID){
                btnLike.style.opacity = "0.6";
                btnDislike.style.opacity = "0.6";
            }else{
                btnLike.style.opacity = "1";
                btnDislike.style.opacity = "1";
            }
        }

        document.getElementById("btnLike")?.addEventListener("click", function(){
            if(!CURRENT_MOVIE_ID) return;
            toggleLike("LIKE");
        });
        document.getElementById("btnDislike")?.addEventListener("click", function(){
            if(!CURRENT_MOVIE_ID) return;
            toggleLike("DISLIKE");
        });

        function toggleLike(action){
            if(!LOGIN_USER_ID){
                alert("로그인 후 이용 가능합니다.");
                return;
            }

            const params = new URLSearchParams();
            params.append("movieId", CURRENT_MOVIE_ID);
            params.append("action", action);

            fetch(LIKE_TOGGLE_URL, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
                body: params.toString()
            })
            .then(r => r.text())
            .then(txt => {
                if(txt === "LOGIN"){
                    alert("로그인 후 이용 가능합니다.");
                    return;
                }
                if(txt === "BAD"){
                    alert("요청이 올바르지 않습니다.");
                    return;
                }
                const parts = String(txt || "").split(",");
                const myChoice = (parts[0] || "").trim();
                const likeCount = parseInt(parts[1], 10) || 0;
                const dislikeCount = parseInt(parts[2], 10) || 0;

                applyLikeUI(likeCount, dislikeCount, myChoice);
            })
            .catch(e => {
                console.error(e);
                alert("처리 실패");
            });
        }
    </script>
</body>
</html>

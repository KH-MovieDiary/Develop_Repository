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
        margin: 0;
        background:
            radial-gradient(1200px 600px at 20% 0%, rgba(125,211,252,0.20), transparent 55%),
            radial-gradient(900px 500px at 90% 10%, rgba(167,139,250,0.18), transparent 55%),
            radial-gradient(900px 500px at 50% 100%, rgba(52,211,153,0.12), transparent 55%),
            var(--bg);
        color: var(--text);
    }

    #wrap{
        width : 80%;
        height: 200vh;
        margin : auto;
        display: flex;
        flex-direction: column;
        gap:10px;    
        padding: 18px;
        box-sizing: border-box;

        border: 1px solid var(--line);
        border-radius: 18px;
        background: linear-gradient(180deg, rgba(255,255,255,0.06), rgba(255,255,255,0.04));
        box-shadow: 0 18px 60px rgba(0,0,0,0.35);
    }

    #button_header{
        width : 100%;
        height : 5%;  
        display: flex;
        order : between;  
        justify-content: space-between;
        align-items: center;

        padding: 14px 16px;
        box-sizing: border-box;
        border-radius: 14px;
        background: rgba(255,255,255,0.05);
        border: 1px solid rgba(255,255,255,0.10);
    }

    #button_header label{
        font-size: 12px;
        font-weight: 800;
        color: var(--muted);
        margin: 0;
    }

    #button_header select{
        margin-top: 6px;
        height: 38px;
        padding: 0 12px;
        border-radius: 12px;
        border: 1px solid rgba(255,255,255,0.15);
        background: rgba(255,255,255,0.06);
        color: var(--text);
        outline: none;
    }

    #button_header select:focus{
        border-color: rgba(125,211,252,0.55);
        box-shadow: 0 0 0 3px rgba(125,211,252,0.18);
    }

    .movie_content{
        width: 100%;
        height:30%;  
        display: flex;
        gap:10px; 
        border: none;   
    }

    #pageinfo_area{
        width : 100%;
        height : 10%;   
        display:flex;
        justify-content:center;
        align-items:center;
        gap:6px;  

        border: none;           
        padding-bottom: 6px;
        box-sizing: border-box;
    }

    .movie_item{
        width:15%;
        height: 90%;        
        flex : 1;
        margin:15px;               
        display:flex;
        flex-direction:column;
        overflow:hidden;
        cursor:pointer;
        transition: transform .15s ease, box-shadow .15s ease;
        background: rgba(255,255,255,0.06);

        border: 1px solid rgba(255,255,255,0.12);
        border-radius: 16px;
        box-shadow: 0 14px 40px rgba(0,0,0,0.22);
    }

    .movie_item:hover{
        transform: translateY(-2px);
        box-shadow: 0 20px 52px rgba(0,0,0,.32);
    }

    .poster_box{
        width:100%;
        height:75%;          
        display:flex;
        justify-content:center;
        align-items:center;
        background: rgba(255,255,255,0.04);
        position: relative;
    }

    .poster_box::after{
        content:"";
        position:absolute;
        inset:0;
        background: linear-gradient(to top, rgba(0,0,0,0.52), transparent 60%);
        pointer-events:none;
    }

    .poster_box img{
        width:100%;
        height:100%;
        object-fit:cover;
        display:block;
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
        font-weight:800;

        background: rgba(0,0,0,0.18);
        /* color: rgba(255,255,255,0.92); */
		color : black;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .pageBtn{
        padding:6px 10px;   
        border:1px solid rgba(255,255,255,0.15);
        background: rgba(255,255,255,0.06);
        cursor:pointer;
        text-decoration:none;
        color: rgba(255,255,255,0.85);
        border-radius: 12px;
        font-weight: 800;
        transition: transform .15s ease, box-shadow .15s ease, background .15s ease;
        color : black;
    }

    .pageBtn:hover{
        transform: translateY(-1px);
        box-shadow: 0 10px 22px rgba(0,0,0,0.25);
        background: rgba(255,255,255,0.08);
    }

    .pageBtn.active{
        background: linear-gradient(180deg, rgba(125,211,252,0.26), rgba(125,211,252,0.10));
        border-color: rgba(125,211,252,0.55);
        color:black;
    }
    #button_header label{
    color: black;
	}

	#button_header select{
	    color: black;
	}
	
	/* select 내부 option */
	#button_header select option{
	    color:black;
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
                            <div class="movie_item" data-tmdb-id="${m.tmdbId}">
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


    <jsp:include page="/WEB-INF/views/common/movieModal.jsp" />


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

    </script>

</body>
</html>

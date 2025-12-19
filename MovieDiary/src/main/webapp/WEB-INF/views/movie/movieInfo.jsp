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
        }
        .poster_box{
            width:100%;
            height:75%;
            display:flex;
            justify-content:center;
            align-items:center;
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
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div id="wrap">

        <div id="button_header">
            <!-- 장르 -->
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

            <!-- 정렬 -->
            <div id="filter_content">
                <label for="filter_movie">필터링 기준</label><br>
                <select id="filter" onchange="goSearch(1)">
                    <option value="release_date" ${sort=="release_date" ? "selected" : ""}>개봉일(최신)</option>
                    <option value="popularity" ${sort=="popularity" ? "selected" : ""}>인기</option>
                    <option value="vote_average" ${sort=="vote_average" ? "selected" : ""}>평점</option>
                </select>
            </div>
        </div>

        <!-- 에러 표시 -->
        <c:if test="${not empty error}">
            <div style="color:red; padding:10px;">${error}</div>
        </c:if>

        <!-- 15개를 3줄(5칸씩)로 렌더링 -->
        <c:set var="idx" value="0" />

        <c:forEach begin="1" end="3" var="row">
            <div class="movie_content">
                <c:forEach begin="1" end="5" var="col">
                    <c:choose>
                        <c:when test="${idx < movies.size()}">
                            <c:set var="m" value="${movies[idx]}" />
                            <div class="movie_item">
                                <div class="poster_box">
                                    <img src="${m.posterUrl}" alt="poster" />
                                </div>
                                <div class="title_box">${m.title}</div>
                            </div>
                            <c:set var="idx" value="${idx + 1}" />
                        </c:when>
                        <c:otherwise>
                            <div class="movie_item">
                                <div class="poster_box"></div>
                                <div class="title_box"></div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </c:forEach>

        <!-- 페이지 영역 -->
        <div id="pageinfo_area">
            <c:set var="pi" value="${pi}" />

            <!-- 이전(<) -->
            <c:choose>
                <c:when test="${pi.currentPage > 1}">
                    <a class="pageBtn" href="javascript:void(0)" onclick="goSearch(${pi.currentPage - 1})">&lt;</a>
                </c:when>
                <c:otherwise>
                    <span class="pageBtn" style="opacity:.4; cursor:default;">&lt;</span>
                </c:otherwise>
            </c:choose>

            <!-- 5개 페이지 버튼 -->
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

            <!-- 다음(>) -->
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

    <script>
        function goSearch(page){
            var genreId = document.getElementById("genre").value; // "" or number
            var sort = document.getElementById("filter").value;

            var url = "<c:url value='/movieInfo.mo'/>" + "?cPage=" + page;

            if(genreId && genreId !== ""){
                url += "&genreId=" + encodeURIComponent(genreId);
            }
            if(sort && sort !== ""){
                url += "&sort=" + encodeURIComponent(sort);
            }

            location.href = url;
        }
    </script>

</body>
</html>

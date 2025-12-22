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

    <!-- ✅ 모달(HTML+CSS+JS) 한방 include -->
    <jsp:include page="/WEB-INF/views/common/movieModal.jsp" />

    <script>
        document.addEventListener("click", function(e){
            var card = e.target.closest(".item_content");
            if(!card) return;

            var tmdbId = card.getAttribute("data-tmdb-id");
            if(!tmdbId) return;

            openModal(tmdbId);   // ✅ movieModal.jsp에 정의된 함수 그대로 호출
        });
    </script>

</body>
</html>

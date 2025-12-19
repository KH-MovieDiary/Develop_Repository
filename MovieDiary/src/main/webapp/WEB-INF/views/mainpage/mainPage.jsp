<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        }

        .poster_item {
            background-color: darkseagreen;
            width: 100%;
            height: 70%;
        }

        .title_item {
            background-color: palegreen;
            width: 100%;
            height: 30%;
        }
    </style>
</head>

<body>

    <%-- ✅ 헤더 include (경로는 너 프로젝트 경로에 맞게) --%>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div id="wrap">
        <div id="content">
            <div id="movieRank">
                <div id="header_movieRank">
                    영화 순위 / 더보기
                </div>
                <div id="content_movieRank">
                    <div class="item_content">
                        <div class="poster_item">포스터</div>
                        <div class="title_item">제목</div>
                    </div>
                    <div class="item_content">
                        <div class="poster_item"></div>
                        <div class="title_item"></div>
                    </div>
                    <div class="item_content">
                        <div class="poster_item"></div>
                        <div class="title_item"></div>
                    </div>
                    <div class="item_content">
                        <div class="poster_item"></div>
                        <div class="title_item"></div>
                    </div>
                    <div class="item_content">
                        <div class="poster_item"></div>
                        <div class="title_item"></div>
                    </div>
                </div>
            </div>

            <div id="live_comment"></div>
        </div>
    </div>

</body>
</html>

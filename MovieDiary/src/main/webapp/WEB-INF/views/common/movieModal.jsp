<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
body{
    margin:0;
    padding:0;
}
.modal-backdrop{
    display:none;
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.45);
    z-index:9999;
    display:flex;
    justify-content:center;
    align-items:center;
}

#wrap {
    width: min(900px, 92vw);
    height: min(720px, 92vh);
    background:#fff;
    border-radius:18px;
    display:flex;
    flex-direction:column;
}

#movie_area{
    height:50%;
    border-bottom:1px solid #eee;
}

#movie_area_wrap{
    display:flex;
    gap:18px;
    padding:18px;
}

#poster_area{
    width:32%;
    background:#f3f4f6;
    border-radius:14px;
    display:flex;
    justify-content:center;
    align-items:center;
}

#poster_area img{
    width:100%;
    height:100%;
    object-fit:cover;
}

#content_area{
    flex:1;
    display:flex;
    flex-direction:column;
    gap:10px;
}

#movie_name{
    font-size:22px;
    font-weight:800;
}

#movie_release_date,
#movie_genre,
#movie_population,
#movie_score{
    background:#f8fafc;
    border:1px solid #eef2f7;
    border-radius:12px;
    padding:10px;
}

#review_area{
    height:40%;
    background:#fff;
}

#review_list{
    width:90%;
    height:90%;
    background:chartreuse;
    margin:20px;
}

#button_area{
    height:10%;
    display:flex;
    align-items:center;
    gap:8px;
    padding:0 18px;
    border-top:1px solid #eee;
}

#button_area button{
    border:none;
    background:#111;
    color:#fff;
    padding:10px 14px;
    border-radius:12px;
    cursor:pointer;
}

</style>
</head>

<body>

<div id="movieModal" class="modal-backdrop">
<div id="wrap">

    <div id="movie_area">
        <div id="movie_area_wrap">

            <div id="poster_area">포스터</div>

            <div id="content_area">
                <div id="movie_name">영화 이름</div>
                <div id="movie_release_date">개봉일</div>
                <div id="movie_genre">영화 장르</div>
                <div id="movie_population">인기도</div>
                <div id="movie_score">평점</div>
            </div>

        </div>
    </div>

    <div id="review_area">
        <div id="review_list"></div>
    </div>

    <div id="button_area">
        <button id="btnLike">👍 좋아요</button>
        <button id="btnDislike">👎 싫어요</button>
        <button id="btnWriteReview">✍️ 감상문 쓰기</button>
        <button style="margin-left:auto" onclick="closeModal()">닫기</button>
    </div>

</div>
</div>

<script>
function openModal(tmdbId){
    document.getElementById("movieModal").style.display="flex";
}
function closeModal(){
    document.getElementById("movieModal").style.display="none";
}
</script>

</body>
</html>

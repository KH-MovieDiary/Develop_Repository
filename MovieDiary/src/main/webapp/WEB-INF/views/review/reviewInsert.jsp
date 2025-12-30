<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영화 등록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
        }

        .movie-register-wrapper {
            width: 70%;
            min-height: 100vh;
            margin: 0 auto;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 0;
        }

      .innerOuter {
            width: 100%;
            padding: 50px 60px;
            border-radius: 18px;
            border: 1px solid var;
            background: rgba(255,255,255,0.05);
            box-shadow: 0 18px 60px rgba(0,0,0,0.25);
        }

        .form-title {
            font-weight: 700;
            color: #343a40;
            margin-bottom: 40px;
            text-align: center;
            font-size: 1.8rem;
        }

        .form-group label {
            font-weight: 700;
            color: #495057;
            margin-bottom: 10px;
            font-size: 1rem;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #e9ecef;
            padding: 15px;
            font-size: 1rem;
            background-color: #fcfcfc;
        }
        .form-control:focus {
            background-color: #fff;
            border-color: #ff9fb3;
            box-shadow: 0 0 0 3px rgba(255, 143, 171, 0.2);
        }
        
    .btn-area {
        position: relative; 
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 50px;    
        margin-top: 30px;
        gap: 15px;            
    }
    
    .btn-area button {
        padding: 10px 30px;
        border-radius: 5px;
        font-weight: bold;
        cursor: pointer;
        
        background: linear-gradient(180deg, rgba(255,255,255,.95), rgba(248,250,252,.95));
        border: 1px solid rgba(0,0,0,.08);
        box-shadow: 0 12px 24px rgba(2,6,23,.06);
        transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease, opacity .12s ease;
    }
    
    .btn-area button:hover {
        transform: translateY(-1px);
        border-color: rgba(125,211,252,0.35);
        box-shadow: 0 18px 36px rgba(2,6,23,.08);
    }
    
    .btn-area button:active {
        transform: translateY(0) scale(.99);
    }
    
    .submit {
        background: linear-gradient(180deg,#06b6d4,#0891b2) !important;
        border-color: #06b6d4 !important;
        color: #fff !important;
        box-shadow: 0 18px 40px rgba(6,182,212,.22);
    }
    
    .reset {
        background: linear-gradient(180deg,#fb7185,#ef4444) !important;
        border-color: #fb7185 !important;
        color: #fff !important;
        box-shadow: 0 18px 40px rgba(251,113,133,.22);
    }

    </style>
</head>
<body>
	
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="movie-register-wrapper">
        <div class="innerOuter">
            <h2 class="form-title">영화감상문 작성하기</h2>
            
            <form id="enrollForm" method="post" action="${contextRoot}/insert.review">
   		
   				<div class="form-group">
                    <label for="reviewTitle">감상평 제목</label>
                    <input type="text" id="reviewTitle" class="form-control" name="reviewTitle" placeholder="" required>
                </div>
                
                <div class="form-group">
                    <label for="movieTitle">영화 제목</label>
			     	<c:choose>
			        		<c:when test="${not empty movieTitle}">
			            		<input type="text" name="movieTitle" class="form-control" value="${movieTitle}" readonly>
			            	    <input type="hidden" name="movieId" value="${movieId}">
			       			</c:when>
							<c:otherwise>
			            		 <input type="text" id="movieTitle" class="form-control" name="movieTitle" placeholder="영화를 검색하세요" onclick="openSearchModal()" required>
       							 <input type="hidden" name="movieId" value="${movieId}">
			            	</c:otherwise>
			        </c:choose>
                </div>
                
                <div class="form-group">
                    <label for="writer">작성자</label>
                    <input type="text" id="writer" class="form-control" value="${loginUser.nickName}" readonly>				
					<input type="hidden" name="userId" value="${loginUser.userId}">
                </div>

                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" class="form-control" rows="15" style="resize:none;" name="content" placeholder="영화에 대한 자유로운 감상평이나 줄거리를 기록해주세요." required></textarea>
                </div>

                <div class="btn-area">
                    <button type="submit" class="submit">등록하기</button>
                    <button type="reset" class="reset" onclick="javascript:history.go(-1);">취소하기</button>
                </div>

            </form>
        </div>
    </div>
    
    <div id="movieSearchModal" class="simple-modal-overlay">
    <div class="simple-modal-box">
        
        <div style="display:flex; justify-content:space-between; margin-bottom:10px;">
            <h4 style="margin:0;">영화 검색</h4>
            <button type="button" onclick="closeSearchModal()" style="border:none; background:none; font-size:20px; cursor:pointer;">&times;</button>
        </div>

        <div style="display:flex; gap:5px; margin-bottom:10px;">
            <input type="text" id="modalSearchKeyword" placeholder="영화 제목을 입력하세요" 
                   style="width:100%; padding:8px; border:1px solid #ccc;"
                   onkeyup="if(window.event.keyCode==13){searchMovieAjax()}">
            <button type="button" onclick="searchMovieAjax()" style="padding:8px 15px; class="modal-search-btn">검색</button>
        </div>

        <div id="searchResultArea" style="height:300px; overflow-y:auto; border:1px solid #eee;">
            </div>
    </div>
</div>

<style>
    .simple-modal-overlay, #movieSearchModal.modal-backdrop {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0, 0, 0, 0.5);
        display: none;
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }

    .simple-modal-box, #movieSearchModal .modal-box {
        background: white;
        width: 500px;      
        height: 80vh;        
        padding: 20px;
        border: 1px solid #ccc;
        display: flex;
        flex-direction: column;
    }

    .modal-header-area {
        display: flex; 
        justify-content: space-between; 
        align-items: center;
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 2px solid #333;
    }
    .modal-header-area h4 { margin: 0; font-weight: bold; color: #000; }
    .modal-close-btn { 
        background: none; border: none; font-size: 20px; cursor: pointer; 
    }

    .search-input-area {
        display: flex; 
        gap: 5px; 
        margin-bottom: 15px;
    }
    
    #modalSearchKeyword {
        flex: 1;
        padding: 10px;
        border: 1px solid #ccc;
        outline: none;
    }
    
    .modal-search-btn {
        padding: 10px 20px;
        background: #333; 
        color: white; 
        border: none;
        cursor: pointer;
    }

    #searchResultArea {
        flex: 1;           
        overflow-y: auto;  
        border: 1px solid #ddd; 
    }

    .simple-item, .search-item {
        display: flex !important;      
        align-items: center;            
        padding: 10px;
        border-bottom: 1px solid #eee;
        cursor: pointer;
        color: #000;
    }

    .simple-item:hover, .search-item:hover { background-color: #f5f5f5; }

    .simple-item img, .search-item img {
        width: 50px !important;
        height: 75px !important;
        object-fit: cover;
        margin-right: 15px;
        border: 1px solid #eee;
    }
    
    .simple-item .title, .search-item .title { font-weight: bold; font-size: 15px; margin-bottom: 5px; }
    .simple-item .date, .search-item .date { font-size: 13px; color: #666; }
</style>

<script type="text/javascript">
function openSearchModal() {
 
 document.getElementById("movieSearchModal").style.display = "flex";
 document.getElementById("modalSearchKeyword").focus();
}

function closeSearchModal() {
 document.getElementById("movieSearchModal").style.display = "none";
 document.getElementById("modalSearchKeyword").value = "";
 document.getElementById("searchResultArea").innerHTML = "";
}

function searchMovieAjax() {
 var keyword = $("#modalSearchKeyword").val();
 if(!keyword) { alert("검색어를 입력하세요"); return; }

 $.ajax({
     url: "${pageContext.request.contextPath}/tmdb/searchMovie.mo",
     data: { keyword: keyword },
     type: "GET",
     success: function(list) {
         var html = "";
         
         if(list.length === 0) {
             html = "<div>검색 결과가 없습니다.</div>";
         } else {
             for(var i=0; i<list.length; i++) {
                 var m = list[i];
                 var title = m.title ? m.title : m.original_title;
                 var date = m.release_date ? m.release_date : "";
                 var poster = m.posterUrl ? m.posterUrl : "resources/images/no-image.png";
                 var id = m.id;

                 html += `<div class="search-item" onclick="selectMovie('\${id}', '\${title.replace(/'/g, "&#39;")}')">`;
                 html += `  <img src="\${poster}">`;
                 html += `  <div class="info">`;
                 html += `    <div class="title">\${title}</div>`;
                 html += `    <div class="date">\${date}</div>`;
                 html += `  </div>`;
                 html += `</div>`;
             }
         }
         $("#searchResultArea").html(html);
     },
     error: function() {
         alert("검색 실패");
     }
 });
}

function selectMovie(id, title) {
 $("input[name='movieTitle']").val(title);
 $("input[name='movieId']").val(id);
 closeSearchModal();
}



</script>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
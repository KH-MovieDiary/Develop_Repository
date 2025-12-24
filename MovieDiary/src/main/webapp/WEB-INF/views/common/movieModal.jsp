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
            height: min(860px, 94vh);
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
            height: 46%;
            border-bottom: 1px solid #eee;
            display:flex;
            gap: 18px;
            padding: 18px;
            box-sizing:border-box;
        }
        .modal-poster{
            width: 30%;
            min-width: 240px;
            height:100%;
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
            flex-wrap:wrap;
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

        .rating-mini-wrap{
            display:flex;
            align-items:center;
            gap:8px;
            padding:6px 8px;
            border:1px solid #e5e7eb;
            border-radius:12px;
            background:linear-gradient(180deg,#ffffff,#f8fafc);
            box-shadow: 0 6px 14px rgba(0,0,0,.06);
        }
        .rating-stars{
            display:flex;
            align-items:center;
            gap:2px;
        }
        .rating-star{
            width:22px;
            height:22px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            border-radius:8px;
            border:1px solid #e5e7eb;
            background:#fff;
            cursor:pointer;
            user-select:none;
            font-size:14px;
            line-height:1;
            transition: transform .08s ease, background .12s ease, border-color .12s ease;
        }
        .rating-star:hover{
            transform: translateY(-1px);
            border-color:#f59e0b;
            background:#fffbeb;
        }
        .rating-star.active{
            border-color:#f59e0b;
            background:#f59e0b;
            color:#fff;
        }
        .rating-text{
            font-size:12px;
            font-weight:900;
            color:#111;
            min-width:52px;
            text-align:center;
        }
        .btnRatingSubmit{
            border:none !important;
            background:#111 !important;
            color:#fff !important;
            padding:8px 10px !important;
            border-radius:10px !important;
            font-weight:900 !important;
            font-size:12px !important;
            cursor:pointer !important;
        }
        .btnRatingSubmit:hover{
            opacity:.9;
        }
        .btnRatingSubmit:disabled{
            opacity:.5;
            cursor:not-allowed !important;
        }
        .rating-pill{
            display:inline-flex;
            align-items:center;
            gap:6px;
            padding:6px 10px;
            border-radius:999px;
            border:1px solid #e5e7eb;
            background:#fff;
            font-size:12px;
            font-weight:900;
        }
        .rating-pill b{
            font-size:13px;
        }
        .modal-backdrop{
		    background:
		        radial-gradient(1200px 600px at 20% 0%, rgba(125,211,252,0.22), transparent 55%),
		        radial-gradient(900px 500px at 90% 10%, rgba(167,139,250,0.18), transparent 55%),
		        radial-gradient(900px 500px at 50% 100%, rgba(52,211,153,0.12), transparent 55%),
		        rgba(0,0,0,.62);
		    backdrop-filter: blur(10px);
		    -webkit-backdrop-filter: blur(10px);
		}
		
		.modal-box{
		    background: rgba(255,255,255,.92);
		    border: 1px solid rgba(255,255,255,.35);
		    border-radius: 22px;
		    box-shadow: 0 30px 90px rgba(0,0,0,.42);
		    backdrop-filter: blur(14px);
		    -webkit-backdrop-filter: blur(14px);
		    overflow: hidden;
		    transform: translateY(6px) scale(.995);
		    animation: modalPop .18s ease-out;
		}
		@keyframes modalPop{
		    from { transform: translateY(14px) scale(.985); opacity: 0; }
		    to   { transform: translateY(6px)  scale(.995); opacity: 1; }
		}
		
		.modal-top{
		    background: linear-gradient(180deg, rgba(255,255,255,.95), rgba(255,255,255,.75));
		    border-bottom: 1px solid rgba(0,0,0,.06);
		}
		
		#modalTitle{
		    font-weight: 900;
		    letter-spacing: -0.2px;
		}
		
		.modal-close{
		    background: linear-gradient(180deg,#111827,#0b1220);
		    border: 1px solid rgba(255,255,255,.10);
		    box-shadow: 0 12px 24px rgba(0,0,0,.22);
		    transition: transform .12s ease, opacity .12s ease;
		}
		.modal-close:hover{ transform: translateY(-1px); opacity:.95; }
		.modal-close:active{ transform: translateY(0) scale(.99); }
		
		.modal-main{
		    background: transparent;
		}
		
		.modal-movie-area{
		    background: linear-gradient(180deg, rgba(255,255,255,.82), rgba(255,255,255,.64));
		    border-bottom: 1px solid rgba(0,0,0,.06);
		}
		
		.modal-poster{
		    background: linear-gradient(135deg, rgba(125,211,252,0.14), rgba(167,139,250,0.12));
		    border: 1px solid rgba(0,0,0,.06);
		    box-shadow: 0 18px 46px rgba(0,0,0,.16);
		    position: relative;
		}
		.modal-poster:before{
		    content:"";
		    position:absolute;
		    inset:-2px;
		    border-radius: 16px;
		    background:
		        radial-gradient(520px 160px at 15% 0%, rgba(125,211,252,0.26), transparent 60%),
		        radial-gradient(520px 180px at 85% 0%, rgba(167,139,250,0.22), transparent 60%);
		    pointer-events:none;
		    opacity:.9;
		}
		.modal-poster img{
		    transform: scale(1.02);
		    transition: transform .25s ease;
		}
		.modal-poster:hover img{
		    transform: scale(1.06);
		}
		
		.modal-info{
		    gap: 12px;
		}
		
		.modal-title{
		    font-size: 24px;
		    font-weight: 950;
		    letter-spacing: -0.35px;
		    line-height: 1.25;
		    margin-bottom: 4px;
		    display:flex;
		    align-items:center;
		    gap:10px;
		}
		.modal-title:after{
		    content:"";
		    width:10px;
		    height:10px;
		    border-radius:999px;
		    background: radial-gradient(circle at 30% 30%, #34d399, #7dd3fc);
		    box-shadow: 0 0 0 6px rgba(125,211,252,0.12);
		}
		
		.info-label{
		    color: rgba(17,24,39,.86);
		    letter-spacing: -0.15px;
		}
		
		.info-value{
		    background: rgba(255,255,255,.76);
		    border: 1px solid rgba(15,23,42,.08);
		    box-shadow: 0 10px 22px rgba(2,6,23,.06);
		    transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease;
		}
		.info-value:hover{
		    transform: translateY(-1px);
		    border-color: rgba(125,211,252,0.35);
		    box-shadow: 0 16px 30px rgba(2,6,23,.08);
		}
		
		.chip{
		    background: rgba(255,255,255,.82);
		    border: 1px solid rgba(0,0,0,.06);
		    box-shadow: 0 10px 18px rgba(2,6,23,.05);
		}
		
		.loading{
		    background: rgba(255,255,255,.82);
		    border: 1px solid rgba(125,211,252,0.28);
		    box-shadow: 0 12px 22px rgba(2,6,23,.06);
		}
		
		#button_area{
		    gap: 10px;
		    margin-top: 6px;
		}
		
		#button_area button{
		    background: linear-gradient(180deg, rgba(255,255,255,.95), rgba(248,250,252,.95));
		    border: 1px solid rgba(0,0,0,.08);
		    box-shadow: 0 12px 24px rgba(2,6,23,.06);
		    transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease, opacity .12s ease;
		}
		#button_area button:hover{
		    transform: translateY(-1px);
		    border-color: rgba(125,211,252,0.35);
		    box-shadow: 0 18px 36px rgba(2,6,23,.08);
		}
		#button_area button:active{
		    transform: translateY(0) scale(.99);
		}
		
		#btnLike.active{
		    background: linear-gradient(180deg,#06b6d4,#0891b2);
		    border-color:#06b6d4;
		    color:#fff;
		    box-shadow: 0 18px 40px rgba(6,182,212,.22);
		}
		#btnDislike.active{
		    background: linear-gradient(180deg,#fb7185,#ef4444);
		    border-color:#fb7185;
		    color:#fff;
		    box-shadow: 0 18px 40px rgba(251,113,133,.22);
		}
		
		.rating-mini-wrap{
		    background: linear-gradient(180deg, rgba(255,255,255,.92), rgba(248,250,252,.92));
		    border: 1px solid rgba(0,0,0,.08);
		    box-shadow: 0 14px 30px rgba(2,6,23,.07);
		}
		
		.rating-star{
		    border: 1px solid rgba(0,0,0,.08);
		    box-shadow: 0 8px 16px rgba(2,6,23,.05);
		}
		.rating-star:hover{
		    border-color: rgba(245,158,11,.45);
		    box-shadow: 0 14px 22px rgba(245,158,11,.12);
		}
		.rating-star.active{
		    box-shadow: 0 16px 30px rgba(245,158,11,.18);
		}
		
		.modal-review-area{
		    background: transparent;
		}
		
		.modal-review-box{
		    background: rgba(255,255,255,.78);
		    border: 1px solid rgba(0,0,0,.06);
		    box-shadow: 0 22px 52px rgba(2,6,23,.10);
		    border-radius: 16px;
		    position: relative;
		    overflow: hidden;
		}
		.modal-review-box:before{
		    content:"";
		    position:absolute;
		    inset:-60px;
		    background:
		        radial-gradient(600px 240px at 20% 20%, rgba(125,211,252,0.22), transparent 60%),
		        radial-gradient(520px 220px at 80% 30%, rgba(167,139,250,0.20), transparent 60%),
		        radial-gradient(520px 240px at 45% 95%, rgba(52,211,153,0.16), transparent 60%);
		    filter: blur(2px);
		    opacity:.9;
		    animation: glowMove 9s ease-in-out infinite alternate;
		    pointer-events:none;
		}
		@keyframes glowMove{
		    0%   { transform: translate3d(-12px, -10px, 0) scale(1.02); }
		    100% { transform: translate3d(14px,  12px, 0) scale(1.05); }
		}
		.modal-review-box > *{
		    position: relative;
		    z-index: 1;
		}
		
		.review-header{
		    padding: 10px 10px 8px 10px;
		    border-bottom: 1px solid rgba(0,0,0,.06);
		    margin-bottom: 10px;
		}
		
		.review-count{
		    background: rgba(255,255,255,.76);
		    border: 1px solid rgba(0,0,0,.06);
		    padding: 6px 10px;
		    border-radius: 999px;
		    box-shadow: 0 10px 18px rgba(2,6,23,.06);
		}
		
		.review-list{
		    padding-right: 8px;
		}
		.review-list::-webkit-scrollbar{ width: 8px; }
		.review-list::-webkit-scrollbar-thumb{ background: rgba(15,23,42,.18); border-radius: 999px; }
		.review-list::-webkit-scrollbar-track{ background: rgba(15,23,42,.06); border-radius: 999px; }
		
		.review-item{
		    background: rgba(255,255,255,.86);
		    border: 1px solid rgba(0,0,0,.07);
		    box-shadow: 0 14px 26px rgba(2,6,23,.06);
		    transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease;
		}
		.review-item:hover{
		    transform: translateY(-1px);
		    border-color: rgba(125,211,252,0.35);
		    box-shadow: 0 20px 36px rgba(2,6,23,.08);
		}
		
		.review-top b{
		    color: rgba(17,24,39,.92);
		}
		.review-top span{
		    color: rgba(17,24,39,.55);
		}
		
		.review-content{
		    color: rgba(17,24,39,.88);
		}
		
		.review-actions button{
		    cursor: not-allowed;
		    opacity: .78;
		    border: 1px solid rgba(0,0,0,.10);
		    background: rgba(255,255,255,.85);
		}
		
		.btnCommentDelete{
		    cursor: pointer !important;
		    opacity: 1 !important;
		    border: 1px solid rgba(0,0,0,.10);
		    background: rgba(255,255,255,.90);
		    box-shadow: 0 10px 18px rgba(2,6,23,.06);
		    transition: transform .12s ease, border-color .12s ease, background .12s ease;
		}
		.btnCommentDelete:hover{
		    transform: translateY(-1px);
		    border-color: rgba(244,63,94,.30);
		    background: rgba(255,241,242,.92);
		}
		
		#commentInput{
		    background: rgba(255,255,255,.90);
		    border: 1px solid rgba(0,0,0,.10);
		    box-shadow: 0 12px 24px rgba(2,6,23,.06);
		    transition: border-color .12s ease, box-shadow .12s ease;
		}
		#commentInput:focus{
		    border-color: rgba(125,211,252,0.42);
		    box-shadow: 0 18px 34px rgba(125,211,252,0.14);
		}
		
		#btnCommentSubmit{
		    background: linear-gradient(180deg,#111827,#0b1220);
		    box-shadow: 0 16px 34px rgba(2,6,23,.20);
		    transition: transform .12s ease, opacity .12s ease;
		}
		#btnCommentSubmit:hover{ transform: translateY(-1px); opacity:.95; }
		#btnCommentSubmit:active{ transform: translateY(0) scale(.99); }
		       	.modal-review-area{
		    padding: 14px 18px 18px;
		}
		
		.modal-review-box{
		    height: 100%;
		}
		
		.review-list{
		    flex: 1;
		    min-height: 0;
		}
		#button_area{
		    display: flex;
		    align-items: center;
		    gap: 10px;
		    flex-wrap: nowrap;
		}
		
		#btnWriteReview{
		    margin-right: 4px;
		}
		
		#ratingWrap{
		    margin-left: 0;
		}
		
		@media (max-width: 860px){
		    #button_area{
		        flex-wrap: wrap;
		    }
		}
		
		.review-actions .btnCommentLike{
		    cursor: pointer !important;          
		    opacity: 1 !important;
		    border: 1px solid rgba(0,0,0,.10) !important;
		    background: rgba(255,255,255,.90) !important;
		    box-shadow: 0 10px 18px rgba(2,6,23,.06) !important;
		    transition: transform .12s ease, border-color .12s ease, background .12s ease, box-shadow .12s ease, opacity .12s ease;
		}
		
		.review-actions .btnCommentLike:hover{
		    transform: translateY(-1px);
		    border-color: rgba(6,182,212,.35) !important;
		    background: rgba(236,254,255,.95) !important;
		    box-shadow: 0 18px 36px rgba(2,6,23,.08) !important;
		}
		
		.review-actions .btnCommentLike.active{
		    background: linear-gradient(180deg,#06b6d4,#0891b2) !important;
		    border-color: #06b6d4 !important;
		    color: #fff !important;
		    box-shadow: 0 18px 40px rgba(6,182,212,.22) !important;
		}
		
		
		.review-actions .btnCommentLike.active:hover{
		    transform: translateY(-1px);
		    filter: brightness(1.02);
		}
		
		
		.review-actions .btnCommentLike.disabled{
		    opacity: .55 !important;
		    cursor: not-allowed !important;
		    filter: grayscale(.15);
		}
		
    </style>
</head>
<body>

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
                        <div class="info-value" id="modalUserScore">
                            <span class="rating-pill">
                                ⭐ 평균 <b id="avgScoreText">-</b>
                                <span style="opacity:.7;">(</span><span id="ratingCountText">0</span><span style="opacity:.7;">명)</span>
                            </span>
                            <span style="margin-left:10px; font-size:12px; font-weight:900; color:#111;">
                                내 별점: <span id="myScoreText">-</span>
                            </span>
                        </div>
                    </div>

                    <div id="button_area">
                        <button id="btnLike" type="button">👍 좋아요(20)</button>
                        <button id="btnDislike" type="button">👎 싫어요(3)</button>
                        <button id="btnWriteReview" type="button">✍️ 감상문 쓰기</button>

  
                        <div class="rating-mini-wrap" id="ratingWrap">
                            <div class="rating-stars" id="ratingStars">
                                <span class="rating-star" data-score="1">★</span>
                                <span class="rating-star" data-score="2">★</span>
                                <span class="rating-star" data-score="3">★</span>
                                <span class="rating-star" data-score="4">★</span>
                                <span class="rating-star" data-score="5">★</span>
                            </div>
                            <div class="rating-text" id="ratingText">0/5</div>
                            <button id="btnRatingSubmit" class="btnRatingSubmit" type="button">별점등록</button>
                        </div>
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

    const RATING_STATUS_URL = "<c:url value='/rating/status.mo'/>";
    const RATING_UPSERT_URL = "<c:url value='/rating/upsert.mo'/>";
    
    const COMMENT_LIKE_STATUS_URL = "<c:url value='/commentLike/status.mo'/>";
    const COMMENT_LIKE_TOGGLE_URL = "<c:url value='/commentLike/toggle.mo'/>";


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

        resetRatingUI();
        loadRatingStatus(CURRENT_MOVIE_ID);

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

              var btn = document.getElementById("btnWriteReview");
              var ctx = "${pageContext.request.contextPath}";
              btn.setAttribute("onclick","location.href='" + ctx + "/insert.review?movieTitle=" + encodeURIComponent(title) + "&tmdbId=" +parseInt(tmdbId) + "'");

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
                    + "    <button type='button' class='btnCommentLike' data-comment-id='" + escapeHtml(commentId) + "'>👍 좋아요(" + (c.likeCount ? c.likeCount : 0) + ")</button>"
                    +      deleteBtnHtml
                    + "  </div>"
                    + "</div>";
              }

              if(list.length === 0){
                  html = "<div style='color:#333; font-weight:800; font-size:13px;'>아직 리뷰가 없습니다</div>";
              }

              document.getElementById("commentList").innerHTML = html;
              hydrateCommentLikeButtons();
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
              const parts = String(txt || "").split(",");
              const myChoice = (parts[0] || "").trim();
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

    let RATING_SCORE = 0;

    function resetRatingUI(){
        RATING_SCORE = 0;
        document.getElementById("ratingText").innerText = "0/5";
        document.querySelectorAll("#ratingStars .rating-star").forEach(s => s.classList.remove("active"));

        const btn = document.getElementById("btnRatingSubmit");
        if(btn){
            btn.disabled = !LOGIN_USER_ID;
            btn.textContent = "별점등록";
        }

        document.getElementById("avgScoreText").innerText = "-";
        document.getElementById("ratingCountText").innerText = "0";
        document.getElementById("myScoreText").innerText = "-";
    }

    function applyStarActive(score){
        document.querySelectorAll("#ratingStars .rating-star").forEach(s=>{
            const v = parseInt(s.dataset.score, 10) || 0;
            s.classList.toggle("active", v <= score);
        });
    }

    function loadRatingStatus(movieId){
        if(!movieId) return;

        const url =
            RATING_STATUS_URL
            + "?movieId=" + encodeURIComponent(movieId)
            + "&userId=" + encodeURIComponent(LOGIN_USER_ID || "");

        fetch(url)
          .then(r => r.text())    
          .then(txt => {
              const parts = String(txt || "").split(",");
              const avg = parseFloat(parts[0]) || 0;
              const count = parseInt(parts[1], 10) || 0;
              const my = parseInt(parts[2], 10) || 0;

              document.getElementById("avgScoreText").innerText = (count > 0 ? avg.toFixed(1) : "-");
              document.getElementById("ratingCountText").innerText = String(count);
              document.getElementById("myScoreText").innerText = (LOGIN_USER_ID ? (my > 0 ? (my + "/5") : "-") : "-");

              if(LOGIN_USER_ID && my > 0){
                  RATING_SCORE = my;
                  applyStarActive(my);
                  document.getElementById("ratingText").innerText = my + "/5";
                  document.getElementById("btnRatingSubmit").textContent = "별점수정";
              }
          })
          .catch(e => console.error(e));
    }

    document.querySelectorAll("#ratingStars .rating-star").forEach(star=>{
        star.addEventListener("click", ()=>{
            if(!LOGIN_USER_ID){
                alert("로그인 후 이용 가능합니다.");
                return;
            }
            RATING_SCORE = parseInt(star.dataset.score, 10) || 0;
            applyStarActive(RATING_SCORE);
            document.getElementById("ratingText").innerText = RATING_SCORE + "/5";
        });
    });

    document.getElementById("btnRatingSubmit")?.addEventListener("click", ()=>{
        if(!LOGIN_USER_ID){
            alert("로그인 후 이용 가능합니다.");
            return;
        }
        if(!CURRENT_MOVIE_ID){
            alert("영화 ID가 없습니다");
            return;
        }
        if(RATING_SCORE <= 0){
            alert("별점을 선택하세요");
            return;
        }

        const params = new URLSearchParams();
        params.append("movieId", CURRENT_MOVIE_ID);
        params.append("userId", LOGIN_USER_ID); 
        params.append("score", RATING_SCORE);

        const btn = document.getElementById("btnRatingSubmit");
        if(btn){
            btn.disabled = true;
            btn.textContent = "등록중...";
        }

        fetch(RATING_UPSERT_URL, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
            body: params.toString()
        })
        .then(r => r.text()) 
        .then(txt => {
            if(btn){
                btn.disabled = false;
                btn.textContent = "별점등록";
            }

            if(txt === "LOGIN"){
                alert("로그인 후 이용 가능합니다.");
                return;
            }
            if(txt === "BAD"){
                alert("요청이 올바르지 않습니다.");
                return;
            }

            const parts = String(txt || "").split(",");
            const avg = parseFloat(parts[0]) || 0;
            const count = parseInt(parts[1], 10) || 0;
            const my = parseInt(parts[2], 10) || 0;

            document.getElementById("avgScoreText").innerText = (count > 0 ? avg.toFixed(1) : "-");
            document.getElementById("ratingCountText").innerText = String(count);
            document.getElementById("myScoreText").innerText = (my > 0 ? (my + "/5") : "-");

            if(my > 0){
                RATING_SCORE = my;
                applyStarActive(my);
                document.getElementById("ratingText").innerText = my + "/5";
                if(btn) btn.textContent = "별점수정";
            }
        })
        .catch(e => {
            console.error(e);
            if(btn){
                btn.disabled = false;
                btn.textContent = "별점등록";
            }
            alert("처리 실패");
        });
    });
    function hydrateCommentLikeButtons(){
        const btns = document.querySelectorAll(".btnCommentLike");
        btns.forEach(btn => {
            const commentId = btn.dataset.commentId;
            if(!commentId) return;
            loadCommentLikeState(commentId, btn);
        });
    }

    function loadCommentLikeState(commentId, btn){
        fetch(COMMENT_LIKE_STATUS_URL + "?commentId=" + encodeURIComponent(commentId))
          .then(r => r.text())
          .then(txt => {
              const parts = String(txt || "").split(",");
              const myChoice = (parts[0] || "").trim();
              const likeCount = parseInt(parts[1], 10) || 0;

              btn.textContent = "👍 좋아요(" + likeCount + ")";
              btn.classList.remove("active");
              if(String(myChoice).toUpperCase() === "LIKE") btn.classList.add("active");

              if(!LOGIN_USER_ID){
                  btn.style.opacity = "0.6";
              }else{
                  btn.style.opacity = "1";
              }
          })
          .catch(e => console.error(e));
    }

    document.addEventListener("click", function(e){
        const btn = e.target.closest(".btnCommentLike");
        if(!btn) return;

        const commentId = btn.dataset.commentId;
        if(!commentId) return;

        if(!LOGIN_USER_ID){
            alert("로그인 후 이용 가능합니다.");
            return;
        }

        toggleCommentLike(commentId, btn);
    });

    function toggleCommentLike(commentId, btn){
        const params = new URLSearchParams();
        params.append("commentId", commentId);

        fetch(COMMENT_LIKE_TOGGLE_URL, {
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
            const parts = String(txt || "").split(",");
            const myChoice = (parts[0] || "").trim();
            const likeCount = parseInt(parts[1], 10) || 0;

            btn.textContent = "👍 좋아요(" + likeCount + ")";
            btn.classList.remove("active");
            if(String(myChoice).toUpperCase() === "LIKE") btn.classList.add("active");
        })
        .catch(e => {
            console.error(e);
            alert("처리 실패");
        });
    }

</script>

</body>
</html>

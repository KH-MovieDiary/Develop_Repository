<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
    .footer-wrap {
        width: 100%;
        background-color: #454545; 
        color:#bbb;        
        padding: 20px 0;       
        margin-top: 40px;       
        font-size: 15px; 
        font-family: 'Noto Sans KR', sans-serif;
    }

    .footer-inner {
        width: 90%;
        margin: 0 auto; 
    }

    .footer-links {
        border-bottom: 1px solid #555;
        padding-bottom: 15px;
        margin-bottom: 20px;
    }

    .footer-links a {
        color: #ddd;       
        text-decoration: none;
        font-weight: bold;
        margin-right: 20px; 
        transition: color 0.2s;
    }

    .footer-links a:hover {
        color: #fff;
    }

    .footer-info {
        display: flex;
        flex-direction: column;
        gap: 5px; 
    }

    .footer-brand {
        font-size: 18px;
        font-weight: 700;
        color: #eee;
        margin-bottom: 5px;
    }

    .footer-desc {
        color: #777;
        margin-bottom: 10px;
    }

    .footer-copyright {
        font-size: 12px;
        color: #666;
        line-height: 1.6; 
    }
</style>

<div class="footer-wrap">
    <div class="footer-inner">
    
        <div class="footer-links">
            <a href="#">이용약관</a>
            <a href="#">개인정보취급방침</a>
            <a href="#">공지사항</a>
        </div>
        
        <div class="footer-info">
            <div class="footer-brand">Movie Diary</div>
            
            <div class="footer-desc">여러분의 영화 같은 일상을 기록하고 공유하세요.</div>
            
            <div class="footer-copyright">
                영화정보제공 : TMDB <br>
                영화 포스터 및 스틸컷의 저작권은 각 제작사에 있습니다. <br>
                Copyright © 2025 Movie Diary All Right Reserved
            </div>
        </div>

    </div>
</div>
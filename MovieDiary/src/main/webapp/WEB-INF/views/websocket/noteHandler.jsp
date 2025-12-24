<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간 쪽지 보내기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        margin: 0;
    }

    .note-card {
        width: 100%;
        max-width: 500px;
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        padding: 40px;
        border: none;
    }

    .note-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .note-header h2 {
        font-weight: 700;
        color: #333;
        font-size: 24px;
        letter-spacing: -1px;
    }

    .note-header p {
        color: #888;
        font-size: 14px;
    }

    .form-group label {
        font-weight: 600;
        color: #555;
        font-size: 14px;
        margin-left: 5px;
    }

    .form-control {
        border-radius: 12px;
        border: 1px solid #e1e1e1;
        padding: 12px 15px;
        font-size: 15px;
        transition: all 0.3s ease;
    }

    .form-control:focus {
        border-color: #333;
        box-shadow: 0 0 0 0.2rem rgba(0,0,0,0.05);
    }

    .form-control-plaintext {
        background-color: #f1f3f5 !important;
        font-weight: 600;
        color: #495057;
        padding-left: 15px;
    }

    textarea.form-control {
        resize: none;
        height: 180px;
    }

    .btn-area {
        display: flex;
        gap: 10px;
        margin-top: 30px;
    }

    .btn-custom {
        height: 50px;
        border-radius: 12px;
        font-weight: 600;
        flex: 1;
        transition: all 0.3s;
    }

    .btn-send {
        background-color: #333;
        color: #fff;
        border: none;
    }

    .btn-send:hover {
        background-color: #000;
        transform: translateY(-2px);
    }

    .btn-back {
        background-color: #fff;
        border: 1px solid #ddd;
        color: #666;
    }

    .btn-back:hover {
        background-color: #f8f9fa;
        color: #333;
    }

    /* 아이콘 스타일 */
    .icon-box {
        width: 60px;
        height: 60px;
        background: #f1f3f5;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        font-size: 24px;
    }
</style>
</head>
<body>

<div class="note-card">
    <div class="note-header">
        <div class="icon-box">✉️</div>
        <h2>쪽지 보내기</h2>
        <p>상대방에게 마음을 전해보세요</p>
    </div>

    <div class="form-group">
        <label>받는 사람</label>
        <input type="text" id="targetId" class="form-control form-control-plaintext" readonly>
    </div>

    <div class="form-group">
        <label>내용</label>
        <textarea id="noteMsg" class="form-control" placeholder="영화에 대한 생각이나 궁금한 점을 적어보세요."></textarea>
    </div>

    <div class="btn-area">
        <button type="button" class="btn-custom btn-back" onclick="history.back();">취소</button>
        <button type="button" class="btn-custom btn-send" onclick="sendNote();">보내기</button>
    </div>
</div>



</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간 쪽지 보내기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>

<div class="innerOuter" style="padding: 50px;">
    <h2>실시간 쪽지 전송</h2>
    <br>
    <div class="form-group">
        <label>받는 사람</label>
        <input type="text" id="targetId" class="form-control" 
               style="background-color: #e9ecef;" readonly>
        <br>
        <label>쪽지 내용</label>
        <textarea id="noteMsg" class="form-control" rows="5" placeholder="보낼 내용을 입력하세요"></textarea>
    </div>
    <div class="btns">
        <button type="button" class="custom-btn btn-primary" onclick="sendNote();">쪽지 발송</button>
        <button type="button" class="custom-btn btn-secondary" onclick="history.back();">취소</button>
    </div>
</div>

<script>
    var noteSocket = null;

    $(document).ready(function() {
        // 1. 주소창에서 파라미터 가져오기
        var urlParams = new URLSearchParams(window.location.search);
        var targetIdFromUrl = urlParams.get('targetId');

        if(targetIdFromUrl) {
            $("#targetId").val(targetIdFromUrl); // 받는 사람 칸에 자동 입력
        }

        // 2. 웹소켓 연결
        noteSocket = new WebSocket("ws://localhost:8080/moviediary/note-ws");

        noteSocket.onmessage = function(event) {
            var msg = event.data.split("|");
            if(msg[0] === "RECEIVED_NOTE") {
                // 오타 수정: lert -> alert
                alert(msg[1] + "님으로부터 새 쪽지: " + msg[2]);
            }
        };

        noteSocket.onopen = function() { 
            console.log("실시간 서버 연결 성공"); 
        };
    });

    function sendNote() {
        var target = $("#targetId").val();
        var content = $("#noteMsg").val();
        
        // 오타 수정: 조건문 및 alert 추가
        if(!target || !content) {
            alert("보낼 내용을 입력해주세요.");
            return;
        }

        // 서버의 NoteHandler로 데이터 전송
        noteSocket.send(target + "|" + content);
        alert("쪽지를 성공적으로 보냈습니다.");
        
        // 오타 수정: ack() -> history.back()
        history.back(); 
    }
</script>

</body>
</html>
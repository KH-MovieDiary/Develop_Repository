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
    /* ... 제공해주신 스타일 유지 ... */
    body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fa; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }
    .note-card { width: 70%; min-width:800px; height:70%; min-height:600px; background: #fff; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); padding: 40px; border: none; }
    .note-header { text-align: center; margin-bottom: 30px; }
    .note-header h2 { font-weight: 700; color: #333; font-size: 24px; letter-spacing: -1px; }
    .note-header p { color: #888; font-size: 14px; }
    .form-group label { font-weight: 600; color: #555; font-size: 14px; margin-left: 5px; }
    .form-control { border-radius: 12px; border: 1px solid #e1e1e1; padding: 12px 15px; font-size: 15px; transition: all 0.3s ease; }
    .form-control:focus { border-color: #333; box-shadow: 0 0 0 0.2rem rgba(0,0,0,0.05); }
    .form-control-plaintext { background-color: #f1f3f5 !important; font-weight: 600; color: #495057; padding-left: 15px; }
    textarea.form-control { resize: none; height: 300px; }
    .btn-area { display: flex; gap: 10px; margin-top: 30px; align-items: center; justify-content: center;}
    .btn-custom { height: 40px; max-width:100px; border-radius: 12px; font-weight: 600; flex: 1; transition: all 0.3s; }
    .btn-send { background-color: #333; color: #fff; border: none; }
    .btn-send:hover { background-color: #000; transform: translateY(-2px); }
    .btn-back { background-color: #fff; border: 1px solid #ddd; color: #666; }
    .btn-back:hover { background-color: #f8f9fa; color: #333; }
    .icon-box { width: 60px; height: 60px; background: #f1f3f5; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; font-size: 24px; }
</style>
</head>
<body>

<form action="${pageContext.request.contextPath}/websocket/insertNote.do" method="post">
    <div class="note-card">
        <div class="note-header">
            <h2>쪽지 보내기</h2>
        </div>

        <div class="form-group">
            <label>받는 사람</label>
            <input type="text" name="receiveId" id="targetId" value="${param.targetId}" 
                   class="form-control form-control-plaintext" readonly>
        </div>

        <div class="form-group">
            <label>내용</label>
            <textarea name="noteContent" id="noteMsg" class="form-control" required></textarea>
        </div>

        <div class="btn-area">
        	<button type="submit" class="btn-custom btn-send">보내기</button>
            <button type="button" class="btn-custom btn-back" onclick="history.back();">취소</button>
        </div>
    </div>
</form>

<script>
    function sendNote() {
        var target = $("#targetId").val();
        var content = $("#noteMsg").val();
        
        if(!content.trim()) { 
            alert("보낼 내용을 입력해주세요."); 
            return; 
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/websocket/insertNote.do",
            data: {
                receiveId: target, // Note VO의 필드명과 일치
                noteContent: content  // Note VO의 필드명과 일치
            },
            type: "post",
            success: function(result) {
                if(result === "success") {
                    // 서버가 정상 가동 중이므로 웹소켓 알림을 시도합니다
                    if(window.opener && window.opener.noteSocket && window.opener.noteSocket.readyState === WebSocket.OPEN) {
                        window.opener.noteSocket.send(target + "|" + content);
                    }
                    alert("쪽지를 보냈습니다.");
                    location.href = "${pageContext.request.contextPath}/websocket/noteList";
                } else {
                    alert("쪽지 발송에 실패했습니다.");
                }
            },
            error: function() { 
                alert("서버 통신 중 오류가 발생했습니다."); 
            }
        });
    }
</script>

</body>
</html>
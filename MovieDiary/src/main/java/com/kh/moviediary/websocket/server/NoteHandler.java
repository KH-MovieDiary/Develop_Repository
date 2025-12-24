package com.kh.moviediary.websocket.server;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.moviediary.member.vo.Member;

public class NoteHandler extends TextWebSocketHandler{
	
	// 현재 접속 중인 유저의 ID와 세션을 매핑하여 저장
    private Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String userId = getUserId(session);
        if (userId != null) {
            userSessions.put(userId, session); // 접속 시 명부에 기록
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 메시지 포맷 규약: "받는사람ID|내용"
        String payload = message.getPayload();
        String[] data = payload.split("\\|");
        
        if (data.length == 2) {
            String targetId = data[0];
            String content = data[1];
            String senderId = getUserId(session); // 보낸 사람

            WebSocketSession targetSession = userSessions.get(targetId);
            if (targetSession != null && targetSession.isOpen()) {
                // 상대방이 접속 중이면 실시간 전송
                targetSession.sendMessage(new TextMessage("RECEIVED_NOTE|" + senderId + "|" + content));
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String userId = getUserId(session);
        if (userId != null) {
            userSessions.remove(userId); // 종료 시 명부에서 제거
        }
    }

    private String getUserId(WebSocketSession session) {
        Member loginUser = (Member) session.getAttributes().get("loginUser");
        return (loginUser != null) ? loginUser.getUserId() : null;
    }
	
	

}

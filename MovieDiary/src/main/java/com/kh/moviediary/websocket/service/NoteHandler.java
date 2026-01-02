package com.kh.moviediary.websocket.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.kh.moviediary.member.vo.Member;
import org.springframework.stereotype.Component;

@Component("noteHandler") // Bean 이름 지정
public class NoteHandler extends TextWebSocketHandler {
    
    // 닉네임을 키로 사용하는 스레드 안전한 맵
    private static Map<String, WebSocketSession> users = new ConcurrentHashMap<>();

    // NoteHandler.java 수정 로직
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        Member loginUser = (Member)session.getAttributes().get("loginUser");
        if(loginUser != null) {
            // 닉네임으로 저장 (JSP에서 닉네임으로 메시지를 보내기 때문)
            users.put(loginUser.getNickName(), session); 
            System.out.println(loginUser.getNickName() + "님 연결 성공");
        }
    }

    // 헬퍼 메서드 수정: 아이디가 아니라 닉네임을 가져오도록 변경
    private String getUserNick(WebSocketSession session) {
        Member loginUser = (Member) session.getAttributes().get("loginUser");
        return (loginUser != null) ? loginUser.getNickName() : null;
    }
    
    public static void sendAlarm(String targetNick) throws Exception {
        WebSocketSession targetSession = users.get(targetNick);
        if (targetSession != null && targetSession.isOpen()) {
            targetSession.sendMessage(new TextMessage("RECEIVED_NOTE|System|새 쪽지가 도착했습니다."));
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        String[] data = payload.split("\\|");
        
        if (data.length == 2) {
            String targetNick = data[0]; // JSP에서 보낸 받는 사람 닉네임
            String content = data[1];
            String senderNick = getUserNick(session); // 보낸 사람 닉네임

            WebSocketSession targetSession = users.get(targetNick);
            if (targetSession != null && targetSession.isOpen()) {
                // 상대방에게 알림 전송 (이 포맷을 브라우저가 받음)
                targetSession.sendMessage(new TextMessage("RECEIVED_NOTE|" + senderNick + "|" + content));
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String nickName = getUserNick(session);
        if (nickName != null) {
            users.remove(nickName); // 닉네임으로 제거
        }
    }

   
}
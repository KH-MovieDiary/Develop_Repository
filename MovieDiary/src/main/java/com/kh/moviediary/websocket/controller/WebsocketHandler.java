package com.kh.moviediary.websocket.controller;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.kh.moviediary.member.vo.Member;

@Component
public class WebsocketHandler extends TextWebSocketHandler {

    // 접속한 유저의 닉네임과 세션을 매핑하여 저장 (실시간 알림 대상 찾기용)
    private static Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<>();

    
    // 웹소켓 연결 성공 시
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String nickName = getNickName(session);
        if (nickName != null) {
            userSessions.put(nickName, session);
            System.out.println(nickName+"연결성공");
        }
    }
    
    
    public static void sendNoteAlarm(String receiverNick) throws Exception {
        WebSocketSession session = userSessions.get(receiverNick);
        if(session != null && session.isOpen()) {
            session.sendMessage(new TextMessage("newNote"));
        }
    }

 

    // 연결 종료 시
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String nickName = getNickName(session);
        if (nickName != null) {
            userSessions.remove(nickName);
        }
    }

    // HttpSession에서 로그인 유저의 닉네임을 가져오는 보조 메소드
    private String getNickName(WebSocketSession session) {
        Map<String, Object> httpSession = session.getAttributes();
        Member loginUser = (Member) httpSession.get("loginUser");
        return (loginUser != null) ? loginUser.getNickName() : null;
    }
}
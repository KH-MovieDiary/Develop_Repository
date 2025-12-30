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
    private static Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<>();

    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String nickName = getNickName(session);
        if (nickName != null) {
            userSessions.put(nickName, session);
        }
    }
    
    
    public static void sendNoteAlarm(String receiverNick) throws Exception {
        WebSocketSession session = userSessions.get(receiverNick);
        if(session != null && session.isOpen()) {
            session.sendMessage(new TextMessage("newNote"));
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String nickName = getNickName(session);
        if (nickName != null) {
            userSessions.remove(nickName);
        }
    }

    private String getNickName(WebSocketSession session) {
        Map<String, Object> httpSession = session.getAttributes();
        Member loginUser = (Member) httpSession.get("loginUser");
        return (loginUser != null) ? loginUser.getNickName() : null;
    }
}
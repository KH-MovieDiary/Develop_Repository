package com.kh.moviediary.websocket.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.moviediary.websocket.controller.WebsocketHandler;
import com.kh.moviediary.websocket.service.NoteHandler;

//WebSocketConfig.java
@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
 
 @Autowired
 private NoteHandler noteHandler; // 반드시 NoteHandler 타입을 주입받으세요!

 @Override
 public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
     // 경로(/note-ws)와 핸들러(noteHandler)가 정확히 매칭되어야 합니다.
     registry.addHandler(noteHandler, "/note-ws")
             .addInterceptors(new HttpSessionHandshakeInterceptor())
             .setAllowedOrigins("*");
 }
}

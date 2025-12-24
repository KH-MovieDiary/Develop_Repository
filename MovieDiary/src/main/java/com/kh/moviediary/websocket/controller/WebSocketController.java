package com.kh.moviediary.websocket.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/websocket")
public class WebSocketController {
	
	@GetMapping("/noteHandler")
	public String noteHandlerPage() {
		return "websocket/noteHandler";
	}
	
	

}

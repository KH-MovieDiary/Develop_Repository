package com.kh.moviediary.websocket.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class Note {
	private int noteNo;
	private String sendNickName;
	private String receiveNickName;
	private String time;
	private String noteContent;
	private String status;

}

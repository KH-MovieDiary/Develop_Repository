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
	private String sendId;
	private String receiveId;
	private String time;
	private String nContent;

}

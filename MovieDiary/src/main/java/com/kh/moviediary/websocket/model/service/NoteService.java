package com.kh.moviediary.websocket.model.service;

import com.kh.moviediary.websocket.model.vo.Note;

public interface NoteService {
    // 쪽지 저장 (발송 시 호출)
    int insertNote(Note n);
    
 
}
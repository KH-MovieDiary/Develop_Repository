package com.kh.moviediary.websocket.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.moviediary.common.vo.ReviewPageInfo;
import com.kh.moviediary.websocket.model.vo.Note;

public interface NoteService {
    // 쪽지 저장 (발송 시 호출)
    int insertNote(Note n);

    List<Note> selectReceivedNoteList(ReviewPageInfo pi, String userId);
    List<Note> selectSentNoteList(ReviewPageInfo pi, String userId);

	int selectListCount(String userId);
	int selectSentListCount(String userId);

    
 
}
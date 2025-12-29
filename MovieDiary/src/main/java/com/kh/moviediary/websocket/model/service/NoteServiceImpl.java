package com.kh.moviediary.websocket.model.service;

import java.util.ArrayList;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.common.vo.ReviewPageInfo;
import com.kh.moviediary.websocket.model.dao.NoteDao;
import com.kh.moviediary.websocket.model.vo.Note;

@Service
public class NoteServiceImpl implements NoteService {
    
    @Autowired
    private SqlSessionTemplate sqlSession;
    
    @Autowired
    private NoteDao Dao;

    @Override
    public int insertNote(Note n) {
        return Dao.insertNote(sqlSession, n);
    }

	@Override
	public List<Note> selectReceivedNoteList(ReviewPageInfo pi, String userId) {
		return Dao.selectReceivedNoteList(sqlSession, pi, userId);
	}

	@Override
	public List<Note> selectSentNoteList(ReviewPageInfo pi, String userId) {
		return Dao.selectSentNoteList(sqlSession, pi, userId);
	}

	@Override
	public int selectListCount(String userId) {
	    return Dao.selectListCount(sqlSession, userId);
	}

	@Override
	public int selectSentListCount(String userId) {
		return Dao.selectSentListCount(sqlSession, userId);
	}

	@Override
	public Note selectNoteDetail(int nno) {
		return Dao.selectNoteDetail(sqlSession, nno);
	}


	

}

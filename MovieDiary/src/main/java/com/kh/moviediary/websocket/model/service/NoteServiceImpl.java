package com.kh.moviediary.websocket.model.service;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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

}

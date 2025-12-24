package com.kh.moviediary.websocket.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.websocket.model.vo.Note;

@Repository
public class NoteDao {

	public int insertNote(SqlSessionTemplate sqlSession, Note n) {
		return sqlSession.insert("noteMapper.insertNote",n);
	}


}

package com.kh.moviediary.websocket.model.dao;

import java.util.List;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.kh.moviediary.common.vo.ReviewPageInfo;
import com.kh.moviediary.websocket.model.vo.Note;

@Repository
public class NoteDao {

    public int insertNote(SqlSessionTemplate sqlSession, Note n) {
        return sqlSession.insert("noteMapper.insertNote", n);
    }

    public int selectListCount(SqlSessionTemplate sqlSession, String userId) {
        return sqlSession.selectOne("noteMapper.selectListCount", userId);
    }

    public List<Note> selectReceivedNoteList(SqlSessionTemplate sqlSession, ReviewPageInfo pi, String userId) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return sqlSession.selectList("noteMapper.selectReceivedNoteList", userId, rowBounds);
    }

    public List<Note> selectSentNoteList(SqlSessionTemplate sqlSession, ReviewPageInfo pi, String userId) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return sqlSession.selectList("noteMapper.selectSentNoteList", userId, rowBounds);
    }

	public int selectSentListCount(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("noteMapper.selectSentListCount", userId);
	}

	public Note selectNoteDetail(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.selectOne("noteMapper.selectNoteDetail", nno);
	}

	public int deleteNote(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.update("noteMapper.deleteNote",nno);
	}
}
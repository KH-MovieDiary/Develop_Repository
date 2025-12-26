package com.kh.moviediary.websocket.model.dao;

import java.util.List;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.kh.moviediary.common.vo.ReviewPageInfo;
import com.kh.moviediary.websocket.model.vo.Note;

@Repository
public class NoteDao {

    // 1. 쪽지 저장
    public int insertNote(SqlSessionTemplate sqlSession, Note n) {
        return sqlSession.insert("noteMapper.insertNote", n);
    }

    // 2. 전체 개수 조회 (페이징바 생성용)
    public int selectListCount(SqlSessionTemplate sqlSession, String userId) {
        return sqlSession.selectOne("noteMapper.selectListCount", userId);
    }

    // 3. 받은 쪽지 목록 조회 (RowBounds 페이징 적용)
    public List<Note> selectReceivedNoteList(SqlSessionTemplate sqlSession, ReviewPageInfo pi, String userId) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return sqlSession.selectList("noteMapper.selectReceivedNoteList", userId, rowBounds);
    }

    // 4. 보낸 쪽지 목록 조회 (RowBounds 페이징 적용)
    public List<Note> selectSentNoteList(SqlSessionTemplate sqlSession, ReviewPageInfo pi, String userId) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return sqlSession.selectList("noteMapper.selectSentNoteList", userId, rowBounds);
    }

	public int selectSentListCount(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("noteMapper.selectSentListCount", userId);
	}
}
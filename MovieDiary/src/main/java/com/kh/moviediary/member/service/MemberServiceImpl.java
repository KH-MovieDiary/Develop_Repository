package com.kh.moviediary.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.member.dao.MemberDao;
import com.kh.moviediary.member.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertMember(Member m) {
		return dao.insertMember(sqlSession, m);
	}

	@Override
	public int idCheck(String inputId) {
		return dao.idCheck(sqlSession, inputId);
	}

	@Override
	public int nickCheck(String nickName) {
		return dao.nickCheck(sqlSession, nickName);
	}

	@Override
	public Member loginUser(Member m) {
		Member loginUser = dao.loginUser(sqlSession, m);
		
		// 가져온 회원 정보가 있다면 가공 로직 실행
        if(loginUser != null) {
            processMemberData(loginUser);
        }
		return loginUser;
	}

	@Override
	public int updateMember(Member m) {
		return dao.updateUser(sqlSession, m);
	}

	@Override
	public int deleteMember(String userId) {
		return dao.deleteMember(sqlSession, userId);
	}
	
	
	private void processMemberData(Member m) {
        // 1. 나이 계산
        if (m.getBirthday() != null) {
            try {
                java.util.Calendar birth = java.util.Calendar.getInstance();
                birth.setTime(m.getBirthday());
                int bYear = birth.get(java.util.Calendar.YEAR);
                int bMonth = birth.get(java.util.Calendar.MONTH) + 1;
                int bDay = birth.get(java.util.Calendar.DAY_OF_MONTH);

                java.util.Calendar now = java.util.Calendar.getInstance();
                int nYear = now.get(java.util.Calendar.YEAR);
                int nMonth = now.get(java.util.Calendar.MONTH) + 1;
                int nDay = now.get(java.util.Calendar.DAY_OF_MONTH);

                int age = nYear - bYear;
                if (nMonth < bMonth || (nMonth == bMonth && nDay < bDay)) {
                    age--;
                }
                m.setAge(age); // VO의 필드에 세팅
            } catch (Exception e) { m.setAge(0); }
        }

        // 2. 장르 이름 변환
        if (m.getFavoriteGenre() != null && !m.getFavoriteGenre().isEmpty()) {
            java.util.Map<String, String> genreMap = new java.util.HashMap<>();
            genreMap.put("10751", "가족");   genreMap.put("27", "공포");
            genreMap.put("9648", "미스터리"); genreMap.put("12", "모험");
            genreMap.put("10402", "음악");   genreMap.put("10770", "TV영화");
            genreMap.put("99", "다큐멘터리"); genreMap.put("18", "드라마");
            genreMap.put("10749", "로맨스");  genreMap.put("80", "범죄");
            genreMap.put("10752", "전쟁");   genreMap.put("36", "역사");
            genreMap.put("37", "서부");      genreMap.put("53", "스릴러");
            genreMap.put("878", "SF");      genreMap.put("16", "애니메이션");
            genreMap.put("35", "코미디");    genreMap.put("14", "판타지");

            String[] codes = m.getFavoriteGenre().split(",");
            java.util.List<String> names = new java.util.ArrayList<>();
            for (String code : codes) {
                String name = genreMap.get(code.trim());
                if (name != null) names.add(name);
            }
            m.setGenreNames(String.join(", ", names)); // VO의 필드에 세팅
        } else {
            m.setGenreNames("선택 안 함");
        }
    }
	

}

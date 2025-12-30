package com.kh.moviediary.member.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class Member {
	
	private String userId;
	private String userPwd;
	private String email;
	private String birthday;
	private String gender;
	private String nickName;
	private String favoriteGenre;
	private Date createDate;
	private Date updateDate;
	private String picture;
	private String status;

	
	public int getAge() {
	    if (this.birthday == null || this.birthday.isEmpty()) return 0;
	    
	    try {
	        String[] parts = this.birthday.split("-");
	        int bYear = Integer.parseInt(parts[0]);
	        int bMonth = Integer.parseInt(parts[1]);
	        int bDay = Integer.parseInt(parts[2]);
	        
	        java.util.Calendar now = java.util.Calendar.getInstance();
	        int nYear = now.get(java.util.Calendar.YEAR);
	        int nMonth = now.get(java.util.Calendar.MONTH) + 1;
	        int nDay = now.get(java.util.Calendar.DAY_OF_MONTH);
	        
	        int age = nYear - bYear;
	        if (nMonth < bMonth || (nMonth == bMonth && nDay < bDay)) {
	            age--;
	        }
	        return age;
	    } catch (Exception e) {
	        return 0;
	    }
	}

	
	
	public String getGenreNames() {
	    if (this.favoriteGenre == null || this.favoriteGenre.isEmpty()) return "선택 안 함";
	    
	    // 장르 코드와 명칭 매핑
	    java.util.Map<String, String> genreMap = new java.util.HashMap<>();
	    genreMap.put("10751", "가족");   genreMap.put("27", "공포");
	    genreMap.put("9648", "미스터리"); genreMap.put("12", "모험");
	    genreMap.put("10402", "음악");   genreMap.put("10770", "TV영화");
	    genreMap.put("99", "다큐멘터리"); genreMap.put("18", "드라마");
	    genreMap.put("10749", "로맨스");  genreMap.put("80", "범죄");
	    genreMap.put("10752", "전쟁");   genreMap.put("36", "역사");
	    genreMap.put("37", "서부");     genreMap.put("53", "스릴러");
	    genreMap.put("878", "SF");      genreMap.put("16", "애니메이션");
	    genreMap.put("35", "코미디");    genreMap.put("14", "판타지");

	    String[] codes = this.favoriteGenre.split(",");
	    java.util.List<String> names = new java.util.ArrayList<>();
	    
	    for (String code : codes) {
	        String name = genreMap.get(code.trim());
	        if (name != null) names.add(name);
	    }
	    
	    return String.join(", ", names);
	}
	
	
	
}



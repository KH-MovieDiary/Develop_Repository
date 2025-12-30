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
	private Date birthday;
	private String gender;
	private String nickName;
	private String favoriteGenre;
	private Date createDate;
	private Date updateDate;
	private String picture;
	private String status;
	
	private int age;
    private String genreNames;
	
}



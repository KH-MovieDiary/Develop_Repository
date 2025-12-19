package com.kh.moviediary.member.vo;

import java.util.Date;

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
	private int age;
	private String gender;
	private String nickname;
	private String favoriteGenre;
	private Date createDate;
	private Date updateDate;
	private String picture;
	private String status;

}

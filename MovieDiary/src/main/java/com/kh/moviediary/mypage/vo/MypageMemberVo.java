package com.kh.moviediary.mypage.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public
class MypageMemberVo {

	private String userId;
	private String userPwd;
	private String email;
	private int Age;
	private String gender;
	private String nickName;
	private String favoritGenre;
	private Date createDate;
	private Date updateDate;
	private String picture;
	private String status;
}

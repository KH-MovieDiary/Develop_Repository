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

	private String userId; //USER_ID VARCHAR2(100BYTE)
	private String userPwd; //USER_PWD VARCHAR2(255BYTE)
	private String email; //EMAIL VARCHAR2(150BYTE)
	private int age; //AGE NUMBER
	private String gender; //GENDER VARCHAR2(10BYTE)
	private String nickName; //NICKNAME VARCHAR2(50BYTE)
	private String favoriteGenre; //FAVORITE_GENRE VARCHAR2(50BYTE)
	private Date createDate; //CREATE_DATE VARCHAR2
	private Date updateDate; //UPDATE DATE VARCHAR2
	private String picture; //PICTURE VARCHAR2(1000BYTE)
	private String status; //STATUS VARCHAR2(1BYTE)
	
}

package com.oracle.S202350102.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class User1 {
	private int 	user_num;		// 회원번호
	private int 	user_level;		// 유저레벨
	private String 	user_id;		// 아이디
	private String 	user_pswd;		// 비밀번호
	private String 	nick;			// 닉네임
	private String 	user_name;		// 이름
	private String 	email;			// 이메일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date   	birth;			// 생년월일
	private String 	addr;			// 주소
	private String 	tel;			// 전화번호
	private String 	gender;			// 성별
	private String 	img;			// 프로필사진
	private Date 	reg_date;		// 가입일자
	private Date 	mod_date;		// 수정일자
	private Date 	end_date;		// 탈퇴일자
	private String 	delete_yn;		// 탈퇴여부
	private Date 	last_lgn_date;	// 마지막로그인
	private int 	status_lg;		// 회원상태(대분류)
	private int 	status_md;		// 회원상태(중분류)
	private int 	user_exp;		// 경험치
	private int 	report_cnt;		// 신고횟수
	private int 	subs_amount;	// 결제금액
	private String	zipCode;		// 우편번호
	
	// board 작성일자 출력용
	private Date brd_reg_date;
	
	// 유저 경험치 정보 조회
	private int remain_exp;
	private int percentage;
	private String icon;
	
	// following 조회용
	private int following_id;
	private int matpal;
	private int following_cnt;
	private int follower_cnt;
	
	// 페이징 조회용    //검색타입						 //검색 내용
	private String search;   	private String keyword;
	private String pageNum;
	private int start; 		 	private int end;
	
	// following 리스트 조회용(로그인한 내 user_num)
	private int my_user_num;
}

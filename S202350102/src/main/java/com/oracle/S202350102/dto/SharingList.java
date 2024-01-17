package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class SharingList {
	private int 	brd_num;	// 게시물등록번호
	private int 	user_num;	// 회원번호
	private Date 	reg_date;	// 신청일자
	private int 	state_lg;	// 진행상태(대분류)
	private int 	state_md;	// 진행상태(중분류)
	private String 	reject_msg;	// 반려사유
	private String 	message;	// 전달메세지
	
	
	// 페이징 조회용    //검색타입						 //검색 내용
	private String search;   	private String keyword;
	private String pageNum;
	private int start; 		 	private int end;
	private String searchType;
	private String category;
	
	
	
	//join
	private String title;
	private String user_name;
	private String nick;
	private String tel;
	private String addr;
	private String participants;
	private String applicants;
}


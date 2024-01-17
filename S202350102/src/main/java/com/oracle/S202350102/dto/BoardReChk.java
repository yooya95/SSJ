package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BoardReChk {
	private int 	brd_num;	// 게시물등록번호
	private int 	re_step;	// 댓글순서
	private int 	user_num;	// 원글회원번호
	private String	send_date; 	// 알림 발생 일시
	private Date 	read_date; 	// 알림 확인 일시
	
	
	
	// 조회용
	private String  title; // 글의 제목 조회
	private String  brd_md; // 글의 제목 조회
	private int 	new_Cmt; // 새 댓글 수 조회
	private String 	chg_id; // 새 댓글 수 조회
	
}

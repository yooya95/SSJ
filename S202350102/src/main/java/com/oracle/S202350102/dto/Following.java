package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Following {
	private int 	user_num;	 	// 회원번호
	private int 	following_id;   // 팔로잉id
	private String 	send_state; 	// 알림 발생 일시
	private Date 	read_date; 	 	// 알림 발생 일시
}

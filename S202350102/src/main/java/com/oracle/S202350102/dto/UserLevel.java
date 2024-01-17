package com.oracle.S202350102.dto;

import lombok.Data;

// Join 목적
@Data
public class UserLevel {
	private int 	user_num;		// 회원번호
	private int 	user_exp;		// 경험치
	
	private int 	user_level;		// 유저레벨
	
	private int 	req_exp;	// 필요경험치 ex) 1->2 , 2->3
	private int 	tot_exp;	// 경험치총량
	private String 	lv_name;	// 레벨명
}

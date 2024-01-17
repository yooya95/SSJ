package com.oracle.S202350102.dto;

import lombok.Data;

@Data
public class Level1 {
	private int 	user_level;	// 레벨
	private int 	req_exp;	// 필요경험치 ex) 1->2 , 2->3
	private int 	tot_exp;	// 경험치총량
	private String 	lv_name;	// 레벨명
	
}

package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class KakaoPayReadyVO {
	
	//response
	private String 	tid, next_redirect_pc_url;
	private Date 	create_at;
}


package com.oracle.S202350102.dto;

import lombok.Data;

@Data
public class BadWord {
	private int 	id; 	// 금지어넘버링
	private String 	word;	// 금지어
	private String 	reason; // 금지어이유?
}

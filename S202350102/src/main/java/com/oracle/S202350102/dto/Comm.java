package com.oracle.S202350102.dto;

import lombok.Data;

@Data
public class Comm {
	private int 	lg;  // 대분류
	private int 	md;  // 중분류
	private String	ctn; // 소분류
}

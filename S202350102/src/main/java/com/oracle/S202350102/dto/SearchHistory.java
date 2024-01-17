package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class SearchHistory {
	private int 	user_num;  // 회원번호
	private String 	srch_word; // 검색어
	private Date 	srch_date; // 검색날짜
}

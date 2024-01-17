package com.oracle.S202350102.dto;

import lombok.Data;

@Data
public class MapList {
	private int 	loc_num; // 지역코드번호
	private int 	brd_num; // 게시물등록번호
	private String  lat;	 // 위도
	private String 	lot;	 // 경도
}

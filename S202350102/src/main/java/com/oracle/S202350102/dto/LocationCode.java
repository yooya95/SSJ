package com.oracle.S202350102.dto;

import lombok.Data;

@Data
public class LocationCode {
	private int 	loc_num;	// 지역코드번호
	private String 	si_do;		// 지역시도
	private String 	si_gun_gu;	// 지역시군구
	private String 	gun_gu; 	// 지역군구명
}

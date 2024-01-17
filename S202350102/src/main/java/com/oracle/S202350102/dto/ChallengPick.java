package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ChallengPick {
	private int  chg_id;	// 챌린지등록번호
	private int  user_num;	// 회원번호
	private Date pick_date;	// 찜날짜
}

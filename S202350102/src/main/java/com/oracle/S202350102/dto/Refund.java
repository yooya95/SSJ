package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Refund {
	private int 	user_num;		// 회원번호
	private int 	order_num;		// 주문번호
	private int 	rfnd_num;		// 환불번호
	private int 	mem_num;		// 멤버쉽번호
	private Date 	create_date;	// 취소요청시간
	private Date	suc_date;		// 취소완료시간
	private int 	price;			// 환불금액
	private String 	rslt_status;	// 결과상태
	private String 	rslt_message;	// 결과메세지
	
}

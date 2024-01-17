package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Order1 {
	private int 	user_num;	  	// 회원번호
	private int 	order_num;	  	// 주문번호
	private int		mem_num;		// 멤버쉽번호
	private String 	pay_type;	  	// 결제수단
	private Date 	create_date; 	// 결제요청날짜
	private Date 	suc_date;	  	// 결제완료날짜
	private String 	rslt_status;  	// 결과상태
	private String	tid;			// 카카오페이 결제 고유번호
	// 조회용
	private	String	mem_name;		// 멤버쉽이름
	private	int		price;			// 멤버쉽 가격
}



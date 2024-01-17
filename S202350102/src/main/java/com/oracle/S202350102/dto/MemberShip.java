package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MemberShip {
	private int 	user_num;	  // 회원번호
	private int 	order_num;	  // 주문번호
	private int 	mem_num;	  // 멤버쉽번호
	private String 	mem_name;	  // 멤버쉽이름
	private int 	price;		  // 멤버쉽가격
	private String 	mem_desc;	  // 멤버쉽설명
	private Date 	mem_duration; // 사용기간
	private String 	regular_pay;  // 정기결제여부
}

package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

//응답 정보 받기위해 생성한 VO
@Data
public class KakaoPayCancelVO {
	private String 	aid, tid, cid;
	private String	status;		// 결제상태
	private	String	partner_order_id, partner_user_id, payment_method_type;
	private ApprovedCancelAmountVO approved_cancel_amount; // 이번 요청으로 취소된 금액
	private String	item_name, item_code;
    private Date 	created_at; 	// 결제 준비 요청 시각
    private Date 	approved_at; // 결제 승인 시각
    private Date 	canceled_at; // 결제 취소 시각
	
}

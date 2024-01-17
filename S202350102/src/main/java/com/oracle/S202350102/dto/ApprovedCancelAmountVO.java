package com.oracle.S202350102.dto;

import lombok.Data;

@Data
public class ApprovedCancelAmountVO {
	private Integer total;		// 이번 요청으로 취소된 전체금액
	private Integer tax_free;	// 이번 요청으로 취소된 비과세 금액
}

package com.oracle.S202350102.dto;

import lombok.Data;

@Data
public class AmountVO {
	private Integer total, tax_free, vat, point, discount;
}

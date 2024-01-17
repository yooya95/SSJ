package com.oracle.S202350102.dto;

import java.util.Date;

import lombok.Data;

// 응답정보를 받기 위해 생성한 VO
@Data
public class KakaoPayApprovalVO {

	 //response 
    private String aid, tid, cid, sid;
    private String partner_order_id, partner_user_id, payment_method_type;
    private AmountVO amount;
    private CardVO card_info;
    private String item_name, item_code, payload;
    private Integer quantity, tax_free_amount, vat_amount;
    private Date created_at, approved_at;
}

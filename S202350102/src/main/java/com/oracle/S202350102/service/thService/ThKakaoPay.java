package com.oracle.S202350102.service.thService;

import com.oracle.S202350102.dto.KakaoPayApprovalVO;
import com.oracle.S202350102.dto.KakaoPayCancelVO;
import com.oracle.S202350102.dto.Order1;

public interface ThKakaoPay {

	String 					kakaoPayReady(Order1 order1);
	KakaoPayApprovalVO 		kakaoPayInfo(String pg_token, Order1 order1);
	KakaoPayCancelVO 		kakaoPayCancel(Order1 order1);

}

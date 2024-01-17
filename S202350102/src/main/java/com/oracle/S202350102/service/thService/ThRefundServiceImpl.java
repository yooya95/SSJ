package com.oracle.S202350102.service.thService;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.thDao.ThRefundDao;
import com.oracle.S202350102.dto.KakaoPayCancelVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ThRefundServiceImpl implements ThRefundService {
	
	private final ThRefundDao rfd;

	@Override
	public int insertRefundSucess(KakaoPayCancelVO kakaoPayCancelVO) {
		System.out.println("ThRefundServiceImpl insertRefundSucess start...");
		int insertRefundResult = rfd.insertRefundSucess(kakaoPayCancelVO);
		return insertRefundResult;
	}
	
	
	
}

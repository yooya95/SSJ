package com.oracle.S202350102.dao.thDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.KakaoPayCancelVO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ThRefundDaoImpl implements ThRefundDao {
	// Mybatis DB 연동
	private final SqlSession session;

	@Override
	public int insertRefundSucess(KakaoPayCancelVO kakaoPayCancelVO) {
		System.out.println("ThRefundDaoImpl insertRefundSucess start...");
		int insertRefundResult = 0;
		try {
			insertRefundResult = session.insert("thInsertRefundSucess", kakaoPayCancelVO);
		}catch (Exception e) {
			System.out.println("ThOrder1DaoImpl insertRefundSucess Exception --> " + e.getMessage());
		}
		return insertRefundResult;
	}
}

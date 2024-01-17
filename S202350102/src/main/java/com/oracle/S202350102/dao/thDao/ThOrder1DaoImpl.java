package com.oracle.S202350102.dao.thDao;

import javax.transaction.Transaction;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.S202350102.dto.Order1;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ThOrder1DaoImpl implements ThOrder1Dao {
	// Mybatis DB 연동
	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;

	@Override
	public int insertOrder(Order1 order1) {
		System.out.println("ThOrder1DaoImpl insertOrder start...");
		int insertResult = 0;
		try {
			insertResult = session.insert("thOrderInsert", order1);
		}catch (Exception e) {
			System.out.println("ThOrder1DaoImpl thOrderInsert Exception --> " + e.getMessage());
		}
		return insertResult;
	}

	@Override
	public int selectMaxOrderNum() {
		System.out.println("ThOrder1DaoImpl selectOrder start...");
		int max_order_num = 0;
		try {
			max_order_num = session.selectOne("thSelectMaxOrderNum");
		}catch (Exception e) {
			System.out.println("ThOrder1DaoImpl max_order_num Exception --> " + e.getMessage());
		}
		return max_order_num;
	}

	@Override
	public Order1 selectOrderJoinMem(Order1 order1) {
		System.out.println("ThOrder1DaoImpl selectOrderJoinMem start...");
		Order1 orderResult = null;
		try {
			orderResult = session.selectOne("thSelectOrderJoinMem",order1);
		}catch (Exception e) {
			System.out.println("ThOrder1DaoImpl selectOrderJoinMem Exception --> " + e.getMessage());
		}
		return orderResult;
	}

	@Override
	public Order1 selectOrderSucess(int user_num) {
		System.out.println("ThOrder1DaoImpl selectOrderSucess start...");
		Order1 order1 = null;
		try {
			order1 = session.selectOne("thSelectOrderSucess",user_num);
		}catch (Exception e) {
			System.out.println("ThOrder1DaoImpl selectOrderSucess Exception --> " + e.getMessage());
		}
		return order1;
	}

	@Override
	public int updateTid(Order1 order1) {
		System.out.println("ThOrder1DaoImpl updateTid start...");
		int updateResult = 0;
		try {
			updateResult = session.update("thUpdateTid",order1);
		}catch (Exception e) {
			System.out.println("ThOrder1DaoImpl updateTid Exception --> " + e.getMessage());
		}
		return updateResult;
	}

	@Override
	public int transactionOrderInsertUpdate(String tid, int user_num) {
		int result = 0;
		System.out.println("ThOrder1DaoImpl transactionOrderInsertUpdate start...");
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			// 주문테이블 상태를 환불(2) 로 변경
			result = session.update("thUpdateOrderRefund", tid);
			System.out.println("thUpdateOrderRefund result --> " + result);
			
			// 회원테이블 유저상태를 일반회원(100)으로 변경
			result = session.update("thUpdateUserNormal", user_num);
			System.out.println("thUpdateUserNormal result --> " + result);
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			transactionManager.rollback(txStatus);
			result = -1;
		}
		return result;
	}

	@Override
	public int tranxOrdUsrUptSuc(int order_num, int user_num) {
		int result = 0;
		System.out.println("ThOrder1DaoImpl transactionOrderInsertUpdate start...");
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			// 주문테이블 상태를 환불(2) 로 변경
			result = session.update("thUpdateOrderSucess", order_num);
			System.out.println("thUpdateOrderSucess result --> " + result);
			
			// 회원테이블 유저상태를 일반회원(100)으로 변경
			result = session.update("thUser1PremUpdate", user_num);
			System.out.println("thUser1PremUpdate result --> " + result);
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			transactionManager.rollback(txStatus);
			result = -1;
		}
		return result;
	}
	
	
}

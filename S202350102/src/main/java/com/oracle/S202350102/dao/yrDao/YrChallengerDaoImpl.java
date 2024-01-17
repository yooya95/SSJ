package com.oracle.S202350102.dao.yrDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class YrChallengerDaoImpl implements YrChallengerDao {
	private final SqlSession session;
	
	// 소세지들 리스트 출력
	@Override
	public List<User1> getListSsj(int chg_id) {
		List<User1> userListSsj = null; 
		System.out.println("YrChallengerDaoImpl listSsj Start...");
		try {
			userListSsj = session.selectList("yrUser1ListSsj", chg_id);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return userListSsj;
	}
	
	// 챌린지 참가자 insert
	@Override
	public int insertChgr(Challenger chgr) {
		int insertChgr = 0;
		System.out.println("YrChallengerDaoImpl insertChgr Start...");
		try {
			insertChgr = session.insert("yrChgrInsert", chgr);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return insertChgr;
	}

	// 챌린지 참여인원 select
	@Override
	public int selectChgrParti(int chg_id) {
		int selectChgrParti = 0;
		System.out.println("YrChallengerDaoImpl selectChgrParti Start...");
		try {
			selectChgrParti = session.selectOne("yrChgrSelectParti", chg_id);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return selectChgrParti;
	}

	// 챌린지 참여 여부 판단
	@Override
	public int selectChgrJoinYN(Challenger chgr) {
		int selectChgrJoinYN = 0;
		System.out.println("YrChallengerDaoImpl selectChgrJoinYN Start...");
		try {
			selectChgrJoinYN = session.selectOne("yrChgrYN", chgr);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return selectChgrJoinYN;
	}


}

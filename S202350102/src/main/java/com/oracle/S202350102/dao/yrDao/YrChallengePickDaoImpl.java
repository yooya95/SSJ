package com.oracle.S202350102.dao.yrDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.ChallengPick;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class YrChallengePickDaoImpl implements YrChallengePickDao {
	private final SqlSession session;
	
	@Override
	public int selectChgPickYN(ChallengPick chgPick) {
		int selectChgPickYN = 0;
		System.out.println("YrChallengePickDaoImpl selectChgPickYN Start...");
		try {
			selectChgPickYN = session.selectOne("yrChgPickYN", chgPick);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return selectChgPickYN;
	}

	@Override
	public int deleteChgPick(ChallengPick chgPick) {
		int deleteChgPick = 0;
		System.out.println("YrChallengePickDaoImpl deleteChgPick Start...");
		try {
			deleteChgPick = session.delete("yrDeleteChgPick", chgPick);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return deleteChgPick;
	}

	@Override
	public int insertChgPick(ChallengPick chgPick) {
		int insertChgPick = 0;
		System.out.println("YrChallengePickDaoImpl insertChgPick Start...");
		try {
			insertChgPick = session.insert("yrInsertChgPick", chgPick);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return insertChgPick;
	}

	@Override
	public int selectChgPickCnt(int chg_id) {
		int result = 0;
		try {
			result = session.selectOne("chgPickCnt", chg_id);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	

}

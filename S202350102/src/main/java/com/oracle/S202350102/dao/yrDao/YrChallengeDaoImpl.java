package com.oracle.S202350102.dao.yrDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class YrChallengeDaoImpl implements YrChallengeDao {
	private final SqlSession session;
	
	@Override
	public List<Challenge> selectChgPick(int userNum) {
		List<Challenge> chgPickList = null;
		
		try {
			chgPickList = session.selectList("yrChgPickList", userNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return chgPickList;
	}

}

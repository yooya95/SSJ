package com.oracle.S202350102.dao.yrDao;

import com.oracle.S202350102.dto.ChallengPick;

public interface YrChallengePickDao {

	int 	selectChgPickYN(ChallengPick chgPick);
	int		deleteChgPick(ChallengPick chgPick);
	int		insertChgPick(ChallengPick chgPick);
	int 	selectChgPickCnt(int chg_id);

}

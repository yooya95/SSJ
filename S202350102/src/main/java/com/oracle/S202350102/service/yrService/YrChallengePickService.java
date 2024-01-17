package com.oracle.S202350102.service.yrService;

import com.oracle.S202350102.dto.ChallengPick;

public interface YrChallengePickService {

	int 	chgPick(ChallengPick chgPick);
	int 	selectChgPickYN(ChallengPick chgPick);
	int 	selectChgPickCnt(int chg_id);

}

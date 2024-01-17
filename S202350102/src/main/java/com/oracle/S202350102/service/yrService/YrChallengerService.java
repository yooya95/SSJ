package com.oracle.S202350102.service.yrService;

import java.util.List;

import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.User1;

public interface YrChallengerService {
	List<User1> 	getListSsj(int chg_id);
	int 			insertChgr(Challenger chgr);
	int 			selectChgrParti(int chg_id);
	int 			selectChgrJoinYN(Challenger chgr);
//	String 			getBoardRegDate(int chg_id);

}

package com.oracle.S202350102.service.chService;

import java.util.List;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.Comm;

public interface ChChallengeService {
	List<Challenge> popchgList(int user_num);
	List<Comm> 		chgCommList();
	int 			chgInsertComm(String ctn);
	int 			chgDeleteComm(String[] ctn);
	List<Challenge> myChgList(Board board);
	List<Challenger> myChgrList(int user_num);
	int 			chgUpdate(Challenge chg);
}

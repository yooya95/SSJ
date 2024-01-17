package com.oracle.S202350102.dao.thDao;

import java.util.List;

import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.Comm;

public interface ThChgDao {

	int			 		totalChg();
	List<Challenge> 	listChg(Challenge chg);
	int 				totalChgIng(Challenge chg);
	int 				totalChgFin(Challenge chg);
	List<Challenge> 	listEndChg(Challenge chg);
	List<Comm> 			listChgCategory();

}

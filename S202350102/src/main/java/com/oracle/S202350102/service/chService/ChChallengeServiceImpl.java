package com.oracle.S202350102.service.chService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.chDao.ChChallengeDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.Comm;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class ChChallengeServiceImpl implements ChChallengeService {
	
	private final ChChallengeDao chChallengeService;
	
	
	
	@Override
	public List<Challenge> popchgList(int user_num) {
		System.out.println("ChChallengeServiceImpl popChgList Start...");
		
		List<Challenge> popchgList = chChallengeService.popChgList(user_num);
		return popchgList;
	}



	@Override
	public List<Comm> chgCommList() {
		System.out.println("ChChallengeServiceImpl chgCommList Start...");
		List<Comm> chgCommList = null;
		
		chgCommList = chChallengeService.chgCommList();
		System.out.println("ChChallengeServiceImpl chgCommList size->" + chgCommList.size());
		return chgCommList;
	}



	@Override
	public int chgInsertComm(String ctn) {
		System.out.println("ChChallengeServiceImpl chgInsertComm Start...");
		int result = 0;
		
		result = chChallengeService.chgInsertComm(ctn);
		
		return result;
	}



	@Override
	public int chgDeleteComm(String[] ctn) {
		System.out.println("ChChallengeServiceImpl chgDeleteComm Start...");
		int result = 0;
		
		result = chChallengeService.chgDeleteChg(ctn);
		
		return result;
	}


	@Override
	public List<Challenger> myChgrList(int user_num) {
		System.out.println("ChChallengeServiceImpl myChgList Start...");
		List<Challenger> myChgrList = null;
		
		myChgrList = chChallengeService.myChgrList(user_num);
		
		System.out.println("ChChallengeServiceImpl myChgList myChgList->" + myChgrList.size());
		
		return myChgrList;
	}



	@Override
	public List<Challenge> myChgList(Board board) {
		System.out.println("ChChallengeServiceImpl myChgList Start...");
		List<Challenge> myChgList = null;
		
		myChgList = chChallengeService.myChgList(board);
		
		System.out.println("ChChallengeServiceImpl myChgList myChgList->" + myChgList.size());
		
		return myChgList;
	}



	@Override
	public int chgUpdate(Challenge chg) {
		System.out.println("ChChallengeServiceImpl chgUpdate Start...");
		int result = 0;
		System.out.println(chg.getChg_id());
		result = chChallengeService.chgUpdate(chg);
		
		return result;
	}

}

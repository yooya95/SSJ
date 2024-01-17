package com.oracle.S202350102.service.thService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.thDao.ThChgDao;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.Comm;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ThChgServiceImpl implements ThChgService {

	private final ThChgDao tcd;
	
	@Override
	public int totalChg() {
			System.out.println("thChgServiceImpl totalChg Start... ");
			int totChgCnt = tcd.totalChg();
			System.out.println("thChgServiceImpl totalChg totChgCnt --> ... " + totChgCnt);
		return totChgCnt;
	}


	@Override
	public int totalChgIng(Challenge chg) {
		System.out.println("thChgServiceImpl totalChgIng Start... ");
		int totChgIngCnt = tcd.totalChgIng(chg);
		return totChgIngCnt;
	}

	@Override
	public int totalChgFin(Challenge chg) {
		System.out.println("thChgServiceImpl totalChgFin Start... ");
		int totChgFinCnt = tcd.totalChgFin(chg);
		return totChgFinCnt;
	}

	@Override
	public List<Challenge> listChg(Challenge chg) {
			System.out.println("ThChgServiceImpl listChg Start... ");
			List<Challenge> chgList = tcd.listChg(chg);
			System.out.println("ThChgServiceImpl listChg chgList.size() --> " + chgList.size());
		return chgList;
	}


	@Override
	public List<Challenge> listEndChg(Challenge chg) {
			System.out.println("ThChgServiceImpl listEndChg Start... ");
			List<Challenge> EndChgList = tcd.listEndChg(chg);
			System.out.println("ThChgServiceImpl listEndChg EndChgList.size() --> " + EndChgList.size());
		return EndChgList;
	}


	@Override
	public List<Comm> listChgCategory() {
		System.out.println("ThChgServiceImpl listChgCategory Start... ");
		List<Comm> chgCategoryList = tcd.listChgCategory();
		System.out.println("ThChgServiceImpl listChgCategory listChgCategory.size() --> " + chgCategoryList.size());
		return chgCategoryList;
	}



}

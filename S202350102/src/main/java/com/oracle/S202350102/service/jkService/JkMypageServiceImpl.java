package com.oracle.S202350102.service.jkService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.jkDao.JkBoardDao;
import com.oracle.S202350102.dao.jkDao.JkMypageDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JkMypageServiceImpl implements JkMypageService {
	private final JkMypageDao jmd;

	@Override
	public List<Challenge> myChgList(Challenge chg) {
		System.out.println("JkMypageServiceImpl listChg Start... ");
		List<Challenge> myChgList = jmd.myChgList(chg);
		System.out.println("JkMypageServiceImpl listChg chgList.size() --> " + myChgList.size());
	
		return myChgList;
}

	
}

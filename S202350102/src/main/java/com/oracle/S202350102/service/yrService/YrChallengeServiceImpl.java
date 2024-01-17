package com.oracle.S202350102.service.yrService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.yrDao.YrChallengeDao;
import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class YrChallengeServiceImpl implements YrChallengeService {
	private final YrChallengeDao ychd;
	
	@Override
	public List<Challenge> selectChgPick(int userNum) {
		List<Challenge> chgPickList = ychd.selectChgPick(userNum);
		return chgPickList;
	}

}

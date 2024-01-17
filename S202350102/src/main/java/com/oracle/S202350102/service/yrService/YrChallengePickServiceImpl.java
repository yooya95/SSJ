package com.oracle.S202350102.service.yrService;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.yrDao.YrChallengePickDao;
import com.oracle.S202350102.dto.ChallengPick;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class YrChallengePickServiceImpl implements YrChallengePickService {
	private final YrChallengePickDao ycpd;
	
    // 찜 여부 판단용
	@Override
	public int selectChgPickYN(ChallengPick chgPick) {
		int result = ycpd.selectChgPickYN(chgPick);
		System.out.println("YrChallengePickServiceImpl selectChgPickYN result -> " + result);
		return result;
	}
	
    // 찜 있음 -> delete / 찜 없음 -> insert
	@Override
	public int chgPick(ChallengPick chgPick) {
		int result = 0;
		if(this.selectChgPickYN(chgPick) == 1) {
			// selectChgPickYN(chgPick) == 1 -> chgPick 값 있다 -> 없애기
			ycpd.deleteChgPick(chgPick);
			result = 0;
		} else {
			// selectChgPickYN(chgPick) == 0 -> chgPick 값 없다 -> 추가하기
			ycpd.insertChgPick(chgPick);
			result = 1;
		}
		System.out.println("YrChallengePickServiceImpl chgPick result -> " + result);
		
		return result;
	}

	@Override
	public int selectChgPickCnt(int chg_id) {
		int result = ycpd.selectChgPickCnt(chg_id);
		return result;
	}

}

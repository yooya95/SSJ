package com.oracle.S202350102.service.yrService;

import java.util.List;

import com.oracle.S202350102.dto.Challenge;

public interface YrChallengeService {

	List<Challenge> selectChgPick(int userNum);

}

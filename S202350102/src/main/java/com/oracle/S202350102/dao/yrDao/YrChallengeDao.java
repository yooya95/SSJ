package com.oracle.S202350102.dao.yrDao;

import java.util.List;

import com.oracle.S202350102.dto.Challenge;

public interface YrChallengeDao {

	List<Challenge> selectChgPick(int userNum);

}

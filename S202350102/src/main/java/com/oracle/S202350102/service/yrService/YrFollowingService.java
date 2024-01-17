package com.oracle.S202350102.service.yrService;

import java.util.List;

import com.oracle.S202350102.dto.Following;
import com.oracle.S202350102.dto.User1;

public interface YrFollowingService {
	int				following(Following fwi);
	int 			followingCheck(Following fwi);
	List<User1> 	followingList(int userNum);
	List<User1> 	followerList(int userNum);

}

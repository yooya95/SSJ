package com.oracle.S202350102.dao.jkDao;

import java.util.Map;

import com.oracle.S202350102.dto.User1;

public interface JkUser1Dao {

	int 						updateUser1(User1 user1);
	User1	 					getUserDetails(int user_num);
	User1 						userSelect(int user_num);
	int 						writeFormSharing(int user_num);
	int 						updateProfile(User1 user1);
	Map<String, Integer> 		followingCnt(int user_num);


}

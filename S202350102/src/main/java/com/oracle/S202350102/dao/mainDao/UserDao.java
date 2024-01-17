package com.oracle.S202350102.dao.mainDao;

import java.util.List;

import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.dto.UserLevel;

public interface UserDao {

	User1 	  		userSelect(int user_num);
	void  	  		userLevelUp(int user_num);
	void  	  		userExpUp(User1 user1);
	UserLevel 		userLevelInfo(int user_num);
	List<UserLevel> userLevelInfoList();
	User1 			userSelect(User1 user1);

}

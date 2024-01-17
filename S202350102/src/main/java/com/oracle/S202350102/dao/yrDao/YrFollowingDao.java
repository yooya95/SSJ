package com.oracle.S202350102.dao.yrDao;

import java.util.List;

import com.oracle.S202350102.dto.Following;
import com.oracle.S202350102.dto.User1;

public interface YrFollowingDao {
	int 			selectFollowingYN(Following fwi);
	int			 	deleteFollowing(Following fwi);
	int 			insertFollowing(Following fwi);
	List<User1> 	selectFollowingList(int userNum);
	List<User1> 	selectFollowerList(int userNum);

}

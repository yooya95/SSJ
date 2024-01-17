package com.oracle.S202350102.service.yrService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.yrDao.YrFollowingDao;
import com.oracle.S202350102.dto.Following;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class YrFollowingServiceImpl implements YrFollowingService {
	private final YrFollowingDao yfid;

	@Override
	public int followingCheck(Following fwi) {
		int result = yfid.selectFollowingYN(fwi);
		System.out.println("YrFollowingService followingCheck result -> " + result);
		
		return result;
	}
	
	@Override
	public int following(Following fwi) {
		int result = 0;
		if(this.followingCheck(fwi) == 1) {	
			// followingCheck = 1 -> following 값 있다 -> 없애기
			yfid.deleteFollowing(fwi);
			result = 0;
		} else {										
			// followingCheck = 0 -> following 값 없다 -> 추가하기
			yfid.insertFollowing(fwi);
			result = 1;
		}
		System.out.println("YrFollowingService following result -> " + result);
		return result;
	}

	@Override
	public List<User1> followingList(int userNum) {
		List<User1> followingList = yfid.selectFollowingList(userNum);
		return followingList;
	}

	@Override
	public List<User1> followerList(int userNum) {
		List<User1> followerList = yfid.selectFollowerList(userNum);
		return followerList;
	}

}

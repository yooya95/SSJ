package com.oracle.S202350102.service.jkService;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.oracle.S202350102.dao.jkDao.JkUser1Dao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Following;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.dto.UserLevel;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JkUserServiceImpl implements JkUserService {
	
	private final JkUser1Dao jud;
	
	@Override
	public int updateUser1(User1 user1) {
	    System.out.println("User1ServiceImpl updateUser1 start... ");
	    int result = jud.updateUser1(user1);
	    System.out.println("User1ServiceImpl updateUser1 result --> " + result);
	    return result;
	}

	@Override
	public User1 getUserDetails(int user_num) {
		return jud.getUserDetails(user_num);
	}

	@Override
	public User1 userSelect(int user_num) {
		return jud.userSelect(user_num);
	}

	@Override
	public int updateProfile(User1 user1) {
		System.out.println("User1ServiceImpl updateProfile start... ");
	    int result = jud.updateProfile(user1);
	    System.out.println("User1ServiceImpl updateProfile result --> " + result);
	    return result;
	}

	@Override
	public Map<String, Integer> followingCnt(int user_num) {
		Map<String, Integer> followingCnt = jud.followingCnt(user_num);
		return followingCnt;
	}





		

	}


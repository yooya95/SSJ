package com.oracle.S202350102.dao.jkDao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Following;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.dto.UserLevel;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JkUserDaoImpl implements JkUser1Dao {
	
	private final SqlSession session;

	@Override
	public int updateUser1(User1 user1) {
	    System.out.println("User1DaoImpl updateUser1 start...");
	    int result = 0;
	    try {
	        result = session.update("updateUser1", user1);
	    } catch (Exception e) {
	        System.out.println("User1DaoImpl updateUser1 Exception --> " + e.getMessage());
	    }
	    return result;
	}

	@Override
	public User1 getUserDetails(int user_num) {
		  return session.selectOne("getUserDetails", user_num);
	}

	@Override
	public User1 userSelect(int user_num) {
		 return session.selectOne("userSelect", user_num);
			}

	@Override
	public int writeFormSharing(int user_num) {
		 return session.selectOne("writeFormSharing", user_num);
	}

	@Override
	public int updateProfile(User1 user1) {
	    System.out.println("User1DaoImpl updateProfile start...");
	    int result = 0;
	    try {
	        result = session.update("updateProfile", user1);
	    } catch (Exception e) {
	        System.out.println("User1DaoImpl updateProfile Exception --> " + e.getMessage());
	    }
	    return result;
	}

	@Override
	public Map<String, Integer> followingCnt(int user_num) {
		Map<String, Integer> followingCnt = null;
		try {
			followingCnt = session.selectOne("followingCnt",user_num);
			System.out.println(followingCnt);
		} catch (Exception e) {
			System.out.println("followingCnt exception->"+e.getMessage());
		}
		
		return followingCnt;
	}



	}

	

	


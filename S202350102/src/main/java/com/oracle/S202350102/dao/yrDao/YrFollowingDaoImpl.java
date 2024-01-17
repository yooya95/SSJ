package com.oracle.S202350102.dao.yrDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Following;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class YrFollowingDaoImpl implements YrFollowingDao {
	private final SqlSession session;

	@Override
	public int selectFollowingYN(Following fwi) {
		int selectFollowingYN = 0;
		System.out.println("YrFollowingDaoImpl selectFollowingYN Start...");
		try {
			selectFollowingYN = session.selectOne("yrFollowingYN", fwi);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return selectFollowingYN;
	}

	@Override
	public int deleteFollowing(Following fwi) {
		int deleteFollowing = 0;
		System.out.println("YrFollowingDaoImpl deleteFollowing Start...");
		try {
			deleteFollowing = session.delete("deleteFollowing", fwi);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return deleteFollowing;
	}

	@Override
	public int insertFollowing(Following fwi) {
		int insertFollowing = 0;
		System.out.println("YrFollowingDaoImpl insertFollowing Start...");
		try {
			insertFollowing = session.insert("insertFollowing", fwi);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return insertFollowing;
	}

	@Override
	public List<User1> selectFollowingList(int userNum) {
		List<User1> followingList = null;
		System.out.println("YrFollowingDaoImpl followingList Start...");
		try {
			followingList = session.selectList("selectFollowingList", userNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return followingList;
	}

	@Override
	public List<User1> selectFollowerList(int userNum) {
		List<User1> followerList = null;
		System.out.println("YrFollowingDaoImpl followerList Start...");
		try {
			followerList = session.selectList("selectFollowerList", userNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return followerList;
	}


}

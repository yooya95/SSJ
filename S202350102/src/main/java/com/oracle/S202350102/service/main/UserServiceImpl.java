package com.oracle.S202350102.service.main;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.mainDao.Level1Dao;
import com.oracle.S202350102.dao.mainDao.UserDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Level1;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.dto.UserLevel;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
	private final UserDao ud;
	private final Level1Dao ld;

	/*
	 * 강한빛
	 * 유저의 정보를 불러오는 메소드
	 */
	@Override
	public User1 userSelect(int user_num) {
		
		User1 user1 = ud.userSelect(user_num);
		List<UserLevel> userLevelInfoList = ud.userLevelInfoList();
		
		int tot_exp, req_exp, remain_exp, user_exp, percentage = 0;
		float data1, data2, data3 = 0;
		if ( user_num != 0 ) {
			for (int i = 0; i < userLevelInfoList.size(); i++) {
				user_exp = user1.getUser_exp();
				if( userLevelInfoList.get(i).getUser_level() == user1.getUser_level() ) {
					tot_exp = userLevelInfoList.get(i).getTot_exp();
					req_exp = userLevelInfoList.get(i).getReq_exp();
					remain_exp = (req_exp+100)-(user_exp-tot_exp);
					data1 = (float)(user_exp - tot_exp);
					data2 = (float)(req_exp+100);
					data3 = (float)(data1/data2);
					percentage = (int)(data3*100);
					
					if ( userLevelInfoList.get(i).getUser_level() == 11 ) {
						user1.setPercentage(100);
						user1.setRemain_exp(0);
					} else {
						user1.setRemain_exp(remain_exp);
						user1.setPercentage(percentage);
					}
				}
			}
		} else {
			return null;
		}

		return user1;

	}

	/*
	 * 강한빛
	 * 해당 유저와 레벨 테이블간의 조인정보 조회(보통 로그인한 유저의 아이콘을 사용하기위함)
	 */
	@Override
	public UserLevel userLevelInfo(int user_num) {
		UserLevel userLevelInfo = ud.userLevelInfo(user_num);
		return userLevelInfo;
	}

	/*
	 * 강한빛
	 * User1 - Level1 간의 모든정보를 조회 (게시글 작성한 유저의 아이콘 및 정보 조회용)
	 */
	@Override
	public List<UserLevel> userLevelInfoList() {
		List<UserLevel> userLevelInfoList = ud.userLevelInfoList();
		return userLevelInfoList;
	}
	
//	protected UserLevel userLevelInfo(int user_num) {
//		UserLevel userLevelInfo = ud.userLevelInfo(user_num);
//		return userLevelInfo;
//	}
	/*
	 * 강한빛
	 * 유저 레벨아이콘, 정보를 불러오는 메소드
	 * 보드게시판 사용자의 아이콘명, 유저레벨, 유저경험치, 레벨업까지 도달할 퍼센트를 구함
	 */
	@Override
	public List<Board> boardWriterLevelInfo(List<Board> boardList){
		List<UserLevel> userLevelInfoList = ud.userLevelInfoList();
		List<Level1> level1Info = ld.level1List();
		String icon = "";
		int user_level, user_num, user_exp = 0;
		for (int i = 0; i < boardList.size(); i++) {
			user_num = boardList.get(i).getUser_num();
			for (int j = 0; j < userLevelInfoList.size(); j++) {
				if ( user_num == userLevelInfoList.get(j).getUser_num() ) {
				icon = userLevelInfoList.get(j).getLv_name();
				user_level = userLevelInfoList.get(j).getUser_level();
				user_exp = userLevelInfoList.get(j).getUser_exp();
				boardList.get(i).setIcon(icon);
				boardList.get(i).setUser_level(user_level);
				boardList.get(i).setUser_exp(user_exp);
				}
			}
		}
		int tot_exp, req_exp, percentage = 0;
		float data1, data2, data3 = 0;
		
		for (int i = 0; i < boardList.size(); i++) {
			for (int j = 0; j < level1Info.size(); j++) {
				if ( boardList.get(i).getUser_level() == level1Info.get(j).getUser_level() ) {
					tot_exp = level1Info.get(j).getTot_exp();
					req_exp = level1Info.get(j).getReq_exp();
					data1 = (float)(boardList.get(i).getUser_exp() - tot_exp );
					data2 = (float)(req_exp+100);
					data3 = (float)(data1/data2);
					percentage  = (int)(data3*100);
					if ( boardList.get(i).getUser_level() == 11) {
						boardList.get(i).setPercentage(100);
					} else {
						boardList.get(i).setPercentage(percentage);
					}
					
				}
			}
		}
		
		return boardList;
		
	}
	
	// 유저 테이블에 대한 경험치 정보를 불러오고 싶을 때 사용
	@Override
	public List<User1> userLevelList(List<User1> userInfoList) {
		List<UserLevel> userLevelInfoList = ud.userLevelInfoList();
		List<Level1> level1Info = ld.level1List();
		String icon = "";
		int user_level, user_num, user_exp = 0;
		for (int i = 0; i < userInfoList.size(); i++) {
			user_num = userInfoList.get(i).getUser_num();
			for (int j = 0; j < userLevelInfoList.size(); j++) {
				if ( user_num == userLevelInfoList.get(j).getUser_num() ) {
				icon = userLevelInfoList.get(j).getLv_name();
				user_level = userLevelInfoList.get(j).getUser_level();
				user_exp = userLevelInfoList.get(j).getUser_exp();
				userInfoList.get(i).setIcon(icon);
				userInfoList.get(i).setUser_level(user_level);
				userInfoList.get(i).setUser_exp(user_exp);
				}
			}
		}
		int tot_exp, req_exp, percentage = 0;
		float data1, data2, data3 = 0;
		
		for (int i = 0; i < userInfoList.size(); i++) {
			for (int j = 0; j < level1Info.size(); j++) {
				if ( userInfoList.get(i).getUser_level() == level1Info.get(j).getUser_level() ) {
					tot_exp = level1Info.get(j).getTot_exp();
					req_exp = level1Info.get(j).getReq_exp();
					data1 = (float)(userInfoList.get(i).getUser_exp() - tot_exp );
					data2 = (float)(req_exp+100);
					data3 = (float)(data1/data2);
					percentage  = (int)(data3*100);
					if ( userInfoList.get(i).getUser_level() == 11) {
						userInfoList.get(i).setPercentage(100);
					} else {
						userInfoList.get(i).setPercentage(percentage);
					}
					
				}
			}
		}
		
		return userInfoList;
	}

	@Override
	public User1 userSelect(User1 user1) {
		System.out.println("UserServiceImpl userSelect start...");
		User1 userResult = ud.userSelect(user1);
		return userResult;
	}
	
	
	
}

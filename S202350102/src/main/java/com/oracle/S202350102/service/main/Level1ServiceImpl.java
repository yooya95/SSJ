package com.oracle.S202350102.service.main;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.mainDao.Level1Dao;
import com.oracle.S202350102.dao.mainDao.UserDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Level1;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class Level1ServiceImpl implements Level1Service {
	private final Level1Dao ld;
	private final UserDao 	ud;

	/*
	 * 강한빛 
	 * 레벨 표 작성을 위함
	 */
	@Override
	public List<Level1> level1List() {
		List<Level1> levelList = ld.level1List();
		return levelList;
	}

	/*
	 * 강한빛 
	 * 해당 레벨에 대한 정보
	 */
	@Override
	public Level1 level1Select(int level) {
		Level1 level1 = ld.level1Select(level);
		return level1;
	}

	/*
	 * 강한빛 
	 * 유저의 레벨과 경험치를 받아서 조건에 맞으면 레벨을 올리기
	 */	
	@Override
	public void userLevelCheck(int user_num) {
		User1 user1 = ud.userSelect(user_num);
		// userLevelUp 메소드에 현재 유저의 경험치, 레벨을 넣어 조건에 따라 결과 레벨값을 도출
		int user_level = userLevelUp( user1.getUser_exp(), user1.getUser_level()); 
		
		// 위 메소드를 통해 얻은 user_level이 현재 유저가 갖고있는 레벨과 같지 않다면 레벨업
		if ( user_level != user1.getUser_level() ) {
			ud.userLevelUp(user_num); // ud는 유저dao (여긴 level service )
		}
	}
	
	private int userLevelUp(int user_exp, int user_level) {
		
		Level1 nextLevelInfo = ld.level1Select(user_level+1); // 유제레벨의 다음 레벨에 대한 정보
		List<Level1> level1List = ld.level1List();
		if ( nextLevelInfo == null ) {
			return user_level;
		} else {
			while (user_exp >= nextLevelInfo.getTot_exp() && user_level != level1List.size()) {
				user_level += 1;
			}
			nextLevelInfo = ld.level1Select(user_level+1);
		}
		
		return user_level;
	}
//		if ( user_exp >= nextLevelInfo.getTot_exp() && user_level != level1List.size() ) {
//			user_level += 1;
//			nextLevelInfo = ld.level1Select(user_level+1);
//			if( user_exp >=  nextLevelInfo.getTot_exp() && user_level != level1List.size() ) {
//				user_level += 1;
//				return user_level;
//			}   return user_level;
//		} else  return user_level;

	/*
	 * 강한빛 
	 * 카테고리에 따라 유저경험치 증가량
	 */
	@Override
	public void userExp(int user_num, int lg, int md) {
		User1 user1 = ud.userSelect(user_num);
		
		int user_exp = user1.getUser_exp();
		String combineValue = lg+"-"+md;
		
		if ( user1.getStatus_md() != 101 ) { // 일반회원
		    if (combineValue.startsWith("200-")) {
				user1.setUser_exp(user_exp+50);
				ud.userExpUp(user1);
		    } else if (combineValue.equals("600-101")) {
		    	user1.setUser_exp(user_exp+25);
		    	ud.userExpUp(user1);
		    } else if (combineValue.equals("700-100")) {
				user1.setUser_exp(user_exp+5);
				ud.userExpUp(user1);
		    } else if (combineValue.equals("700-101")) {
				user1.setUser_exp(user_exp+15);
				ud.userExpUp(user1);
		    } else if (combineValue.equals("700-103")) {
				user1.setUser_exp(user_exp+5);
				ud.userExpUp(user1);
		    } 
//		    else if (combineValue.startsWith("400-")) { // 테스트용
//		    	System.out.println(user1.getUser_exp());
//		    	user1.setUser_exp(user_exp+1);
//		    	System.out.println(user1.getUser_exp());
//		    	ud.userExpUp(user1);
//			}
		} else if ( user1.getStatus_md() == 101 ) { // 프리미엄회원
		    if (combineValue.startsWith("200-")) {
				user1.setUser_exp(user_exp+(50*3));
				ud.userExpUp(user1);
		    } else if (combineValue.equals("600-101")) {
		    	user1.setUser_exp(user_exp+(25*3));
		    	ud.userExpUp(user1);
		    } else if (combineValue.equals("700-100")) {
				user1.setUser_exp(user_exp+(5*3));
				ud.userExpUp(user1);
		    } else if (combineValue.equals("700-101")) {
				user1.setUser_exp(user_exp+(15*3));
				ud.userExpUp(user1);
		    } else if (combineValue.equals("700-103")) {
				user1.setUser_exp(user_exp+(5*3));
				ud.userExpUp(user1);
		    }
		}

	}
	

}

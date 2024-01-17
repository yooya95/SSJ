package com.oracle.S202350102.service.thService;

import java.security.SecureRandom;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.thDao.ThUser1Dao;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ThUser1ServiceImpl implements ThUser1Service {
	
	private final ThUser1Dao ud1;
	
	@Override
	public int insertUser1(User1 user1) {
		System.out.println("ThUser1ServiceImpl insertUser1 start... ");
		int result = ud1.insertUser1(user1);
		System.out.println("ThUser1ServiceImpl insertUser1 result --> " + result);
		return result;
	}

	
	@Override
	public User1 login(User1 user1) {
		System.out.println("ThUser1ServiceImpl login start...");
		User1 loginUser = ud1.login(user1);
		System.out.println("ThUser1ServiceImpl loginUser --> " + loginUser);
		return loginUser;
	}


	@Override
	public int deleteUser(User1 user1) {
		System.out.println("ThUser1ServiceImpl deleteUser start... ");
		int deleteUserCnt = ud1.deleteUser(user1);
		System.out.println("ThUser1ServiceImpl deleteUserCnt result --> " + deleteUserCnt);
		return deleteUserCnt;
	}

	@Override
	public int user1IdCheck(String user_id) {
		System.out.println("ThUser1ServiceImpl user1IdCheck Start...");
		System.out.println("ThUser1ServiceImpl user1IdCheck user_id --> " + user_id);
		int result = ud1.user1IdCheck(user_id);
		System.out.println("ThUser1ServiceImpl user1IdCheck result --> " + result);
		return result;
	}


	@Override
	public int user1NickCheck(String nick) {
		System.out.println("ThUser1ServiceImpl user1NickCheck Start...");
		System.out.println("ThUser1ServiceImpl user1NickCheck nick --> " + nick);
		int result = ud1.user1NickCheck(nick);
		System.out.println("ThUser1ServiceImpl user1NickCheck result --> " + result);
		return result;
	}


	@Override
	public List<User1> findId(User1 user1) {
		System.out.println("ThUser1ServiceImpl findId Start...");		
		List<User1> user_id_list = ud1.findId(user1);
		System.out.println("ThUser1ServiceImpl findId user_id_List --> " + user_id_list);
		return user_id_list;
	}

	//임시 비밀번호 생성(8자리)
	@Override
	public String crRndPswd() {
		System.out.println("ThUser1ServiceImpl crRndPswd Start... ");
		char[] rndAllCharacters = new char[]{
				//number
		        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		        //uppercase
		        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
		        'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
		        //lowercase
		        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
		        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
		        //special symbols
		        '@', '$', '!', '%', '*', '?', '&'
		};
		 SecureRandom random = new SecureRandom();
		 StringBuilder stringBuilder = new StringBuilder();
		 	
		 	// rndAllCharacters의 ( number , uppercase, lowercase, special sybols) 의 길이 체크 = 69
		    int rndAllCharactersLength = rndAllCharacters.length;
		    for (int i = 0; i < 8; i++) {
		        stringBuilder.append(rndAllCharacters[random.nextInt(rndAllCharactersLength)]);
		    }

		 
	    System.out.println("ThUser1ServiceImpl crRndPswd stringBuilder.toString()" + stringBuilder.toString());
	    return stringBuilder.toString();
		
	}


	@Override
	public User1 findUser1ByIdAndEmail(User1 user1) {
		System.out.println("ThUser1ServiceImpl findUser1ByIdAndEmail Start...");
		User1 findUser1 = ud1.findUser1ByIdAndEmail(user1);
		return findUser1;
	}


	@Override
	public int user1PswdUpdate(Map<String, Object> map) {
		System.out.println("ThUser1ServiceImpl User1PswdUpdate Start...");
		int updateResult = ud1.user1PswdUpdate(map);
		
		return updateResult;
	}


	@Override
	public int totalUser(User1 user1) {
		System.out.println("ThUser1ServiceImpl totalUser Start...");
		int totUserCnt = ud1.totalUser(user1);
		System.out.println("ThUser1ServiceImpl totalUser totalUserCnt --> " + totUserCnt);
		return totUserCnt;
	}


	@Override
	public List<User1> listUser(User1 user1) {
		System.out.println("ThUser1ServiceImpl listUser Start...");
		List<User1> userList = ud1.listUser(user1);
		System.out.println("ThUser1ServiceImpl listUser userList.size() -->" + userList.size());
		return userList;
	}


	@Override
	public int updateUserLoginDate(int user_num) {
		System.out.println("ThUser1ServiceImpl updateUserLoginDate Start...");
		int updateResult = ud1.updateUserLoginDate(user_num);
		return updateResult;
	}


	@Override
	public int deleteUserByAdmin(int user_num) {
		System.out.println("ThUser1ServiceImpl deleteUserByAdmin Start...");
		int deleteResult = ud1.deleteUserByAdmin(user_num);
		return deleteResult;
	}


	@Override
	public int activeUserByAdmin(int user_num) {
		System.out.println("ThUser1ServiceImpl activeUserByAdmin Start...");
		int deleteResult = ud1.activeUserByAdmin(user_num);
		return deleteResult;
	}


	@Override
	public int updateUserAdmin(User1 user1) {
		System.out.println("ThUser1ServiceImpl updateUserAdmin Start...");
		int updateResult = ud1.updateUserAdmin(user1);
		System.out.println("ThUser1ServiceImpl updateResult --> " + updateResult);
		return updateResult;
	}


	@Override
	public int updateUserNormal(int user_num) {
		System.out.println("ThUser1ServiceImpl updateUserNormal Start...");
		int updateUser1Result = ud1.updateUserNormal(user_num);
		return updateUser1Result;
	}


	

}

package com.oracle.S202350102.dao.thDao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ThUser1DaoImpl implements ThUser1Dao {
	// Mybatis DB 연동
	private final SqlSession session;

	@Override
	public int insertUser1(User1 user1) {
		System.out.println("ThUser1DaoImpl insertUser1 start...");
		int result = 0;
		try {
			result = session.insert("thInsertUser1", user1);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl insertUser1 Exception --> " + e.getMessage());
		}
		return result;
		
	}

	@Override
	public User1 login(User1 user1) {
		System.out.println("ThUser1DaoImpl login Start...");
		User1 loginUser = null;
		try {
			loginUser = session.selectOne("thLogin", user1);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl login Exception --> " + e.getMessage());
		}
		return loginUser; 
	}

	@Override
	public int deleteUser(User1 user1) {
		System.out.println("ThUser1DaoImpl deleteUser Start...");
		int deleteUserCnt = 0;
		try {
			deleteUserCnt = session.update("thDeleteUser1",user1);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl deleteUser Exception --> " + e.getMessage());
		}
		
		return deleteUserCnt;
	}

	@Override
	public int user1IdCheck(String user_id) {
		System.out.println("ThUser1DaoImpl user1IdCheck Start...");
		System.out.println("ThUser1DaoImpl user1IdCheck user_id --> " + user_id);
		int	result = 0;
		try {
			result = session.selectOne("thUser1IdCheck", user_id);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl user1IdCheck Exception --> " + e.getMessage());
		}
		
		return result;
	}

	@Override
	public int user1NickCheck(String nick) {
		System.out.println("ThUser1DaoImpl user1NickCheck Start...");
		System.out.println("ThUser1DaoImpl user1NickCheck nick --> " + nick);
		int	result = 0;
		try {
			result = session.selectOne("thUser1NickCheck", nick);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl user1NickCheck Exception --> " + e.getMessage());
		}
		
		return result;
	}

	@Override
	public List<User1> findId(User1 user1) {
		System.out.println("ThUser1DaoImpl findId Start...");
		
		List<User1>	user_id_list = null;
		try {
			user_id_list = session.selectList("thFindId", user1);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl findId Exception --> " + e.getMessage());
		}
		
		return user_id_list;
	}

	@Override
	public User1 findUser1ByIdAndEmail(User1 user1) {
		System.out.println("ThUser1DaoImpl findUser1ByIdAndEmail Start... ");
		User1 findUser1 = null;
		try {
			findUser1 = session.selectOne("thFindUser1ByIdAndEmail", user1);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl findUser1ByIdAndEmail Exception --> " + e.getMessage());
		}
		
		return findUser1;
	}

	@Override
	public int user1PswdUpdate(Map<String, Object> map) {
		System.out.println("ThUser1DaoImpl User1PswdUpdate Start... ");
		int updateResult = 0;
		try {
			updateResult = session.update("thUser1PswdUpdate", map);
			System.out.println("ThUser1DaoImpl user1PswdUpdate updateResult  --> " + updateResult);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl findUser1ByIdAndEmail Exception --> " + e.getMessage());
		}
		
		return updateResult;
	}

	@Override
	public int totalUser(User1 user1) {
		System.out.println("ThUser1DaoImpl totalUser Start... ");
		int totUserCnt = 0;

		try {											 
			totUserCnt = session.selectOne("ThTotUserCnt",user1);
			System.out.println("ThUser1DaoImpl totalUser totUserCnt -->" + totUserCnt);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl totalUser Exception -->" + e.getMessage());
		} 
		
		return totUserCnt;

	}

	@Override
	public List<User1> listUser(User1 user1) {
		System.out.println("ThUser1DaoImpl listUser Start... ");
		List<User1> userList = null;
		try {				
			userList = session.selectList("thUserListAll",user1);
			System.out.println("ThUser1DaoImpl listUser userList.size() --> " + userList.size());
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl listUser Exception -->" + e.getMessage());
		}
		return userList;

	}

	@Override
	public int updateUserLoginDate(int user_num) {
		System.out.println("ThUser1DaoImpl updateUserLoginDate Start... ");
		int updateResult = 0;
		try {				
			updateResult = session.update("thUpdateUserLoginDate", user_num);
			System.out.println("ThUser1DaoImpl updateUserLoginDate updateResult --> " + updateResult);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl updateUserLoginDate Exception -->" + e.getMessage());
		}
		return updateResult;
	}

	@Override
	public int deleteUserByAdmin(int user_num) {
		System.out.println("ThUser1DaoImpl deleteUserByAdmin Start... ");
		int deleteResult = 0;
		try {				
			deleteResult = session.update("thDeleteUserByAdmin", user_num);
			System.out.println("ThUser1DaoImpl deleteUserByAdmin deleteResult --> " + deleteResult);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl deleteUserByAdmin Exception -->" + e.getMessage());
		}
		return deleteResult;
	}

	@Override
	public int activeUserByAdmin(int user_num) {
		System.out.println("ThUser1DaoImpl activeUserByAdmin Start... ");
		int deleteResult = 0;
		try {				
			deleteResult = session.update("thActiveUserByAdmin", user_num);
			System.out.println("ThUser1DaoImpl activeUserByAdmin deleteResult --> " + deleteResult);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl activeUserByAdmin Exception -->" + e.getMessage());
		}
		return deleteResult;
	}

	@Override
	public int updateUserAdmin(User1 user1) {
		System.out.println("ThUser1DaoImpl updateUserAdmin Start... ");
		int updateResult = 0;
		try {				
			updateResult = session.update("thUpdateUserAdmin", user1);
			System.out.println("ThUser1DaoImpl updateUserAdmin deleteResult --> " + updateResult);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl updateUserAdmin Exception -->" + e.getMessage());
		}
		return updateResult;
	}

	@Override
	public int updateUserNormal(int user_num) {
		System.out.println("ThUser1DaoImpl updateUserNormal Start... ");
		int updateUser1Result = 0;
		try {				
			updateUser1Result = session.update("thUpdateUserNormal", user_num);
			System.out.println("ThUser1DaoImpl updateUserNormal updateUser1Result --> " + updateUser1Result);
		} catch (Exception e) {
			System.out.println("ThUser1DaoImpl updateUserNormal Exception -->" + e.getMessage());
		}
		return updateUser1Result;
	}
	
	
}

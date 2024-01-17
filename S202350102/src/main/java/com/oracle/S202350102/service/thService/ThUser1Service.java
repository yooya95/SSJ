package com.oracle.S202350102.service.thService;



import java.util.List;
import java.util.Map;

import com.oracle.S202350102.dto.User1;


public interface ThUser1Service {
	int				insertUser1(User1 user1);
	User1			login(User1 user1);
	int 			deleteUser(User1 user1);
	int				user1IdCheck(String user_id);
	int				user1NickCheck(String nick);
	List<User1> 	findId(User1 user1);
	String 			crRndPswd();
	User1 			findUser1ByIdAndEmail(User1 user1);
	int 			user1PswdUpdate(Map<String, Object> map);
	int 			totalUser(User1 user1);
	List<User1> 	listUser(User1 user1);
	int 			updateUserLoginDate(int user_num);
	int 			deleteUserByAdmin(int user_num);
	int 			activeUserByAdmin(int user_num);
	int 			updateUserAdmin(User1 user1);
	int 			updateUserNormal(int user_num);

	
	
}

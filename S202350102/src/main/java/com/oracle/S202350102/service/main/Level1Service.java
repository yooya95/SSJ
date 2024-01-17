package com.oracle.S202350102.service.main;

import java.util.List;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Level1;
import com.oracle.S202350102.dto.User1;

public interface Level1Service {
	List<Level1> level1List();
	Level1 		 level1Select(int level);
	void		 userLevelCheck(int user_num);
	void 		 userExp (int user_num, int lg, int md);
}

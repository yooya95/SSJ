package com.oracle.S202350102.dao.chDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.User1;

import lombok.Data;

@Repository
@Data
public class ChUser1DaoImpl implements ChUser1Dao {
	
	private final SqlSession session;

	@Override
	public int getUNum(String user_id) {
		System.out.println("ChUser1DaoImpl getUNum Start...");
		int user_num = 0;
		
		try {
			user_num = session.selectOne("getUNum",user_id);
		} catch (Exception e) {
			System.out.println("ChUser1DaoImpl getUNum e.getMessage()->" + e.getMessage());
			e.printStackTrace();
			user_num = 0;
		}
		
		return user_num;
	}
	
	
	
		

}

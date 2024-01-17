package com.oracle.S202350102.service.chService;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.chDao.ChUser1Dao;
import com.oracle.S202350102.dto.User1;

import lombok.Data;


@Service
@Data
public class ChUser1ServiceImpl implements ChUser1Service {
	
	private final ChUser1Dao chUser1Dao;

	@Override
	public int getUNum(String user_id) {
		System.out.println("ChUser1ServiceImpl getUNum Start...");
		int user_num = 0;
		
		user_num = chUser1Dao.getUNum(user_id);
		
		return user_num;
	}

	

}

package com.oracle.S202350102.dao.jkDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;

import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class JkMypageDaoImpl implements JkMypageDao {
	private final SqlSession session;

	@Override
	public List<Challenge> myChgList(Challenge chg) {
		System.out.println("JkMypageDaoImpl myChgList Start...");
		List<Challenge> myChgList = null;
		try {
			myChgList = session.selectList("myChgList",chg);
			System.out.println("JkMypageDaoImpl myChgList chgList.size() --> " + myChgList.size());			
		} catch (Exception e) {
			System.out.println("JkMypageDaoImpl myChgList Exception --> " + e.getMessage());
		}
		return myChgList;
	}

}

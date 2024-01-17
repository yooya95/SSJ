package com.oracle.S202350102.dao.mainDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Level1;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class Level1DaoImpl implements Level1Dao {
	private final SqlSession session;

	@Override
	public List<Level1> level1List() {
		List<Level1> levelList = null;
		try {
			levelList = session.selectList("level1List");
		} catch (Exception e) {
			System.out.println("level1List sql exception->"+e.getMessage());
		}
		return levelList;
	}

	@Override
	public Level1 level1Select(int level) {
		Level1 level1 = new Level1();
		try {
			level1 = session.selectOne("level1Select",level);
		} catch (Exception e) {
			System.out.println("level1Select sql exception->"+level1);
		}
		return level1;
	}


}

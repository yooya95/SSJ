package com.oracle.S202350102.dao.mainDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDaoimpl implements BoardDao {
	private final SqlSession session;

	@Override
	public List<Board> selectChgCert(Board board) {
		List<Board> chgCert = null; 
		try {
			chgCert = session.selectList("chgCert", board);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return chgCert;
	}
	
}

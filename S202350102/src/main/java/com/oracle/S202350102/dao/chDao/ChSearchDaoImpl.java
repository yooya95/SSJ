package com.oracle.S202350102.dao.chDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.SearchHistory;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ChSearchDaoImpl implements ChSearchDao {
	
	private final SqlSession session;


	@Override
	public int saveWord(SearchHistory sh) {
		System.out.println("ChSearchImpl saveWord Start..");
		
		int saveResult = 0;
		try {
			saveResult = session.insert("saveWord", sh);
		} catch (Exception e) {
			saveResult = 0;
		}		
		
		return saveResult;
	}


	@Override
	public List<Challenge> chgSearching(Board board) {
		System.out.println("ChSearchImpl chgSearching Start..");
		List<Challenge> srch_chgresult = null;
		
		try {
			srch_chgresult = session.selectList("chgResult",board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChSearchImpl chgSearching e.getMessage()->" + e.getMessage());
		}
		
		return srch_chgresult;
	}


	@Override
	public List<Board> brdSearching(Board board) {
		System.out.println("ChSearchImpl brdSearching Start..");
		
		List<Board> srch_brdResult = null;
		
		
		try {
			srch_brdResult = session.selectList("BrdResult",board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChSearchImpl chgSearching e.getMessage()->" + e.getMessage());
		}
		
		return srch_brdResult;
	}
	
	@Override
	public List<Board> shareSearching(Board board) {
		System.out.println("ChSearchImpl shareSearching Start..");
		
		List<Board> shrResult = null;
		
		
		try {
			shrResult = session.selectList("shrResult",board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChSearchImpl chgSearching e.getMessage()->" + e.getMessage());
		}
		
		return shrResult;
	}
	


	@Override
	public List<SearchHistory> sHistoryList(int user_num) {
		System.out.println("ChSearchImpl sHistoryList Start...");
		List<SearchHistory> sHistoryList = null;
		
		try {
			sHistoryList = session.selectList("shList",user_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChSearchImpl sHistoryList e.getMessage()->" + e.getMessage());
		}
		
		return sHistoryList;
	}


	@Override
	public int upDateHistory(SearchHistory sh) {
		System.out.println("ChSearchImpl upDateHistory Start...");
		int result = 0;
		
		try {
			result = session.update("updateHis", sh);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChSearchImpl sHistoryList e.getMessage()->" + e.getMessage());
		}
		return result;
	}


	@Override
	public int deleteHis(SearchHistory sh) {
		System.out.println("ChSearchImpl deleteHis Start...");
		int result = 0;
		
		try {
			result = session.delete("deleteHis", sh);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChSearchImpl deleteHis e.getMessage()->" + e.getMessage());
		}
		
		return result;
	}


	@Override
	public int chgSrchTot(Board board) {
		System.out.println("ChSearchImpl chgSrchTot Start...");
		int result = 0;
		
		try {
			result = session.selectOne("chgReTotal",board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChSearchImpl chgSrchTot e.getMessage()->" + e.getMessage());
		}
		
		return result;
	}


	@Override
	public int chgSrchBTot(Board board) {
		System.out.println("ChSearchImpl chgSrchBTot Start...");
		int result = 0;
		
		try {
			result = session.selectOne("chgSrchBTot",board);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChSearchImpl chgSrchBTot e.getMessage()->" + e.getMessage());
		}
		
		return result;
	}


	

}

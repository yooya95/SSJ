package com.oracle.S202350102.dao.bgDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BgBoardDaoImpl implements BgBoardDao {
	
	@Autowired
	private final SqlSession session;
	
	// 챌린지 정보 조회
	@Override
	public Challenge bgChgDetail(int chg_id) {
		System.out.println("BgDaoImpl bgChgDetail Start...");
		System.out.println("BgDaoImpl bgChgDetail chg_id -> "+chg_id);
		Challenge chg = null;
		try {
			chg = session.selectOne("bgChgDetail", chg_id);
			System.out.println("BgDaoImpl bgChgDetail chg -> "+chg);
		} catch (Exception e) {
			System.out.println("BgDaoImpl bgChgDetail e.getMessage() -> "+e.getMessage());
		}
		return chg;
	}
	

	@Override
	public List<Board> certBoard(Board board) {
		List<Board> boardCert = null;
		System.out.println("BgDaoImpl certBoard Start...");
		try {
			boardCert = session.selectList("bgCertBoardAll", board);
		} catch (Exception e) {
			System.out.println("BgDaoImpl certBoard e.getMessage() -> " + e.getMessage());
		}
		return boardCert;
	}
	
	@Override
	public List<Board> boardCert(Board board) {
		List<Board> certBoard = null;
		System.out.println("BgDaoImpl boardCert Start... ");
		try {
			certBoard = session.selectList("bkCertBoard", board);
		} catch (Exception e) {
			System.out.println("BgDaoImpl boardCert e.getMessage() -> " + e.getMessage());
		}
		return certBoard;
	}

	
	@Override
	public int insertCertBrd(Board board) {
		
		int result = 0;
		System.out.println("BgDaoImpl boardCert Start... ");
		
		try {
			result = session.insert("insertCertBrd", board);
		} catch (Exception e) {
			System.out.println("BgDaoImpl insertCertBrd e.getMessage() -> " + e.getMessage());
		}
		
		return result;
	}

	@Override
	public int updateCertBrd(Board board) {
		
		System.out.println("BgDaoImpl update Start...");
		int updateCount = 0;
		
		try {
			updateCount = session.update("updateCertBrd", board);
		} catch (Exception e) {
			System.out.println("BgDaoImpl updateCertBrd Exception -> "+e.getMessage());
		}
		return updateCount;
	}

	@Override
	public int deleteCertBrd(Board board) {
		System.out.println("BgDaoImpl delete Start...");
		System.out.println("BgDaoImpl delete getBrd_num -> "+board.getBrd_num());
		int result = 0;
		try {
			result = session.delete("deleteCertBrd", board);
			System.out.println("BgDaoImpl delete result -> "+result);
		} catch (Exception e) {
			System.out.println("BgDaoImpl delete Exception -> "+e.getMessage());
		}
		return result;
	}

	@Override
	public int certTotal(int chg_id) {
		System.out.println("BgDaoImpl certTotal Start...");
		int certTotal = 0;
		
		try {
			certTotal = session.selectOne("certTotal", chg_id);
		} catch (Exception e) {
			System.out.println("BgDaoImpl certTotal e.getMessage() -> "+e.getMessage());
		}
		System.out.println("BgDaoImpl certTotal -> "+certTotal);
		
		return certTotal;
	}


	@Override
	public void commentInsert(Board board) {
		System.out.println("BgDaoImpl commentInsert Start...");
		session.selectOne("commentInsert", board);
		System.out.println("BgDaoImpl commentInsert Start..."+board.getResultCount());
	}


	@Override
	public int srchCrtBdCnt(Board board) {
		int crtBdCntSrch = 0;
		System.out.println("BgDaoImpl srchCrtBdCnt Start...");
		
		try {
			crtBdCntSrch = session.selectOne("srchCrtBdCnt", board);
			System.out.println("BgDaoImpl srchCrtBdCnt crtBdCntSrch -> "+crtBdCntSrch);
		} catch (Exception e) {
			System.out.println("BgDaoImpl srchCrtBdCnt Exception -> "+e.getMessage());
		}
		
		return crtBdCntSrch;
	}
	
	
	@Override
	public List<Board> searchCrtBd(Board board) {
		List<Board> crtBdSearch = null;
		System.out.println("BgDaoImpl searchCrtBd Start...");
		System.out.println("BgDaoImpl searchCrtBd board.getKeyword() -> "	+board.getKeyword());
		System.out.println("BgDaoImpl searchCrtBd board.getSearchType() -> "+board.getSearchType());
		System.out.println("BgDaoImpl searchCrtBd board.getSortBy() -> "	+board.getSortBy());
		try {
			crtBdSearch = session.selectList("searchCrtBd", board);
			for(Board board1   : crtBdSearch) {
				System.out.println("BgDaoImpl searchCrtBd board1->"+board1);
			}
		} catch (Exception e) {
			System.out.println("BgDaoImpl searchCrtBd Exception -> "+e.getMessage());
		}
		return crtBdSearch;
	}


	



}

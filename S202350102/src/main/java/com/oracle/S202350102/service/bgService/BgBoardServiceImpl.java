package com.oracle.S202350102.service.bgService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.bgDao.BgBoardDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BgBoardServiceImpl implements BgBoardService {
	
	public final BgBoardDao	bBoardD;
	
	@Override
	public Challenge bgChgDetail(int chg_id) {
		System.out.println("BgServiceImpl bgChgDetail Start...");
		System.out.println("BgServiceImpl bgChgDetail chg_id"+chg_id);
		Challenge chg = bBoardD.bgChgDetail(chg_id);
		return chg;
	}
	
	
	@Override
	public List<Board> certBoard(Board board) {
		List<Board> boardCert = null;
		System.out.println("BgServiceImpl certBoard Start...");
		boardCert = bBoardD.certBoard(board);
		System.out.println("BgServiceImpl certBoard boardCert.size() -> "+boardCert.size());
		return boardCert;
	}

	@Override
	// Ajax용
	public List<Board> boardCert(Board board) {
		
		List<Board> certBoard = null;
		System.out.println("BgServiceImpl boardCert Start...");
		certBoard = bBoardD.boardCert(board);
		System.out.println("BgServiceImpl certBoard.size() -> "+certBoard.size());
		return certBoard;
	}

	
	
	@Override
	public int insertCertBrd(Board board) {
		
		int result = bBoardD.insertCertBrd(board);
		System.out.println("BgServiceImpl insert Start...");
		
		return result;
	}

	@Override
	public int updateCertBrd(Board board) {
		
		System.out.println("BgServiceImpl update...");
		int updateCount = bBoardD.updateCertBrd(board);
		
		return updateCount;
	}

	@Override
	public int deleteCertBrd(Board board) {
		int result = bBoardD.deleteCertBrd(board);
		System.out.println("BgServiceImpl delete Start...");
		return result;
	}

	@Override
	public int certTotal(int chg_id) {
		System.out.println("BgServiceImpl certTotal Start...");
		int certTotal = bBoardD.certTotal(chg_id);
		return certTotal;
	}


	@Override
	public void commentInsert(Board board) {
		System.out.println("BgServiceImpl commentInsert Start...");
		bBoardD.commentInsert(board);
	}


	@Override
	public int srchCrtBdCnt(Board board) {
		System.out.println("BgServiceImpl srchCrtBdCnt Start...");
		int crtBdCntSrch = bBoardD.srchCrtBdCnt(board);
		System.out.println("BgServiceImpl srchCrtBdCnt crtBdCntSrch -> "+crtBdCntSrch);
		return crtBdCntSrch;
	}
	
	
	@Override
	public List<Board> searchCrtBd(Board board) {
		List<Board> crtBdSearch = null;
		System.out.println("BgServiceImpl searchCrtBd Start...");
		System.out.println("BgServiceImpl searchCrtBd board.getKeyword() -> "	+board.getKeyword());
		System.out.println("BgServiceImpl searchCrtBd board.getSearchType() -> "+board.getSearchType());
		System.out.println("BgServiceImpl searchCrtBd board.getSortBy() -> "	+board.getSortBy());
		crtBdSearch = bBoardD.searchCrtBd(board);
		System.out.println("BgServiceImpl searchCrtBd crtBdSearch.size()  -> "+crtBdSearch.size());
		return crtBdSearch;
	}







}

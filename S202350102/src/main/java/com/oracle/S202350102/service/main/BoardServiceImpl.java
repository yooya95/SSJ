package com.oracle.S202350102.service.main;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.mainDao.BoardDao;
import com.oracle.S202350102.dto.Board;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	private final BoardDao bd;

	@Override
	public List<Board> selectChgCert(Board board) {
		List<Board> chgCert = bd.selectChgCert(board);
		return chgCert;
	}

}

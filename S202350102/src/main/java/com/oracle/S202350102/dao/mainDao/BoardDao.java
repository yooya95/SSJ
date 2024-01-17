package com.oracle.S202350102.dao.mainDao;

import java.util.List;

import com.oracle.S202350102.dto.Board;

public interface BoardDao {

	List<Board> selectChgCert(Board board);

}

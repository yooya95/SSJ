package com.oracle.S202350102.dao.yrDao;

import com.oracle.S202350102.dto.BoardLike;

public interface YrBoardLikeDao {

	int 	selectBrdLikeYN(BoardLike brdLike);
	int		deleteBrdLike(BoardLike brdLike);
	int 	insertBrdLike(BoardLike brdLike);
	int 	selectBrdLikcCnt(int brd_num);

}

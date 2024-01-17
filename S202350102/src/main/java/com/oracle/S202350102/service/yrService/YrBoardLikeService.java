package com.oracle.S202350102.service.yrService;

import com.oracle.S202350102.dto.BoardLike;

public interface YrBoardLikeService {
	int 	likePro(BoardLike brdLike);
	int 	selectBrdLikeYN(BoardLike brdLike);
	int 	selectBrdLikcCnt(int brd_num);

}

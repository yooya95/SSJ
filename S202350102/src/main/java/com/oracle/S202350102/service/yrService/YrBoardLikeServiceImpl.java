package com.oracle.S202350102.service.yrService;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.yrDao.YrBoardLikeDao;
import com.oracle.S202350102.dto.BoardLike;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class YrBoardLikeServiceImpl implements YrBoardLikeService {
	private final YrBoardLikeDao ybld;
	
	// 좋아요 여부 판단용
	public int selectBrdLikeYN(BoardLike brdLike) {
		int result = ybld.selectBrdLikeYN(brdLike);
		System.out.println("YrBoardLikeServiceImpl selectBrdLikeYN result -> " + result);
		return result;
	}
	
	@Override
	public int likePro(BoardLike brdLike) {
		int result = 0;
		
		if(this.selectBrdLikeYN(brdLike) == 1) {
			// selectBrdLikeYN(brdLike) == 1 -> brdLike 값 있다 -> 없애기
			ybld.deleteBrdLike(brdLike);
			result = 0;
		} else {
			// selectBrdLikeYN(brdLike) == 0 -> brdLike 값 없다 -> 추가하기
			ybld.insertBrdLike(brdLike);
			result = 1;
		}
		System.out.println("YrBoardLikeServiceImpl likePro result -> " + result);
		return result;
	}

	@Override
	public int selectBrdLikcCnt(int brd_num) {
		int result = ybld.selectBrdLikcCnt(brd_num);
		System.out.println("YrBoardLikeServiceImpl selectBrdLikcCnt result -> " + result);
		
		return result;
	}

}

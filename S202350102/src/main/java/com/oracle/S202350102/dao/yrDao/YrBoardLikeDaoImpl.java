package com.oracle.S202350102.dao.yrDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.BoardLike;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class YrBoardLikeDaoImpl implements YrBoardLikeDao {
	private final SqlSession session;
	
	@Override
	public int selectBrdLikeYN(BoardLike brdLike) {
		int result = 0;
		try {
			result = session.selectOne("yrSelectBrdLikeYN", brdLike);
		} catch (Exception e) {
			System.out.println(e.getMessage());			
		}
		return result;
	}

	@Override
	public int deleteBrdLike(BoardLike brdLike) {
		int result = 0;
		
		try {
			result = session.delete("yrDeleteBrdLike", brdLike);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			result = -1;
		}
		return result;
	}

	@Override
	public int insertBrdLike(BoardLike brdLike) {
		int result = 0;
		
		try {
			result = session.insert("yrInsertBrdLike", brdLike);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			result = -1;
		}
		
		return result;
	}

	@Override
	public int selectBrdLikcCnt(int brd_num) {
		int result = 0;
		
		try {
			result = session.selectOne("yrBrdLikeCnt", brd_num);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

}

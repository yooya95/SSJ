package com.oracle.S202350102.dao.chDao;

import java.util.List;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.SearchHistory;

public interface ChSearchDao {
	
	int 			saveWord(SearchHistory sh);
	List<Challenge> chgSearching(Board board);
	List<Board> 	brdSearching(Board board);
	List<SearchHistory> sHistoryList(int user_num);
	int				upDateHistory(SearchHistory sh);
	int				deleteHis(SearchHistory sh);
	List<Board>  	shareSearching(Board board);
	int 			chgSrchTot(Board board);
	int 			chgSrchBTot(Board board);
}

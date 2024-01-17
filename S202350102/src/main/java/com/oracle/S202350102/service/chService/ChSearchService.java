package com.oracle.S202350102.service.chService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.SearchHistory;

public interface ChSearchService {

	int 				saveWord(SearchHistory sh);
	List<Challenge> 	chgSearching(Board board);
	List<Board> 		brdSearching(Board board);
	List<Board> 		shareSearching(Board board);
	List<SearchHistory> sHistoryList(int user_num);
	void 				updateHistory(SearchHistory sh);
	int 				deleteHis(SearchHistory sh);
	int 				chgSrchTot(Board board);
	int 				chgSrchBTot(Board board);	
}

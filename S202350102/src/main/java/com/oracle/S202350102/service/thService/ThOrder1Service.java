package com.oracle.S202350102.service.thService;

import com.oracle.S202350102.dto.Order1;

public interface ThOrder1Service {

	int 			insertOrder(Order1 order1);
	int 			selectMaxOrderNum();
	Order1 			selectOrderJoinMem(Order1 order1);
	Order1 			selectOrderSucess(int user_num);
	int 			transactionOrderInsertUpdate(String tid, int user_num);
	int 			tranxOrdUsrUptSuc(int order_num, int user_num);

}

package com.kpet.service;

import java.util.List;

import com.kpet.domain.Criteria;
import com.kpet.domain.DetailOrderInfo;
import com.kpet.domain.DetailOrderList;
import com.kpet.domain.OrderInfoVO;
import com.kpet.domain.OrderVO;
import com.kpet.domain.UserOrderListInfo;

public interface OrderService {
	
	public void orderInsert(OrderVO vo, DetailOrderList vo2);
	
	public List<OrderInfoVO> directOrderInfo(Integer pro_num, Integer ord_amount);
	
	// 장바구니 체크 주문하기*
	public OrderInfoVO checkOrderInfo(Integer cart_code, String user_id);
	
	//public List<OrderVO> getUserOrderList(String user_id);
	
	public List<UserOrderListInfo> userOrderListInfo(String user_id);
	
	public int getTotalCount(String user_id);
	
	public List<OrderVO> userOrderListPaging(Criteria cri, String user_id);
	
	public int ordStateCount(String user_id, String ord_state, String threeMonthsDate);

}

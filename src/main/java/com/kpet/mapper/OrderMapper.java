package com.kpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.Criteria;
import com.kpet.domain.DetailOrder;
import com.kpet.domain.DetailOrderInfo;
import com.kpet.domain.OrderInfoVO;
import com.kpet.domain.OrderVO;
import com.kpet.domain.UserOrderListInfo;

public interface OrderMapper {

	public List<OrderInfoVO> directOrderInfo(@Param("pro_num") Integer pro_num, @Param("ord_amount") Integer ord_amount);
	
	// 장바구니 체크 주문하기
	public OrderInfoVO checkOrderInfo(@Param("cart_code") Integer cart_code, @Param("user_id") String user_id);
	
	public void orderInsert(OrderVO vo);
	
	public void orderDetailInsert(DetailOrder vo);
	
	public List<UserOrderListInfo> userOrderListInfo(String user_id);
	
	public int getTotalCount(String user_id);
	
	public List<OrderVO> userOrderListPaging(@Param("cri") Criteria cri, @Param("user_id") String user_id);
	
	public int ordStateCount(@Param("user_id") String user_id, @Param("ord_state") String ord_state, @Param("threeMonthsDate") String threeMonthsDate);

}

package com.kpet.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.Criteria;
import com.kpet.domain.DetailOrderInfo;
import com.kpet.domain.OrderVO;

public interface AdminOrderService {

	public List<OrderVO> getListWithPaging(Criteria cri, String startDate, String endDate);
	
	public int getTotalCount(Criteria cri, String startDate, String endDate);
	
	public List<OrderVO> getOrderStateListWithPaging(Criteria cri, String ord_state);
	
	public int getOrderStateTotalCount(Criteria cri, String ord_state);
	
	public void orderStateChange(Integer ord_code, String ord_state);
	
	public void ordDelete(Integer ord_code);
	
	public List<DetailOrderInfo> detailOrderInfo(Integer ord_code);
	
	public void ordDetailListDelete(Integer ord_code, Integer pro_num);
	
	public int getOrderStateCount(String ord_state);
	
}

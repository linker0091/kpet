package com.kpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.Criteria;
import com.kpet.domain.DetailOrderInfo;
import com.kpet.domain.OrderVO;

public interface AdminOrderMapper {

	/*일반 주문목록*/
	public List<OrderVO> getListWithPaging(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	
	public int getTotalCount(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	
	/*주문상태별 목록*/
	public List<OrderVO> getOrderStateListWithPaging(@Param("cri") Criteria cri, @Param("ord_state") String ord_state);
	
	public int getOrderStateTotalCount(@Param("cri") Criteria cri, @Param("ord_state") String ord_state);
	
	public void orderStateChange(@Param("ord_code") Integer ord_code, @Param("ord_state") String ord_state);
	
	public void ordDelete(Integer ord_code);
	
	public void ordDetailDelete(Integer ord_code);
	
	public List<DetailOrderInfo> detailOrderInfo(Integer ord_code);
	
	public void ordDetailListDelete(@Param("ord_code") Integer ord_code, @Param("pro_num") Integer pro_num);
	
	public int getOrderStateCount(String ord_state);
	
	
}

package com.kpet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpet.domain.Criteria;
import com.kpet.domain.DetailOrderList;
import com.kpet.domain.OrderInfoVO;
import com.kpet.domain.OrderVO;
import com.kpet.domain.UserOrderListInfo;
import com.kpet.mapper.AdminProuductMapper;
import com.kpet.mapper.CartMapper;
import com.kpet.mapper.OrderMapper;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	private OrderMapper mapper;
	
	@Inject
	private AdminProuductMapper productMapper;
	
	@Inject
	private CartMapper cartMapper;
	
	@Transactional
	@Override
	public void orderInsert(OrderVO order, DetailOrderList orderDetail) {
		
		//1)주문작업
		mapper.orderInsert(order); // vo안에 ord_code 변수값을 이용하여, 시퀀스값을 참조할수가 있다.
		
		Integer ord_code = order.getOrd_code();
		String user_id = order.getUser_id();
		
		//2)주문상세 작업
		orderDetail.getOrderDetailList().forEach(oDetail -> {
			oDetail.setOrd_code(ord_code);
			mapper.orderDetailInsert(oDetail);
		});
		
		//3)장바구니 삭제. 직접구매 또는 장바구니 목록에서 구매 공통으로 실행된다.
		//4)상품 재고 업데이트.
	    orderDetail.getOrderDetailList().forEach(oDetail -> {
	        Integer pro_num = oDetail.getPro_num();
	        int ord_amount = oDetail.getDt_ord_amount();
	        // 카트에서 해당 상품 정보 삭제
	        cartMapper.cartCheckDel(pro_num, ord_amount);
	        productMapper.product_update_amount(ord_amount, pro_num);
	    });
	}
		
	@Override
	public List<OrderInfoVO> directOrderInfo(Integer pro_num, Integer ord_amount) {
		// TODO Auto-generated method stub
		return mapper.directOrderInfo(pro_num, ord_amount);
	}

	// 장바구니 체크 주문하기
	@Override
	public OrderInfoVO checkOrderInfo(Integer cart_code,String user_id) {
		// TODO Auto-generated method stub
		return mapper.checkOrderInfo(cart_code,user_id);
	}

	@Override
	public List<UserOrderListInfo> userOrderListInfo(String user_id) {
		// TODO Auto-generated method stub
		return mapper.userOrderListInfo(user_id);
	}

	@Override
	public int getTotalCount(String user_id) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(user_id);
	}

	@Override
	public List<OrderVO> userOrderListPaging(Criteria cri, String user_id) {
		// TODO Auto-generated method stub
		return mapper.userOrderListPaging(cri, user_id);
	}
	
	@Override
	public int ordStateCount(String user_id, String ord_state, String threeMonthsDate) {
		// TODO Auto-generated method stub
		return mapper.ordStateCount(user_id,ord_state,threeMonthsDate);
	}

}

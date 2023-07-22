package com.kpet.service;

import java.util.List;

import com.kpet.domain.CartListVO;
import com.kpet.domain.CartVO;

public interface CartService {
	
	public void cartAdd(CartVO vo);
	
	public List<CartListVO> cartList(String user_id );
	
	public int cartAmount(String user_id );
	
	public void cartDel(Integer cart_code);
	
	public void cartAllDel(String user_id);

	public void cartAmountChange(CartVO vo);
	
}

package com.kpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.CartListVO;
import com.kpet.domain.CartVO;

public interface CartMapper {

	public void cartAdd(CartVO vo);
	
	public List<CartListVO> cartList(String user_id );
	
	public int cartAmount(String user_id );
	
	public void cartDel(Integer cart_code);
	
	public void cartAllDel(String user_id);
	
	public void cartAmountChange(CartVO vo);
	
	public void cartCheckDel(@Param("pro_num") Integer pro_num, @Param("cart_amount")  int cart_amount);
	
}

package com.kpet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kpet.domain.CartListVO;
import com.kpet.domain.CartVO;
import com.kpet.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	private CartMapper mapper;
	
	@Override
	public void cartAdd(CartVO vo) {
		
		mapper.cartAdd(vo);
	}

	@Override
	public List<CartListVO> cartList(String user_id) {
		// TODO Auto-generated method stub
		return mapper.cartList(user_id);
	}
	
	@Override
	public int cartAmount(String user_id) {
		// TODO Auto-generated method stub
		return mapper.cartAmount(user_id);
	}

	@Override
	public void cartDel(Integer cart_code) {
		// TODO Auto-generated method stub
		mapper.cartDel(cart_code);
	}

	@Override
	public void cartAllDel(String user_id) {
		// TODO Auto-generated method stub
		mapper.cartAllDel(user_id);
	}

	@Override
	public void cartAmountChange(CartVO vo) {
		// TODO Auto-generated method stub
		mapper.cartAmountChange(vo);
	}

}

package com.kpet.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kpet.domain.UserVO;
import com.kpet.service.CartService;
import com.kpet.service.UserProductService;

import lombok.extern.log4j.Log4j;


// basePackages = {"com.doccomsa.controller"} ? 공통 모델데이타를 참조하는 컨트롤러의 패키지 지정.
@Log4j
@ControllerAdvice(basePackages = {"com.kpet.controller"})
public class GlobalControllerAdvice {
	
	@Inject
	private UserProductService service;
	
	@Inject
	private CartService cservice;
	
	private CartController cController;
	
	// 페이지에서 공통으로 보여주는 정보. 예)쇼핑몰 - 카테고리정보
	
	@ModelAttribute
	public void commonCategoryData(Model model) {
		
		/*
		int cartTotal = 0;
		for(int i=0; i>cartlist.size(); i++) {
			cartTotal += cartlist.get(i).getCart_amount();
		}*/
		
		log.info("공통모델 데이타 참조");
		
		model.addAttribute("userCategory", service.mainCategory());
		//model.addAttribute("cartList", cartTotal);
	}

	
    
}

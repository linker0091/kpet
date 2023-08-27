package com.kpet.controller;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kpet.service.AdminConsultService;
import com.kpet.service.AdminOrderService;
import com.kpet.service.UserConsultService;
import com.kpet.service.UserProductService;

import lombok.extern.log4j.Log4j;


// basePackages = {"com.doccomsa.controller"} ? 공통 모델데이타를 참조하는 컨트롤러의 패키지 지정.
@Log4j
@ControllerAdvice(basePackages = {"com.kpet.controller"})
public class GlobalControllerAdvice {
	
	@Inject
	private UserProductService service;
	
	@Inject
	private AdminOrderService ad_ord_service;
	@Inject
	private UserConsultService us_con_service;
	
	// 페이지에서 공통으로 보여주는 정보. 예)쇼핑몰 - 카테고리정보
	
	//카테고리 메뉴 정보
	@ModelAttribute
	public void commonCategoryData(Model model) {
		
		log.info("공통모델 데이타 참조");
		
		model.addAttribute("userCategory", service.mainCategory());
	}

	//관리자 페이지 헤더 알림 정보
	@ModelAttribute
	public void adminData(Model model) {
		
		
		log.info("어드민");
		int ordPaid = ad_ord_service.getOrderStateCount("결제완료");
		int ordCancel = ad_ord_service.getOrderStateCount("취소요청");
		int ordExchange = ad_ord_service.getOrderStateCount("교환요청");
		int ordReturn = ad_ord_service.getOrderStateCount("반품요청");
		
		int requestCount = ordPaid + ordCancel + ordExchange + ordReturn;
		
		model.addAttribute("cst_requestCount", us_con_service.getConsultAnswerCount("N")); //상담 요청 개수
		model.addAttribute("ordPaid", ordPaid); //결제 완료 개수
		model.addAttribute("ordCancel", ordCancel); //취소 요청 개수
		model.addAttribute("ordExchange", ordExchange); //교환 요청 개수
		model.addAttribute("ordReturn", ordReturn); //반품 요청 개수
		model.addAttribute("ord_requestCount", requestCount); //주문 요청 개수
		
	}
}

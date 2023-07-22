package com.kpet.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kpet.domain.Criteria;
import com.kpet.domain.DetailOrderList;
import com.kpet.domain.OrderInfoVO;
import com.kpet.domain.OrderVO;
import com.kpet.domain.PageDTO;
import com.kpet.domain.ReviewVO;
import com.kpet.domain.UserOrderListInfo;
import com.kpet.domain.UserVO;
import com.kpet.service.AdminOrderService;
import com.kpet.service.KakaoPayServiceImpl;
import com.kpet.service.OrderService;
import com.kpet.service.ReviewService;
import com.kpet.util.UploadFileUtils;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/order/*")
@Controller
public class OrderController {

	//상품 이미지 업로드 폴더
	@Resource(name = "uploadFolder")
	String uploadFolder; // d:\\dev\\upload */
	
	@Autowired
	private OrderService oService;
	
	@Autowired
	private AdminOrderService adService;
	
	@Autowired
	private ReviewService rService;
	
	//주문하기
	@RequestMapping("/orderInfo")
	public void orderInfo(@RequestParam(value = "type", required = false, defaultValue = "cart_order") String type, @RequestParam(value = "pro_num", required = false) Integer pro_num, @RequestParam(value = "pro_amount", required = false) Integer pro_amount, @RequestParam(value ="cart_codeArr", required = false) List<Integer> cart_codeArr, HttpSession session, Model model) {
	
		String user_id = ((UserVO) session.getAttribute("loginStatus")).getUser_id();
		
		List<OrderInfoVO> list = null;
		
		if(type.equals("direct")) {
			// 상품1개
			list = oService.directOrderInfo(pro_num, pro_amount);  // 1)메인에서 바로구매 2)상품상세 바로구매
			(list.get(0)).setCart_amount(pro_amount); // 수량변경.
			// 장바구니에서 구매
		}else if (type.equals("check_order")) {  //장바구니 체크 구매 04/10*
			list = new ArrayList<>();
		    for (int i = 0; i < cart_codeArr.size(); i++) {
	        OrderInfoVO vo = oService.checkOrderInfo(cart_codeArr.get(i), user_id);
	        list.add(vo);
		    }
		}			
		// 슬래시를 역슬래시로 바꾸는 구문.
		for(int i=0; i<list.size(); i++) {
			OrderInfoVO vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		} 

		// 주문내역정보
		model.addAttribute("orderInfo", list);
	}
	
	//상품리스트의 이미지출력(썸네일)
	@ResponseBody
	@GetMapping("/displayFile")  // 클라이언트에서 보내는 특수문자중에 역슬래시 데이타를 스프링에서 지원하지 않는다. 
	public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName) {
		
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFileUtils.getFileByte(uploadFolder, uploadPath, fileName );
		
		return entity;
	}
	
	//주문결제
	@PostMapping("/orderAction")
	public String orderAction(OrderVO order, DetailOrderList orderDetail, HttpSession session, RedirectAttributes rttr) {
		
		order.setUser_id(((UserVO) session.getAttribute("loginStatus")).getUser_id());
		
		log.info("주문정보: " + order);
		log.info("주문상세정보: " + orderDetail);

	    // 무통장 입금명 Ord_depositor의 값이 없을 경우 주문자의 이Ord_name()의 값으로 대체
	    if (order.getOrd_depositor() == null ||  order.getOrd_depositor().trim().isEmpty()) {
	        order.setOrd_depositor(order.getOrd_name());
	    }else {//카카오 결제시
	        order.setOrd_depositor("");
	    }
	    
	    oService.orderInsert(order, orderDetail);
		
		// 예> 주문번호:100 [상품 5 건]
		String pro_name = String.format("주문번호:%d [상품 %d 건]", order.getOrd_code(), orderDetail.getOrderDetailList().size());
		
		return "redirect:/order/orderComplete";
	}
	
	//결제완료후 페이지
	@GetMapping("/orderComplete")
	public void orderList(HttpSession session, @ModelAttribute("cri") Criteria cri, Model model) {
		
		String user_id = ((UserVO) session.getAttribute("loginStatus")).getUser_id();
		
		cri.setAmount(5);
		
		//주문목록
		List<OrderVO> list = oService.userOrderListPaging(cri, user_id);
		//주문상세
		List<UserOrderListInfo> detailList = oService.userOrderListInfo(user_id);
		//주문 총 개수
		int total = oService.getTotalCount(user_id);
		// 해당 리뷰정보
		List<ReviewVO> rlist= rService.userReview(user_id);
		
		// 슬래시를 역슬래시로 바꾸는 구문.
		for(int i=0; i< detailList.size(); i++) {
			UserOrderListInfo vo = detailList.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		}

		//페이지
		model.addAttribute("ord_total", total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		//주문목록 주문상세정보
		model.addAttribute("list", list);
		model.addAttribute("oDetailList", detailList);
		//리뷰 정보
		model.addAttribute("reviewVO", rlist);
		
	}
	
	//주문 취소, 교환, 반품 요청
	@ResponseBody
	@PostMapping("/orderStateChange")
	public ResponseEntity<String> stateChange(Integer ord_code, String ord_state, HttpSession session) {
		
		ResponseEntity<String> entity = null;
		
		OrderVO vo = new OrderVO();
		vo.setOrd_code(ord_code);;
		vo.setOrd_state(ord_state);
		
		try {
			adService.orderStateChange(ord_code, ord_state);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
}

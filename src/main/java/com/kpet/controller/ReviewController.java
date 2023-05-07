package com.kpet.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kpet.domain.Condition;
import com.kpet.domain.Criteria;
import com.kpet.domain.PageDTO;
import com.kpet.domain.ProductVO;
import com.kpet.domain.ReviewAllList;
import com.kpet.domain.ReviewVO;
import com.kpet.domain.UserVO;
import com.kpet.service.ReviewService;
import com.kpet.service.UserProductService;
import com.kpet.util.UploadFileUtils;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/review/*")
//@RestController : 메서드의 리턴값을 클라이언트에게 보내는 용도.
@Controller    // 메서드가 실행시 해당 jsp가 실행이 된 결과를 클라이언트에게 보내는 용도.
public class ReviewController {

	@Resource(name = "rew_uploadFolder")
	String rew_uploadFolder; // d:\\dev\\rew_upload */
	
	@Autowired
	private ReviewService service;
	
	@Inject // 필드주입
	private UserProductService proservice;
	
		
	//상품후기목록, 페이징구현정보
	@GetMapping("/productReview")
	public void product_review(@ModelAttribute("cri") Criteria cri,  
								@RequestParam("pro_num") Integer pro_num, Model model) {
		
		log.info("productReview");
		
		cri.setAmount(3);

		int total = service.getTotalCount(pro_num);
		log.info("productReview total: " + total);
				
		
		List<ReviewVO> list = service.getReviewListWithPaging(cri, pro_num);
		
	
		for(int i=0; i<list.size(); i++) {
			ReviewVO vo = list.get(i);
			log.info("vo: " + vo);

			//리뷰에 이미지가 있는 경우에만 *
			if(vo.getRew_uploadpath() != null) {
			vo.setRew_uploadpath(vo.getRew_uploadpath().replace("\\", "/"));
			}
		}
		
		List<ReviewAllList> a_list = service.getAllReview(pro_num);
			
		for(int i=0; i<a_list.size(); i++) {
			ReviewAllList a_vo = a_list.get(i);
			//리뷰에 이미지가 있는 경우에만 *
			if(a_vo.getRew_uploadpath() != null) {
				a_vo.setRew_uploadpath(a_vo.getRew_uploadpath().replace("\\", "/"));
			}
		}

		model.addAttribute("rewPageMaker", new PageDTO(cri, total));
		model.addAttribute("reviewListVO",list);
		model.addAttribute("reviewImg",a_list);
		model.addAttribute("ProductVO",proservice.productDetail(pro_num) );
		log.info("productReview model: " + model);

	}
	

	@GetMapping("/productReviewImg")
	public void product_review(@ModelAttribute("pro_num") Integer pro_num, @RequestParam(value="rew_num", required=false) Integer rew_num, @ModelAttribute("currentPageUrl") String currentPageUrl, Model model) {
		
		
		
		List<ReviewAllList> allList = service.getAllReview(pro_num);
		for(int i=0; i<allList.size(); i++) {
			ReviewAllList vo = allList.get(i);
			//리뷰에 이미지가 있는 경우에만 *
			if(vo.getRew_uploadpath() != null) {
			vo.setRew_uploadpath(vo.getRew_uploadpath().replace("\\", "/"));
			}		}
		log.info("productReview allList: " + allList);

		ProductVO pro = proservice.productDetail(pro_num);
		String pro_uploadpath = pro.getPro_uploadpath().replace("\\", "/");
		pro.setPro_uploadpath(pro_uploadpath);
		
		log.info("productReview currentPageUrl: " + currentPageUrl);
		
		//사진클릭시 , 전체보기 클릭시 구분
		log.info("리뷰넘: " + rew_num);
		String isRew_num = "N";
		if(rew_num != null) {
			isRew_num = "Y";
		}else {
			rew_num = allList.get(0).getRew_num();
		}
		model.addAttribute("isRew_num", isRew_num);
		
		model.addAttribute("ProductVO",pro );
		model.addAttribute("reviewAllVO",allList);
		model.addAttribute("rew_num",rew_num );
		log.info("productReview model: " + model);

	}
	
	
	
	//상품후기수정
	//상품수정 폼
	@GetMapping("/reviewModify")
	public void reviewModify(ReviewVO Review, @ModelAttribute("cri") Criteria cri, Model model) {
		
		//1)리뷰정보
		ReviewVO vo = service.getOrdReview(Review);
		log.info("vo: " + vo);
		
		//리뷰에 이미지가 있는 경우에만 *
		if(vo.getRew_uploadpath() != null) {
		vo.setRew_uploadpath(vo.getRew_uploadpath().replace("\\", "/"));
		}
				
		model.addAttribute("ReviewVO", vo); 
		
	}
		
		//리뷰 수정
		@PostMapping("/reviewModify")
		public String reviewModify(Criteria cri, ReviewVO vo, HttpSession session, RedirectAttributes rttr) {
			
			//상품이미지 변경을 할 경우는 기존이미지는 삭제한다.
			//상품이미지 변경을 하지 않은 경우는 기존이미지명을 그대로 수정처리한다.
			vo.setUser_id(((UserVO) session.getAttribute("loginStatus")).getUser_id());
			
			//1)이미지가 변경된 경우
			if(vo.getUpload().getSize() > 0) {
				
				//1)기존이미지정보 파일삭제
				UploadFileUtils.deleteFile(rew_uploadFolder, vo.getRew_uploadpath(), vo.getRew_img());
				//2)변경이미지 업로드작업
				vo.setRew_img(UploadFileUtils.uploadFile(rew_uploadFolder, vo.getUpload()));
				vo.setRew_uploadpath(UploadFileUtils.getFolder()); // 날짜폴더명
			}
			
			log.info("post vo: " + vo);
			service.reviewModify(vo);
			log.info("pro_num: " + vo.getPro_num());
			
			rttr.addAttribute("pro_num", vo.getPro_num());
			//rttr.addAttribute("rewPageMaker", new PageDTO(cri, total));
			//rttr.addAttribute("rewPageNum", cri.getPageNum()); // 주소에서 호출되는 메서드 파라미터 참조.
			//rttr.addAttribute("rewAmount", cri.getAmount());
			return "redirect:/order/orderComplete" + cri.getListLink();
		}
	
	
	//상품후기삭제 코드수정 파일 삭제 추가*
	@PostMapping("/reviewDel")
	public String productDelete(Criteria cri, @RequestParam("rew_num") Integer rew_num, RedirectAttributes rttr ) {

		//파일 정보 가져오기
		ReviewVO vo = service.getReview(rew_num);

		//리뷰 삭제
		service.reviewDel(rew_num);

		//파일 삭제
		try {
			UploadFileUtils.deleteFile(rew_uploadFolder,vo.getRew_uploadpath(),vo.getRew_img());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		log.info("list: " + vo.getRew_img());
		log.info("list: " + vo.getRew_uploadpath());
		
		rttr.addFlashAttribute("msg", "deleteOk"); // jsp에서 참조.
		
		/*
		rttr.addAttribute("pageNum", cri.getPageNum()); // 주소에서 호출되는 메서드 파라미터 참조.
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
*/		
		return "redirect:/order/orderComplete" + cri.getListLink();
	}
	
	
	//상품후기목록, 페이징구현정보
	@GetMapping("/allReview")
	public void reviewList(@ModelAttribute("con") Condition con, @ModelAttribute("orderby") String orderby, Criteria cri, Model model) {
		cri.setAmount(3);

		List<ReviewAllList> list = null;
		int total = 0;

		log.info("pro_num: " + con);

    	list = service.getReviewCriteriaPaging(cri,con,orderby);
    	total = service.getCriteriaCount(con);
    
		for(int i=0; i<list.size(); i++) {
			ReviewAllList vo = list.get(i);
			//리뷰에 이미지가 있는 경우에만 *
			if(vo.getRew_uploadpath() != null) {
			vo.setRew_uploadpath(vo.getRew_uploadpath().replace("\\", "/"));
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
			}
		}
		
		log.info("con: " + con);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("reviewListVO", list);
	}

	//상품후기 폼
	@GetMapping("/reviewWrite")
	public void productReviewWrite(@ModelAttribute("pro_num") Integer pro_num,
			@ModelAttribute("ord_code") Integer ord_code, @ModelAttribute("cri") Criteria cri) {
		
		
		log.info("reviewWrite: " +pro_num +"/"+ord_code );
	
	}
	
			//상품후기등록 04/06 수정*
			@PostMapping("/reviewWrite")
			public String reviewWrite(Criteria cri, ReviewVO vo, HttpSession session, RedirectAttributes rttr) {
			    vo.setUser_id(((UserVO) session.getAttribute("loginStatus")).getUser_id());
		
			    MultipartFile uploadFile = vo.getUpload();
			    if (uploadFile != null && !uploadFile.isEmpty()) {
			        vo.setRew_img(UploadFileUtils.uploadFile(rew_uploadFolder, uploadFile));
			        vo.setRew_uploadpath(UploadFileUtils.getFolder());
			    } else {
			        vo.setRew_img("");
			        vo.setRew_uploadpath("");
			    }
		
			    service.reviewInsert(vo);
			    rttr.addFlashAttribute("msg", "insertOk");
		
			    return "redirect:/order/orderComplete" + cri.getListLink();
			}
			
			
			@GetMapping("/oneReview")
			public void oneReview(@RequestParam("rew_num") Integer rew_num, Model model) {
				
				ReviewVO vo = service.getReview(rew_num);
				//리뷰에 이미지가 있는 경우에만 *
				if(vo.getRew_uploadpath() != null) {
				vo.setRew_uploadpath(vo.getRew_uploadpath().replace("\\", "/"));
				}				
				log.info("받아오는값 vo: " + vo);

				model.addAttribute("review", vo);
				//model.addAttribute("type", type);
				log.info("받아오는값 vo: " + vo);

			}

			
			//상품리스트의 이미지출력(썸네일)
			@ResponseBody
			@GetMapping("/displayFile")  // 클라이언트에서 보내는 특수문자중에 역슬래시 데이타를 스프링에서 지원하지 않는다. 
			public ResponseEntity<byte[]> displayFile(String fileName, String uploadPath) {
				
				ResponseEntity<byte[]> entity = null;
				log.info("썸네일:1 ");

				entity = UploadFileUtils.getFileByte(rew_uploadFolder, uploadPath, fileName );
				log.info("썸네일:2 " + entity);

				return entity;
			}		
					
			
}

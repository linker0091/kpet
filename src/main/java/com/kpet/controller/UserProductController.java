package com.kpet.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpet.domain.CategoryVO;
import com.kpet.domain.Condition;
import com.kpet.domain.Criteria;
import com.kpet.domain.PageDTO;
import com.kpet.domain.ProductVO;
import com.kpet.service.UserProductService;
import com.kpet.util.UploadFileUtils;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/product/*")
@Controller
public class UserProductController {
	//상품이미지 업로드 폴더
	@Resource(name = "uploadFolder")
	String uploadFolder; // d:\\dev\\upload */

	@Inject // 필드주입
	private UserProductService service;
	
	// 2차카테고리 정보  
	@ResponseBody
	@GetMapping(value = "subCategory/{mainCategoryCode}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("mainCategoryCode") Integer cate_prtcode){
		
		log.info("cate_prtcode: " + cate_prtcode);
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
			entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cate_prtcode), HttpStatus.OK);
			log.info("서브코드 4 cate_prtcode: " + cate_prtcode);
			log.info(entity);
		
		return entity;
	}
	
	 //3차 last카테고리 정보
		@ResponseBody
		@GetMapping(value = "lastsubCategory/{lastmainCategoryCode}/{lastsubCategory}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		public ResponseEntity<List<CategoryVO>> lastsubCategory(@PathVariable("lastmainCategoryCode") Integer cate_prtcode, @PathVariable("lastsubCategory") Integer cate_subprtcode){
			
			log.info("cate_prtcode: " + cate_prtcode);
			log.info("cate_subprtcode: " + cate_subprtcode);
			
			ResponseEntity<List<CategoryVO>> entity = null;
				
			//2차 카테고리 클릭시
			
				entity = new ResponseEntity<List<CategoryVO>>(service.lastsubCategory(cate_prtcode, cate_subprtcode), HttpStatus.OK);
				log.info("받아오는값 cate_prtcode: " + cate_prtcode);
				log.info("받아오는값 cate_subprtcode: " + cate_subprtcode);
				
				log.info("넘기는 데이타 cate_subprtcode: " + entity);
				
			return entity;
		}
	
	// 메인에서 카테고리별 상품리스트
	@GetMapping("/productMain")
	public void productMain(@RequestParam(value="cate_prtcode", required = false)Integer cate_prtcode) {
		
	}
	
	//메인 탭 상품 리스트
	@GetMapping("/tabProduct")
	public String tabProduct(@RequestParam(value="cate_prtcode", required = false)Integer cate_prtcode, Criteria cri, Model model) {
		if(cate_prtcode == null ) { cate_prtcode = 1; };
		log.info("cate_prtcode 값: " + cate_prtcode);
		
		//탭에 따른 상품 리스트
		List<ProductVO> list = service.getListWithPaging(cate_prtcode, cri);
		
		for(int i=0; i<list.size(); i++) {
			ProductVO vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		}
		model.addAttribute("list", list);
		
		return "/product/tabProduct";
	}
	
	//카테고리별 상품리스트
	@GetMapping("/productList")
	public void productList(@ModelAttribute("cri") Criteria cri, @RequestParam(value="cate_code", required = false) Integer cate_code, @ModelAttribute("cate_prtcode") Integer cate_prtcode, @RequestParam(value="cate_subprtcode",  required = false) Integer cate_subprtcode, Model model) {
		
		cri.setAmount(8);
		
		log.info("컨트롤러cri" + cri);
		
		List<ProductVO> list = service.getListWithPaging(cate_prtcode, cri);
		int total = 0;
		
		//1차 카테에 해당 상품리스트
		if(cate_subprtcode == null && cate_code == null) {
			list = service.getListWithPaging(cate_prtcode, cri);
			total = service.getTotalCount(cate_prtcode);
			log.info("1차카테고리 총상품개수total: " + total);
			model.addAttribute("cateType", "firstCate");
		}
		//2차 카테 해당 상품리스트
		else if(cate_code == null ) { //2차 카테에 해당 상품리스트
			list = service.getLastListWithPaging(cate_prtcode, cate_subprtcode, cri);
			total = service.getSubTotalCount(cate_prtcode, cate_subprtcode);
			log.info("2차카테고리 총상품개수total: " + total);
			model.addAttribute("cate_subprtcode", cate_subprtcode);
			model.addAttribute("cateType", "secondCate");
		}
		//3차 카테 해당 상품리스트
		else if(cate_prtcode != null && cate_subprtcode != null && cate_code != null) {		//3차 카테에 해당 상품리스트
			list = service.getFinallListWithPaging(cate_code, cate_prtcode, cate_subprtcode, cri);
			total = service.getFinallSubTotalCount(cate_code, cate_prtcode, cate_subprtcode);
			log.info("3차카테고리 총상품개수total: " + total);
			model.addAttribute("cate_subprtcode", cate_subprtcode);
			
			model.addAttribute("cate_code", cate_code);
			model.addAttribute("cateType", "thirdCate");
		};
		
		// 슬래시를 역슬래시로 바꾸는 구문.
		for(int i=0; i<list.size(); i++) {
			ProductVO vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		}
		
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("productList", list);
		log.info("받아오는값 list: " + list);

	}
	
	//상품상세설명
	@GetMapping("/productDetail")
	public void productDetail(@RequestParam(value = "cateType", defaultValue = "firstCate") String cateType, @ModelAttribute("cri") Criteria cri, @RequestParam(value="cate_code", required = false) Integer cate_code, @RequestParam("pro_num") Integer pro_num, Model model) {

		ProductVO vo = service.productDetail(pro_num);
		vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		
		log.info("받아오는값 cate_code: " + cate_code);

		model.addAttribute("productVO", vo);
		model.addAttribute("cateType", cateType);
		log.info("받아오는값 vo: " + vo);

	}
	
	// 상품 검색 리스트
	@GetMapping("/productSearchList")
	public void productSearchList(@ModelAttribute("orderby") String orderby, @ModelAttribute("con") Condition con, @ModelAttribute("cri") Criteria cri, Model model) {
		
		//1차카테고리 정보
		model.addAttribute("mainCategory", service.mainCategory());
		
		cri.setAmount(10);
		
		log.info("컨트롤러cri" + cri);
		log.info("컨트롤러con" + con);
		List<ProductVO> list = null;
		int total = 0;

		list = service.productSearchList(orderby,con,cri);

		total = service.productSearchCount(con,cri);

		// 슬래시를 역슬래시로 바꾸는 구문.
		for(int i=0; i<list.size(); i++) {
			ProductVO vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		}
				
		log.info("total: " + total);
			
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("Condition", con);
		model.addAttribute("productList", list);
		log.info("받아오는값 list: " + list);

	}
	
	//상품리스트의 이미지출력(썸네일)
	@ResponseBody
	@GetMapping("/displayFile")  // 클라이언트에서 보내는 특수문자중에 역슬래시 데이타를 스프링에서 지원하지 않는다. 
	public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName) {
		
		ResponseEntity<byte[]> entity = null;

		entity = UploadFileUtils.getFileByte(uploadFolder, uploadPath, fileName );
		return entity;
	}
	
}

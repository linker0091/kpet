package com.kpet.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kpet.domain.CategoryVO;
import com.kpet.domain.Criteria;
import com.kpet.domain.PageDTO;
import com.kpet.domain.ProductVO;
import com.kpet.service.AdminProuductService;
import com.kpet.util.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/admin/product/*")
@Controller
public class AdProductController {
	
	//상품 이미지 업로드 폴더
	@Resource(name = "uploadFolder")
	String uploadFolder; // d:\\dev\\upload */
	
	//CKEditor 상품설명이미지 업로드 폴더
	@Resource(name= "ckUploadFolder")
	String ckUploadFolder;
	
	private AdminProuductService service;
	
	//상품등록 폼
	@GetMapping("/productInsert")
	public void product_insert(Model model) {
		
		//1차카테고리 정보
		model.addAttribute("mainCategory", service.mainCategory());
	}
	
	// 2차카테고리 정보
	@ResponseBody
	@GetMapping(value = "/subCategory/{mainCategoryCode}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("mainCategoryCode") Integer cate_prtcode){
		
		ResponseEntity<List<CategoryVO>> entity = null;
				
		entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cate_prtcode), HttpStatus.OK);
		
		return entity;
	}
	
	//3차카테고리 정보
	@ResponseBody
	@GetMapping(value = "lastsubCategory/{lastmainCategoryCode}/{lastsubCategory}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CategoryVO>> lastsubCategory(@PathVariable("lastmainCategoryCode") Integer cate_prtcode, @PathVariable("lastsubCategory") Integer cate_subprtcode){
				
		ResponseEntity<List<CategoryVO>> entity = null;
				
		entity = new ResponseEntity<List<CategoryVO>>(service.lastsubCategory(cate_prtcode, cate_subprtcode), HttpStatus.OK);
		log.info("받아오는값 cate_prtcode: " + cate_prtcode);
		log.info("받아오는값 cate_subprtcode: " + cate_subprtcode);
		log.info("넘기는 데이타 cate_subprtcode: " + entity);
				
		return entity;
	}
	
	//CKEditor 상품설명 이미지.
	@PostMapping("/editor/imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,@RequestParam MultipartFile upload) {
		
		/*
		 CKEditor 파일업로드 1)파일업로드 작업 2) 업로드된 파일정보를 브라우저에게 보내야 한다. 
		  
		 */
		
		// 클라이언트로부터 전송되어 온 파일을 업로드폴더에 복사(생성)작업
		OutputStream out = null;
		
		// 업로드된 파일정보를 브라우저에게 보내는 작업
		PrintWriter printWriter = null;
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			// 클라이언트에서 전송해 온 파일명을 포함하여, 실제 업로드되는 경로생성. 톰캣에서 관리하는 폴더.
			//String uploadPath = request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName;
			
			//물리적 경로
			String uploadPath = ckUploadFolder + "\\WEB-INF\\views\\admin\\product\\upload\\" + fileName;  
			
			log.info("업로드폴더 물리적경로: " + uploadPath);
			
			out = new FileOutputStream(new File(uploadPath)); // 0byte의 빈 파일생성
			
			// 파일에 내용이 채워짐.
			out.write(bytes);
			out.flush();
			
			/*======================================================================*/
			//CKEditor의 콜백 함수를 호출하는 JavaScript 코드를 출력
			String callback = request.getParameter("CKEditorFuncNum");
			
			log.info(callback);
			
			printWriter = response.getWriter();
			
			// <resources mapping="/upload/**" location="/resources/upload/" />
			String fileUrl = "/product/upload/" + fileName;
					
			printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction("
								+ callback
								+ ",'"
								+ fileUrl
								+ "','이미지를 업로드 하였습니다.'"
								+ ")</script>");
			printWriter.flush();//데이터 출력
		
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
			if(out != null) out.close();
			if(printWriter != null) printWriter.close();
			}catch(Exception ex) {
				ex.printStackTrace();
			}
			
		}
				
	}
	
	//상품등록 저장
	@PostMapping("/productInsert")
	public String product_insert(ProductVO vo, RedirectAttributes rttr) {
		
		log.info("상품정보" + vo);
		
		//1)파일업로드. 파일이름을 추출하여 저장
		vo.setPro_img(UploadFileUtils.uploadFile(uploadFolder, vo.getUpload()));
		vo.setPro_uploadpath(UploadFileUtils.getFolder()); // 날짜폴더명

		//2)상품정보 저장
		service.product_isnert(vo);
		
		rttr.addFlashAttribute("msg", "insertOk");
		
		return "redirect:/admin/product/productList";
	}
	
	//상품목록
	@GetMapping("/productList")
	public void product_list(Criteria cri, Model model) {
		
		cri.setAmount(5);
		List<ProductVO> list = service.getListWithPaging(cri);
		
		// 역슬래시를 슬래시로 바꾸는 구문.
		for(int i=0; i<list.size(); i++) {
			ProductVO vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		}
		
		int total = service.getTotalCount(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("productList", list);
	}
	
	//상품수정 폼
	@GetMapping("/productModify")
	public void product_modify(@RequestParam("pro_num") Integer pro_num, Model model) {
		
		//1)상품정보
		ProductVO vo = service.product_modify(pro_num);
		vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		model.addAttribute("productVO", vo); 
		
		//2)1차카테고리 정보
		model.addAttribute("mainCategory", service.mainCategory());
		//3)2차카테고리를 참조하는 2차카테고리 정보.
		model.addAttribute("subCategory", service.subCategory(vo.getCate_prtcode()));
		//3)3차카테고리를 참조하는 3차카테고리 정보.
		model.addAttribute("lastsubCategory", service.lastsubCategory(vo.getCate_prtcode(), vo.getCate_subprtcode()));
				
	}
	
	//상품수정 저장(폼에서 상품정보, 페이징정보(검색포함) 전송)
	@PostMapping("/productModify")
	public String product_modify(Criteria cri, ProductVO vo, RedirectAttributes rttr) {
		
		//상품이미지 변경을 할 경우는 기존이미지는 삭제한다.
		//상품이미지 변경을 하지 않은 경우는 기존이미지명을 그대로 수정처리한다.
		
		//1)이미지가 변경된 경우
		if(vo.getUpload().getSize() > 0) {
			
			//1)기존이미지정보 파일삭제
			UploadFileUtils.deleteFile(uploadFolder, vo.getPro_uploadpath(), vo.getPro_img());
			//2)변경이미지 업로드작업
			vo.setPro_img(UploadFileUtils.uploadFile(uploadFolder, vo.getUpload()));
			vo.setPro_uploadpath(UploadFileUtils.getFolder()); // 날짜폴더명
		}
		
		service.product_modifyOk(vo);
		
		rttr.addFlashAttribute("msg", "modifyOk"); // jsp에서 참조.
		
		rttr.addAttribute("pageNum", cri.getPageNum()); // 주소에서 호출되는 메서드 파라미터 참조.
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/product/productList";
	}
	
	//상품리스트의 이미지출력(썸네일)
	@ResponseBody
	@GetMapping("/displayFile")  // 클라이언트에서 보내는 특수문자중에 역슬래시 데이타를 스프링에서 지원하지 않는다. 
	public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName) {
		
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFileUtils.getFileByte(uploadFolder, uploadPath, fileName );
		
		return entity;
	}
		
	//상품선택삭제(ajax호출).pro_uploadpathArr   400에러발생되면. 클라이언트에서 보낸 데이타를 스프링에서 받지 못하는 상태. (중요)ajax로 사용시 파라미터를 [] 로 사용해야 한다.
	@ResponseBody  
	@PostMapping("/checkDelete")
	public ResponseEntity<String> checkDelete(
				@RequestParam("pro_numArr[]") List<Integer> pro_numArr, 
				@RequestParam("pro_imgArr[]") List<String> pro_imgArr,
				@RequestParam("pro_uploadpathArr[]") List<String> pro_uploadpathArr){
		
		ResponseEntity<String> entity = null;
		
		try {
			for(int i=0; i<pro_numArr.size(); i++) {
				//상품이미지 삭제
				UploadFileUtils.deleteFile(uploadFolder, pro_uploadpathArr.get(i), pro_imgArr.get(i));
				
				//상품테이블 삭제작업
				service.product_delete(pro_numArr.get(i));
				
			}
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//상품개별삭제
	@PostMapping("/productDelete")
	public String productDelete(Criteria cri, @RequestParam("pro_num") Integer pro_num, RedirectAttributes rttr ) {
		
		System.out.println("상품삭제: " + cri);
		System.out.println("상품코드: " + pro_num);
		
		service.product_delete(pro_num);
		
		rttr.addFlashAttribute("msg", "deleteOk"); // jsp에서 참조.
		
		rttr.addAttribute("pageNum", cri.getPageNum()); // 주소에서 호출되는 메서드 파라미터 참조.
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/product/productList";
	}

}

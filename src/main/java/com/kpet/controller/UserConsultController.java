package com.kpet.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.kpet.domain.AnswerVO;
import com.kpet.domain.ConsultVO;
import com.kpet.domain.Criteria;
import com.kpet.domain.PageDTO;
import com.kpet.domain.UserVO;
import com.kpet.service.AdminConsultService;
import com.kpet.service.UserConsultService;
import com.kpet.util.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/consult/*")
@Controller
public class UserConsultController {

	@Inject
	private UserConsultService service;

	@Inject
	private AdminConsultService adService;

	//문의 상담 이미지 업로드 폴더
	@Resource(name = "cstUploadFolder")
	String cstUploadFolder;

	//CKEditor 이미지 업로드 폴더
	@Resource(name= "ckUploadFolder")
	String ckUploadFolder;

	// 문의 상담페이지
	@GetMapping("/cstList")
	public void consult(HttpSession session, @ModelAttribute("cri") Criteria cri, Model model) {

		String user_id = ((UserVO) session.getAttribute("loginStatus")).getUser_id();

		log.info("파라미터: " + user_id);

		List<ConsultVO> consult = service.getConSultPaging(cri,user_id);

		log.info("ConsultVO 파라미터: " + consult);

		int total = service.getTotalCount(cri,user_id);

		model.addAttribute("conSultList", consult);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	// 문의 상담글쓰기 페이지
	@GetMapping("/cstWrite")
	public void cstWrite() {

	}

	// 문의게시판 글 등록 저장
	@PostMapping("/writeInsert")
	public String writeInsert(ConsultVO vo, HttpSession session, RedirectAttributes rttr) {

		vo.setUser_id(((UserVO) session.getAttribute("loginStatus")).getUser_id());

		log.info("상품정보" + vo);
		MultipartFile uploadFile = vo.getCst_upload();
		if (uploadFile != null && !uploadFile.isEmpty()) {
			//1)파일업로드. 파일이름을 추출하여 저장
			vo.setCst_img(UploadFileUtils.uploadFile(cstUploadFolder, vo.getCst_upload()));
			vo.setCst_uploadpath(UploadFileUtils.getFolder()); // 날짜폴더명
			log.info("상품정보2" + vo);
		} else {
			vo.setCst_img("");
			vo.setCst_uploadpath("");
		}
		//2)상품정보 저장
		service.writeIsnert(vo);

		rttr.addFlashAttribute("msg", "insertOk");

		return "redirect:/consult/cstList";
	}

	//문의게시판 게시글 보기 페이지 
	//문의게시판 게시글 수정 페이지
	@GetMapping(value= {"/cstRead", "/cstModify"})
	//@GetMapping("cstRead")
	public void cstRead(Integer cst_num, @ModelAttribute("cri")Criteria cri, Model model) {

		ConsultVO vo = service.getConSult(cst_num);
		AnswerVO cstWrite = adService.getCstWrite(cst_num);

		log.info("리스에서 오는 데이터vo: " + vo);
		log.info("엔서에서 오는 데이터cstWrite: " + cstWrite);
		if(vo.getCst_uploadpath() != null) {
			vo.setCst_uploadpath(vo.getCst_uploadpath().replace("\\", "/"));
		}
		model.addAttribute("cstInner", vo);
		model.addAttribute("cstWrite", cstWrite);
	}

	//문의게시판의 첨부이미지출력(썸네일)
	@ResponseBody
	@GetMapping("/displayFile")  // 클라이언트에서 보내는 특수문자중에 역슬래시 데이타를 스프링에서 지원하지 않는다. 
	public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName) {

		ResponseEntity<byte[]> entity = null;

		entity = UploadFileUtils.getFileByte(cstUploadFolder, uploadPath, fileName );

		return entity;
	}

	//문의게시판 게시글 수정
	@PostMapping("/cstModify")
	public String cstModify(ConsultVO vo, HttpSession session) {

		vo.setUser_id(((UserVO) session.getAttribute("loginStatus")).getUser_id());

		//1)이미지가 변경된 경우
		if(vo.getCst_upload().getSize() > 0) {

			//1)기존이미지정보 파일삭제
			UploadFileUtils.deleteFile(cstUploadFolder, vo.getCst_uploadpath(), vo.getCst_img());
			//2)변경이미지 업로드작업
			vo.setCst_img(UploadFileUtils.uploadFile(cstUploadFolder, vo.getCst_upload()));
			vo.setCst_uploadpath(UploadFileUtils.getFolder()); // 날짜폴더명
		}

		log.info("수정vo : " + vo);
		service.cstModify(vo);

		return "redirect:/consult/cstList";
	}

	//문의게시판 게시글 삭제 코드수정 파일 삭제
	@GetMapping("/cstRemove")
	public String cstRemove(@RequestParam("cst_num") Integer cst_num, Model model) {

		//파일 정보 가져오기
		ConsultVO vo = service.getConSult(cst_num);

		//게시글 삭제
		service.cstRemove(cst_num);

		//파일 삭제
		if(vo.getCst_img() != null) {UploadFileUtils.deleteFile(cstUploadFolder,vo.getCst_uploadpath(),vo.getCst_img());
		}

		return "redirect:/consult/cstList";
	}

	//CKEditor 문의게시판 설명 이미지.
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

			// 클라이언트에서 전송해 온 파일명을 포함하여, 실제 업로드되는 경로생성
			//String uploadPath = request.getSession().getServletContext().getRealPath("/resources/cst_upload/") + fileName;

			//물리적 경로
			String uploadPath = ckUploadFolder + "\\WEB-INF\\views\\consult\\upload\\" + fileName;  

			log.info("업로드폴더 물리적경로: " + uploadPath);

			out = new FileOutputStream(new File(uploadPath)); // 0byte의 빈 파일생성

			// 파일에 내용이 채워짐.
			out.write(bytes);
			out.flush();

			/*======================================================================*/

			String callback = request.getParameter("CKEditorFuncNum");

			log.info(callback);

			printWriter = response.getWriter();

			// <resources mapping="/cst_upload/**" location="/resources/cst_upload/" />
			String fileUrl = "/cst_upload/" + fileName;

			printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction("
					+ callback
					+ ",'"
					+ fileUrl
					+ "','이미지를 업로드 하였습니다.'"
					+ ")</script>");
			printWriter.flush();

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
}
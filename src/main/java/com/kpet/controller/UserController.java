package com.kpet.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
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
import com.kpet.domain.EmailDTO;
import com.kpet.domain.PageDTO;
import com.kpet.domain.UserVO;
import com.kpet.service.AdminCustomerService;
import com.kpet.service.UserService;
import com.kpet.util.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/user/*")
@Controller
public class UserController {

	@Inject
	private PasswordEncoder cryptPassEnc;  // 스프링시큐리티에서 제공하는 암호화클래스
	
	@Inject
	private UserService service;
	
	@Inject
	private JavaMailSender mailSender;
	
	@Inject
	private AdminCustomerService adService;
	
	@Resource(name = "cstUploadFolder")
	String cstUploadFolder; // d:\\dev\\userupload */
	
	// 주요기능 : 회원기능
	
	
	//회원가입 폼 : /user/join -> jsp파일명
	@GetMapping("/join")
	public void join() {
		
	}
	
	//회원가입저장  /user/join
	@PostMapping("/join")
	public String joinOk(UserVO vo, RedirectAttributes rttr) throws Exception{
		
		// 비밀번호(평문) -> 암호화비밀번호
		// 비밀번호 암호화. (스프링 시큐리티 기능)
		
		vo.setUser_pw(cryptPassEnc.encode(vo.getUser_pw()));
		
		
		// StringUtils.isEmpty(매개변수) : 매개변수의 값이 널 또는 빈문자열일 경우를 확인하는 기능. 
		vo.setUser_emailrec(!StringUtils.isEmpty(vo.getUser_emailrec()) ? "Y" : "N");
		
		log.info("UserVO: " + vo);
		
		service.join(vo);

		return "redirect:/user/login";
	}
	
	
	//아이디중복체크
	@ResponseBody
	@GetMapping("/checkID")
	public ResponseEntity<String> checkID(@RequestParam("user_id") String user_id) throws Exception{
		
		
		String result = "";
		ResponseEntity<String> entity = null;
		
		result = StringUtils.isEmpty(service.checkID(user_id)) ? "Y" : "N";
		
		entity = new ResponseEntity<String>(result, HttpStatus.OK);
		
		return entity;
		
	}
	
	//메일인증요청
	@ResponseBody
	@GetMapping("/sendMailAuth")
	public ResponseEntity<String> sendMailAuth(@RequestParam("user_email") String user_email, HttpSession session) {
		
		ResponseEntity<String> entity = null;
		
		String authCode = makeAuthCode();
		// 인증코드를 세션에 임시적으로 저장
		session.setAttribute("authCode", authCode);
		
		EmailDTO dto = new EmailDTO("kpet", "linker0091@gmail.com", user_email, "kpet 인증메일", authCode);
		
		//메일내용을 구성하는 클래스
		MimeMessage message = mailSender.createMimeMessage();
		
		
		try {
			//받는 사람 메일설정
			message.addRecipient(RecipientType.TO, new InternetAddress(user_email));
			//보내는 사람설정(이메일, 이름)
			message.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
			//제목
			message.setSubject(dto.getSubject(), "utf-8");
			//본문내용(인증코드)
			message.setText(dto.getMessage(), "utf-8");
			
			mailSender.send(message);
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	//메일인증요청확인
	@ResponseBody
	@GetMapping("/mailAuthConfirm")
	public ResponseEntity<String> MailAuthConfirm(@RequestParam("uAuthCode") String uAuthCode, HttpSession session) {
		
		ResponseEntity<String> entity = null;
		
		String authCode = (String) session.getAttribute("authCode");
		
		if(authCode.equals(uAuthCode)) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}

		return entity;
	}
	
	
	
	
	// 회원가입시 메일인증코드 생성. 임시비밀번호 용도로 같이사용.
	private String makeAuthCode() {
		
		String authCode = "";
		
		for(int i=0; i<6; i++) {
			authCode += String.valueOf((int) (Math.random() * 9) + 1);
		}
		
		
		return authCode;
	}

	//회원수정 폼 : 로그인한 사용자의 정보를 폼에 표시.
	//마이페이지 : 같이 사용.
	@GetMapping(value = {"/modify", "/mypage"})
	public void modify(HttpSession session, Model model) {
		
		log.info("s");
		UserVO vo = (UserVO) session.getAttribute("loginStatus");
		
		String user_id = vo.getUser_id();
		
		// 로그인, 회원수정 동일하게 사용
		/*
		UserVO db_vo = service.login(user_id);
		model.addAttribute("UserVO", db_vo);
		*/
		
		model.addAttribute(service.login(user_id));
		
	}
	
	
	//회원수정저장
	@PostMapping("/modify")
	public String modify(UserVO vo,  HttpSession session, RedirectAttributes rttr) {
		
		/*
		 StringUtils.isEmpty(vo.getUser_emailrec())
		 
		 체크를 하면 널이 아닌상태
		체크를 안하면 널인 상태
		 * 
		 * 
		 */
		
		String redirectURL = "";
		
		
		vo.setUser_emailrec(!StringUtils.isEmpty(vo.getUser_emailrec()) ? "Y" : "N");
		
		log.info("회원수정정보: " + vo);
		
		
		UserVO session_vo = (UserVO) session.getAttribute("loginStatus");
		
		if(cryptPassEnc.matches(vo.getUser_pw(), session_vo.getUser_pw())) {
			
			service.modify(vo);
						
			redirectURL = "/";
			rttr.addFlashAttribute("msg", "modifyOk"); // "/" 주의 index.jsp에서 msg를 참조해서 사용
			
		
		}else {
			redirectURL = "/user/modify";
			rttr.addFlashAttribute("msg", "modifyFail"); // "modify.jsp"에서 msg를 참조해서 사용
		}
		
		
		return "redirect:" + redirectURL;
		
	}
	
	
	
	//회원삭제
	@ResponseBody
	@PostMapping("/regDelete")
	public ResponseEntity<String> regDelete(@RequestParam("user_pw") String user_pw, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		
		UserVO vo = (UserVO) session.getAttribute("loginStatus");
		
		String user_id = vo.getUser_id();
		
		//String.valueOf() Object값을 String으로 변환.
		entity = new ResponseEntity<String>(String.valueOf(service.regDelete(user_id, cryptPassEnc, user_pw)), HttpStatus.OK);
		
		session.invalidate();
		
		return entity;
	}
	
	
	
	
	//로그인폼  /user/login
	@GetMapping("/login")
	public void login() {
		
	}
	
	//로그인
	/*
	@ResponseBody
	@PostMapping("/login")
	public ResponseEntity<String> login(@RequestParam("user_id") String user_id, @RequestParam("user_pw") String user_pw, HttpSession session)throws Exception{
		
		String result = "";
		ResponseEntity<String> entity = null;
		
		
		UserVO vo = service.login(user_id);
		
		if(vo == null) { // id가 존재안하는 의미
			result = "idFail";
		}else {	// id가 존재하는 의미.
			
			if(cryptPassEnc.matches(user_pw, vo.getUser_pw())) {
				result = "success";
				
				session.setAttribute("loginStatus", vo); // 로그인 성공 상태정보를 세션으로 저장
				
			}else {
				result = "pwFail";
			}
		}
		
		//log.info("id: " + user_id);
		//log.info("pw: " + user_pw);
	
		entity = new ResponseEntity<String>(result, HttpStatus.OK);
		
		return entity;
		
	}*/
	
	//로그인 2
	@PostMapping("/login")
	public String login(@RequestParam("user_id") String user_id, @RequestParam("user_pw") String user_pw, HttpSession session, RedirectAttributes rttr)throws Exception{
		
		String url ="";
		UserVO vo = service.login(user_id);
		
		if(vo == null) { // id가 존재안하는 의미
			rttr.addFlashAttribute("result", "idFail");
			rttr.addFlashAttribute("usertxt", user_id);
			url = "/user/login";
		}else {	// id가 존재하는 의미.
			
			if(cryptPassEnc.matches(user_pw, vo.getUser_pw())) {
				rttr.addFlashAttribute("result", "success");
				
				session.setAttribute("loginStatus", vo); // 로그인 성공 상태정보를 세션으로 저장
				
				String destination = (String) session.getAttribute("dest");
				url = destination != null ? (String) destination : "/";
			}else {
				rttr.addFlashAttribute("result", "pwFail");
				rttr.addFlashAttribute("usertxt", user_id);
				url = "/user/login";
			}
		}
		
		return "redirect:" + url;
		
	}
	
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	//비밀번호 찾기 폼
	@GetMapping("/searchPw")
	public void searchPwReq() {
	
		
		
	}
	
	//비밀번호 찾기 기능
	@ResponseBody
	@PostMapping("/searchPw")
	public ResponseEntity<String> searchPwAction(@RequestParam("user_email") String user_email) {
	
		/*
		1)email 주소가 가입된 것인지에 따른 회원가입여부체크
		  - 존재 : 비밀번호를 랜덤으로 생성하여, 메일발송
		  - 존재안함 : 메세지준다.(가입된 메일주소가 다르거나 미가입된 회원입니다.)
		*/
				
		ResponseEntity<String> entity = null;
		
		//비밀번호 랜덤생성,메일발송
		if(!StringUtils.isEmpty(service.searchPwByEmail(user_email))) {
			
			String tempPw = makeAuthCode();
			
			EmailDTO dto = new EmailDTO("kpet", "linker0091@gmail.com", user_email, "kpet 인증메일", tempPw);
			
			//메일내용을 구성하는 클래스
			MimeMessage message = mailSender.createMimeMessage();
			
			
			try {
				//받는 사람 메일설정
				message.addRecipient(RecipientType.TO, new InternetAddress(user_email));
				//보내는 사람설정(이메일, 이름)
				message.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
				//제목
				message.setSubject(dto.getSubject(), "utf-8");
				//본문내용(인증코드)
				message.setText(dto.getMessage(), "utf-8");
				
				mailSender.send(message);
				
				
				// 임시비밀번호를 암호화처리하여, 디비에 저장해야 함..
				
				String encryptPw = cryptPassEnc.encode(tempPw);
				service.changePw(user_email, encryptPw);
				
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
				
			}catch(Exception e) {
				
				e.printStackTrace();
				
				entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
			}
			
		}else { // 이메일이 존재하지 않은 경우
			
			entity = new ResponseEntity<String>("noMail", HttpStatus.OK);
		}
		
		return entity;
		
		
	}
	
	//비밀번호 변경하기
	@ResponseBody
	@PostMapping("/changePw")
	public ResponseEntity<String> changePw(@RequestParam("cur_user_pw") String cur_user_pw, @RequestParam("change_user_pw") String change_user_pw, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		
		UserVO vo = (UserVO) session.getAttribute("loginStatus");
		
		String user_id = vo.getUser_id();
		
		
		log.info("파라미터: " + user_id);
		log.info("파라미터: " + cur_user_pw);
		log.info("파라미터: " + change_user_pw);
		
		
		//String result = service.currentPwConfirm(user_id, cryptPassEnc.encode(cur_user_pw), cryptPassEnc.encode(change_user_pw));
		
		
		String result = service.currentPwConfirm(user_id, cryptPassEnc, cur_user_pw, cryptPassEnc.encode(change_user_pw));
		
		entity = new ResponseEntity<String>(result, HttpStatus.OK);
		
		
		return entity;
	}
	
	
	
	
	//마이페이지
	/*
	@GetMapping("/mypage")
	public void mypage() {
		
	}
	*/
	
	
	//아이디 찾기
	@ResponseBody
	@PostMapping("/searchId")
	public ResponseEntity<String> searchIdAction(@RequestParam("user_email") String user_email) {
	
		ResponseEntity<String> entity = null;
		
		String user_id = service.searchIdByEmail(user_email);
		
		//비밀번호 랜덤생성,메일발송
		if(!StringUtils.isEmpty(user_id)) {
			
			EmailDTO dto = new EmailDTO("kpet", "linker0091@gmail.com", user_email, "kpet 인증메일", user_id);
			
			//메일내용을 구성하는 클래스
			MimeMessage message = mailSender.createMimeMessage();
			
			
			try {
				//받는 사람 메일설정
				message.addRecipient(RecipientType.TO, new InternetAddress(user_email));
				//보내는 사람설정(이메일, 이름)
				message.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
				//제목
				message.setSubject(dto.getSubject(), "utf-8");
				//본문내용(인증코드)
				message.setText(dto.getMessage(), "utf-8");
				
				mailSender.send(message);
				
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
				
			}catch(Exception e) {
				
				e.printStackTrace();
				
				entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
			}
			
		}else { // 이메일이 존재하지 않은 경우
			
			entity = new ResponseEntity<String>("noMail", HttpStatus.OK);
		}
		
		
		return entity;
	}
	
	// 상담페이지
	@GetMapping("/consult")
	public void consult(HttpSession session, @ModelAttribute("cri") Criteria cri, Model model) {
		UserVO vo = (UserVO) session.getAttribute("loginStatus");
		String user_id = vo.getUser_id();
		log.info("파라미터: " + user_id);
		//List<ConsultVO> consult = service.conSultList(user_id);
		List<ConsultVO> consult = service.getConSultPaging(cri,user_id);
		log.info("ConsultVO 파라미터: " + consult);
		int total = service.getTotalCount(cri,user_id);
		
		model.addAttribute("conSultList", consult);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 상담글쓰기 페이지
	@GetMapping("/cstWrite")
	public void cstWrite(HttpSession session, @ModelAttribute("cri") Criteria cri, Model model) {
		
		UserVO vo = (UserVO) session.getAttribute("loginStatus");
		String user_id = vo.getUser_id();
		model.addAttribute("user_id", user_id);
		
		
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
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/cst_upload/") + fileName;
			
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
	

		// 문의게시판 글 등록 저장 04/06 수정*
		@PostMapping("/writeInsert")
		public String writeInsert(ConsultVO vo, RedirectAttributes rttr) {
			
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
			
			return "redirect:/user/consult";
		}
			
			//문의게시판 게시글 보기 페이지 
			//문의게시판 게시글 수정 페이지
			@GetMapping(value= {"/cstRead", "/cstModify"})
			//@GetMapping("cstRead")
			public void cstRead(Integer cst_num, @ModelAttribute("cri")Criteria cri, Model model) {
				
				ConsultVO vo = service.getConSult(cst_num);
				//log.info("ConsultVO 파라미터: " + vo);
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
			
			return "redirect:/user/consult";
		}

		//문의게시판 게시글 삭제 코드수정 파일 삭제 추가*
		@GetMapping("/cstRemove")
		public String cstRemove(@RequestParam("cst_num") Integer cst_num) {
			
			//파일 정보 가져오기
			ConsultVO vo = service.getConSult(cst_num);
			
			service.cstRemove(cst_num);
			
			//파일 삭제
			UploadFileUtils.deleteFile(cstUploadFolder,vo.getCst_uploadpath(),vo.getCst_img());
			
			return "redirect:/user/consult";
		}
	
}

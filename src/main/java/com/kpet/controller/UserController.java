package com.kpet.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kpet.domain.EmailDTO;
import com.kpet.domain.UserVO;
import com.kpet.service.AdminConsultService;
import com.kpet.service.OrderService;
import com.kpet.service.UserService;

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
	private AdminConsultService adService;
	
	@Inject
	private OrderService ordService;
	
	//문의 상담 CKEditor 이미지 업로드 폴더
	@Resource(name = "cstUploadFolder")
	String cstUploadFolder; // d:\\dev\\userupload */
	
	// 주요기능 : 회원기능
	
	//회원가입 폼
	@GetMapping("/join")
	public void join() {
		
	}
	
	//회원가입저장
	@PostMapping("/join")
	public String joinOk(UserVO vo, RedirectAttributes rttr) throws Exception{
		
		// 비밀번호(평문) -> 암호화비밀번호
		// 비밀번호 암호화. (스프링 시큐리티 기능)
		
		vo.setUser_pw(cryptPassEnc.encode(vo.getUser_pw()));
		
		//메일 수신 여부 체크 확인
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
	@GetMapping(value = {"/modify"})
	public void modify(HttpSession session, Model model) {
		
		log.info("s");
		UserVO vo = (UserVO) session.getAttribute("loginStatus");
		
		String user_id = vo.getUser_id();
		
		model.addAttribute(service.login(user_id));
		
	}
	
	//회원수정저장
	@PostMapping("/modify")
	public String modify(UserVO vo, @RequestParam(name = "user_new_pw", required = false) String user_new_pw, HttpSession session, RedirectAttributes rttr) {
		
		String redirectURL = "";
		
		vo.setUser_emailrec(!StringUtils.isEmpty(vo.getUser_emailrec()) ? "Y" : "N");
		
		log.info("회원수정정보: " + vo);
		log.info("회원수정user_new_pw: " + user_new_pw);
		
		UserVO session_vo = (UserVO) session.getAttribute("loginStatus");
		
		//현재 세션의 비밀번호와 입력된 비밀번호가 같을 경우
		if(cryptPassEnc.matches(vo.getUser_pw(), session_vo.getUser_pw())) {
			
			//새로운 비밀번호가 입력 되었을 시
			if (user_new_pw != null || user_new_pw != "") {
				//새로운 비밀번호 vo에 담기
				vo.setUser_pw(cryptPassEnc.encode(user_new_pw));
				//변경된 정보를 세션으로 저장
				session.setAttribute("loginStatus", vo);	
				log.info("회원수정정보: " + vo);
			}
			//수정된 정보 업데이트
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
	
	//로그인폼
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
				
				Date user_lastlogin = new Date();
				log.info("user_lastlogin: " + user_lastlogin);
				// 마지막 로그인 시간 업데이트
	            service.updateLastlogin(user_lastlogin,user_id); // 사용자 정보 업데이트 메서드 호출
				
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
	@GetMapping("/searchIdPw")
	public void searchPwReq() {
	
	}
	
	//아이디 찾기
	@ResponseBody
	@PostMapping("/searchId")
	public ResponseEntity<String> searchIdAction(@RequestParam("user_email") String user_email) {
	
		/*
		1)email 주소가 가입된 것인지에 따른 회원가입여부체크
		  - 존재 : 비밀번호를 랜덤으로 생성하여, 메일발송
		  - 존재안함 : 메세지준다.(가입된 메일주소가 다르거나 미가입된 회원입니다.)
		*/
				
		ResponseEntity<String> entity = null;
		
		//메일발송
		if(!StringUtils.isEmpty(service.searchPwByEmail(user_email))) {
			
			String user_id = service.searchIdByEmail(user_email);
			String msg = "회원님의 아이디는 [ " + user_id + " ] 입니다.";
			
			//메일 구성 정보
			EmailDTO dto = new EmailDTO("kpet", "linker0091@gmail.com", user_email, "kpet 인증메일", msg);
			
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
	
	//비밀번호 찾기 기능
	@ResponseBody
	@PostMapping("searchPw")
	public ResponseEntity<String> searchPwAction(@RequestParam("user_email") String user_email) {
	
		/*
		1)email 주소가 가입된 것인지에 따른 회원가입여부체크
		  - 존재 : 비밀번호를 랜덤으로 생성하여, 메일발송
		  - 존재안함 : 메세지준다.(가입된 메일주소가 다르거나 미가입된 회원입니다.)
		*/
				
		ResponseEntity<String> entity = null;
		
		//비밀번호 랜덤생성,메일발송
		if(!StringUtils.isEmpty(service.searchPwByEmail(user_email))) {
			
			String tempPw = makeAuthCode();//랜덤번호 생성
			String msg = "회원님의 임시 비밀번호는 [ " + tempPw + " ] 입니다.";

			//메일 구성 정보
			EmailDTO dto = new EmailDTO("kpet", "linker0091@gmail.com", user_email, "kpet 인증메일", msg);
			
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
				
				// 임시비밀번호를 암호화처리하여, 디비에 저장해야 함.
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
	
	
	//마이페이지
	@GetMapping("/mypage")
	public void mypage(Model model,HttpSession session) {
			
	UserVO vo = (UserVO) session.getAttribute("loginStatus");

	String user_id = vo.getUser_id();
	
	// 현재 날짜 구하기
	LocalDate currentDate = LocalDate.now();

	// 3개월 이전의 날짜 구하기
	LocalDate threeMonthsAgo = currentDate.minusMonths(3);

	// 날짜 형식 지정 (SQL 날짜 형식에 맞게 설정)
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	// 변수에 담기
	String threeMonthsDate = threeMonthsAgo.format(formatter);
	
	model.addAttribute("user_name",  vo.getUser_name());
	
	//주문 상태별 건수
	model.addAttribute("ordReceived",  ordService.ordStateCount(user_id,"주문접수",threeMonthsDate)); //주문접수
	model.addAttribute("ordPaid",  ordService.ordStateCount(user_id,"결제완료",threeMonthsDate)); //결제완료
	model.addAttribute("ordPreparing",  ordService.ordStateCount(user_id,"배송준비중",threeMonthsDate)); //배송준비중
	model.addAttribute("ordShipping",  ordService.ordStateCount(user_id,"배송중",threeMonthsDate)); //배송중
	model.addAttribute("ordDelivered",  ordService.ordStateCount(user_id,"배송완료",threeMonthsDate)); //배송완료
	model.addAttribute("ordCancel",  ordService.ordStateCount(user_id,"취소요청",threeMonthsDate)); //취소요청
	model.addAttribute("ordExchange",  ordService.ordStateCount(user_id,"교환요청",threeMonthsDate)); //교환요청
	model.addAttribute("ordReturn",  ordService.ordStateCount(user_id,"반품요청",threeMonthsDate)); //반품요청
	
	}
	
	
}
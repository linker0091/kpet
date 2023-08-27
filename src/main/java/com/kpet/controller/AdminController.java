package com.kpet.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

import com.kpet.domain.AdminVO;
import com.kpet.service.AdminService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor  // 모든필드를 파라미터로 하는 생성자메서드.  내부적으로 자동주입발생이 되어 어노테이션을 작업을 안한다.
@RequestMapping("/admin/*")
@Controller
public class AdminController {

	private AdminService service;
	
	private PasswordEncoder cryptPassEnc;  // 스프링시큐리티에서 제공하는 암호화클래스
	
	//관리자 로그인 폼
	@GetMapping("/logon")
	public void adLoginForm() {
		
	}
	
/*	
	// 관리자 로그인 인증
	@PostMapping("/logon")
	public String adLoginOk(String ad_id, String ad_pw, HttpSession session, RedirectAttributes rttr) {
		
		
		
		log.info("관리자 아이디: " + ad_id);
		log.info("관리자 비번: " + ad_pw);
		
		String redirectUrl = "";
		
		AdminVO vo = service.adminLogin(ad_id);
		log.info("관리자 vo: " + vo);
		//아이디가 존재한다면
		if(!StringUtils.isEmpty(vo)) {
			
			// 비밀번호가 일치한다면(즉 인증성공)
			if(cryptPassEnc.matches(ad_pw, vo.getAd_pw())) {
			
				session.setAttribute("adminStatus", vo);
				redirectUrl = "/admin/main";
			}else {	// 비밀번호가 틀린 경우
				redirectUrl = "/admin/logon";
				rttr.addFlashAttribute("msg", "failPw");
			}
			
		}else {		// 아이디가 틀린 경우
			redirectUrl = "/admin/logon";
			rttr.addFlashAttribute("msg", "failId");
		}
		
		return "redirect:" + redirectUrl;
	}
*/
	// 관리자 로그인 인증
	@PostMapping("/logon")
	public String adLoginOk(String ad_id, String ad_pw, HttpSession session, RedirectAttributes rttr) {
		
		log.info("관리자 아이디: " + ad_id);
		log.info("관리자 비번: " + ad_pw);
		
		String redirectUrl = "";
		AdminVO vo = service.adminLogin(ad_id);
		
		log.info("관리자 vo: " + vo);
		
		//아이디가 존재한다면
		if(!StringUtils.isEmpty(vo)) {
			
			// 비밀번호가 일치한다면(즉 인증성공)
			if(cryptPassEnc.matches(ad_pw, vo.getAd_pw())) {
			
				session.setAttribute("adminStatus", vo);
				
				//로그인 시간 구하기
				Date ad_lastlogin = new Date();
				log.info("user_lastlogin: " + ad_lastlogin);
				// 마지막 로그인 시간 업데이트
	            service.updateLastlogin(ad_lastlogin,ad_id);
				
				redirectUrl = "/admin/main";
				
			}else {	// 비밀번호가 틀린 경우
				redirectUrl = "/admin/logon";
				rttr.addFlashAttribute("msg", "failPw");
			}
			
		}else {		// 아이디가 틀린 경우
			redirectUrl = "/admin/logon";
			rttr.addFlashAttribute("msg", "failId");
		}
		
		return "redirect:" + redirectUrl;
	}	
	
	//관리자 로그온 후에 보여줄 메뉴페이지
	@GetMapping("/main")
	public void main() {
		
	}
	
	//관리자회원 추가 폼
	@GetMapping("/adRegister")
	public void adminRegister() {
		
	}
	
	//관리자회원 저장
	@PostMapping("/adRegister")
	public String adminRegister(AdminVO vo, RedirectAttributes rttr) {
		
		//비밀번호 암호화
		vo.setAd_pw(cryptPassEnc.encode(vo.getAd_pw()));
		
		int result = service.adminRegister(vo);
		
		//insert 성공시
		if(result == 1) {
			rttr.addFlashAttribute("msg", "success");
		}else {
			rttr.addFlashAttribute("msg", "fail");
		}
		
		return "redirect:/admin/adRegister";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		//세션 삭제
		session.invalidate();
		
		return "redirect:/admin/logon";
	}
	
	//관리자 관리 페이지
	@GetMapping("/adManagement")
	public void adManagement(Model model) {
		
		List<AdminVO> AdminList = service.getAdminList();
		
		//관리자 인원수
		int admin_Total = service.getAdminTotalCount();
		
		model.addAttribute("admin_total", admin_Total);
		model.addAttribute("AdminList", AdminList);
	}
	
	// 관리자삭제
	@ResponseBody
	//@GetMapping("/checkDelete")
	@PostMapping("/checkDelete")
	//@RequestMapping(value = "/checkDelete", method = {RequestMethod.GET, RequestMethod.POST}  ) 둘다 지원
	public ResponseEntity<String> checkDelete(@RequestParam("ad_idArr[]") List<String> ad_idArr){
		
		ResponseEntity<String> entity = null;
		
		try {
			//체크 목록 관리자테이블 삭제작업
			for(int i=0; i<ad_idArr.size(); i++) {
								
				service.adDelete(ad_idArr.get(i));
				
			}
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}	
	
	//관리자 직책일괄변경, 개별관리자 직책변경
	@ResponseBody  
	@PostMapping("/AdPositionModify")
	public ResponseEntity<String> AdPositionModify(
				@RequestParam("ad_idArr[]") List<String> ad_idArr, 
				@RequestParam("ad_positionArr[]") List<String> ad_positionArr) {
		
		ResponseEntity<String> entity = null;
		
		log.info(ad_idArr);
		log.info(ad_positionArr);
		
		try {
			//체크 목록 관리자 직책 변경
			for(int i=0; i < ad_idArr.size(); i++) {
				
				service.adPosition_modify(ad_idArr.get(i), ad_positionArr.get(i));
			}

			entity = new ResponseEntity<String>("success", HttpStatus.OK);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	
}

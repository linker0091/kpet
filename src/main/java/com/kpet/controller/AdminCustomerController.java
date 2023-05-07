package com.kpet.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kpet.domain.AnswerVO;
import com.kpet.domain.ConsultVO;
import com.kpet.service.AdminCustomerService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor  // 모든필드를 파라미터로 하는 생성자메서드.  내부적으로 자동주입발생이 되어 어노테이션을 작업을 안한다.
@RequestMapping("/admin/customer/*")
@Controller
public class AdminCustomerController {

	@Inject
	private AdminCustomerService service;
	
	@GetMapping("/consult")
	public void consult(@RequestParam(value="cst_answer", required = false) String cst_answer, Model model) {
		if(cst_answer == null) {
			cst_answer = "N";
		}
		log.info("답변상태" + cst_answer);
		List<ConsultVO> consultList = service.adminConSultList(cst_answer);
		
		model.addAttribute("cst_answer_n",  service.getConsultAnswerCount("N")); //상담처리중
		model.addAttribute("cst_answer_y", service.getConsultAnswerCount("Y")); //상담완료
		model.addAttribute("conSultList", consultList);
	}
	
	//문의게시판 게시글 보기 페이지 
	@GetMapping("cstRead")
	public void cstRead(Integer cst_num, Model model) {
		
		ConsultVO vo = service.admingetConSult(cst_num);
		//log.info("ConsultVO 파라미터: " + vo);
		
		AnswerVO cstWrite = service.getCstWrite(cst_num);

		model.addAttribute("cstInner", vo);
		
		model.addAttribute("cstWrite", cstWrite);
		log.info("나가는 cstWrite: " + cstWrite);
	}
	
	// 문의게시판 글 답변 등록 저장
	@PostMapping("/writeAnswer")
	public String writeInsert(AnswerVO vo, Integer cst_num, RedirectAttributes rttr) {
		log.info("답변글 등록:" + vo);
		service.writeAnswer(vo, cst_num);		
		
		rttr.addFlashAttribute("msg", "insertOk");
		
		return "redirect:/admin/customer/consult";
	}
}

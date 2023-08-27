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
import com.kpet.service.AdminConsultService;
import com.kpet.service.UserConsultService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/admin/consult/*")
@Controller
public class AdminConsultController {

	@Inject
	private AdminConsultService service;
	
	@Inject
	private UserConsultService usService;
	
	//문의게시판 목록
	@GetMapping("/cstList")
	public void consult(@RequestParam(value="cst_answer", defaultValue ="N") String cst_answer, Model model) {
	
		log.info("답변상태" + cst_answer);
		
		List<ConsultVO> consultList = usService.adminConSultList(cst_answer);
		
		model.addAttribute("cst_answer_n",  usService.getConsultAnswerCount("N")); //상담처리중
		model.addAttribute("cst_answer_y", usService.getConsultAnswerCount("Y")); //상담완료
		model.addAttribute("conSultList", consultList);
	}
	
	//문의게시판 게시글 보기 페이지 
	@GetMapping("cstRead")
	public void cstRead(Integer cst_num, Model model) {
		
		ConsultVO vo = usService.getConSult(cst_num);
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
		
		return "redirect:/admin/consult/cstList";
	}
}

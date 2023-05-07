package com.kpet.service;

import java.util.List;

import com.kpet.domain.AnswerVO;
import com.kpet.domain.ConsultVO;

public interface AdminCustomerService {
	public List<ConsultVO> adminConSultList(String cst_answer);
	
	public ConsultVO admingetConSult(Integer cst_num);
	
	public void writeAnswer(AnswerVO vo, Integer cst_num);
	
	public AnswerVO getCstWrite(Integer cst_num);
	
	public int getConsultAnswerCount(String cst_answer);
	
}

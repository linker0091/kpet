package com.kpet.mapper;

import java.util.List;

import com.kpet.domain.AnswerVO;
import com.kpet.domain.ConsultVO;

public interface AdminCustomerMapper {
	public List<ConsultVO> adminConSultList(String cst_answer);
	
	public ConsultVO admingetConSult(Integer cst_num);
	
	public void writeAnswer(AnswerVO vo);
	
	public AnswerVO getCstWrite(Integer cst_num);
	
	public int getConsultAnswerCount(String cst_answer);
}

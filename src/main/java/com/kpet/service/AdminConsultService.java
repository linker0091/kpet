package com.kpet.service;

import com.kpet.domain.AnswerVO;

public interface AdminConsultService {
	
	public void writeAnswer(AnswerVO vo, Integer cst_num);
	
	public AnswerVO getCstWrite(Integer cst_num);
	
}

package com.kpet.mapper;

import com.kpet.domain.AnswerVO;

public interface AdminConsultMapper {
		
	public void writeAnswer(AnswerVO vo);
	
	public AnswerVO getCstWrite(Integer cst_num);
	
	public void ansRemove(Integer cst_num);
}

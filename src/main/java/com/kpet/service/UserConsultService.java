package com.kpet.service;

import java.util.List;

import com.kpet.domain.ConsultVO;
import com.kpet.domain.Criteria;

public interface UserConsultService {

	public List<ConsultVO> adminConSultList(String cst_answer);
	
	public int getConsultAnswerCount(String cst_answer);
	
	public void writeIsnert(ConsultVO vo);
	
	public ConsultVO getConSult(Integer cst_num);
		
	public void cstModify(ConsultVO vo);
	
	public void cstRemove(Integer cst_num);
	
	public List<ConsultVO> getConSultPaging(Criteria cri, String user_id);
	
	public int getTotalCount(Criteria cri, String user_id);
	
}

package com.kpet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpet.domain.AnswerVO;
import com.kpet.domain.ConsultVO;
import com.kpet.mapper.AdminConsultMapper;
import com.kpet.mapper.UserConsultMapper;


@Service
public class AdminConsultServiceImpl implements AdminConsultService {

	@Inject
	private AdminConsultMapper mapper;
	
	@Inject
	private UserConsultMapper umapper;
	
	@Override
	public List<ConsultVO> adminConSultList(String cst_answer) {
		// TODO Auto-generated method stub
		return mapper.adminConSultList(cst_answer);
	}

	@Override
	public ConsultVO admingetConSult(Integer cst_num) {
		// TODO Auto-generated method stub
		return mapper.admingetConSult(cst_num);
	}

	@Override
	@Transactional
	public void writeAnswer(AnswerVO vo, Integer cst_num) {
		// TODO Auto-generated method stub
		mapper.writeAnswer(vo);
		//답변 여부 업데이트
		umapper.updateCstAnswer(cst_num);
	}

	@Override
	public AnswerVO getCstWrite(Integer cst_num) {
		// TODO Auto-generated method stub
		return mapper.getCstWrite(cst_num);
	}

	@Override
	public int getConsultAnswerCount(String cst_answer) {
		// TODO Auto-generated method stub
		return mapper.getConsultAnswerCount(cst_answer);
	}

}

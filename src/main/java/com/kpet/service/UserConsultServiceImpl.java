package com.kpet.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpet.domain.ConsultVO;
import com.kpet.domain.Criteria;
import com.kpet.mapper.AdminConsultMapper;
import com.kpet.mapper.UserConsultMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserConsultServiceImpl implements UserConsultService {
	
	@Inject
	private UserConsultMapper mapper;
	
	@Inject
	private AdminConsultMapper adMapper;

	@Override
	public List<ConsultVO> adminConSultList(String cst_answer) {
		// TODO Auto-generated method stub
		return mapper.adminConSultList(cst_answer);
	}
	
	@Override
	public int getConsultAnswerCount(String cst_answer) {
		// TODO Auto-generated method stub
		return mapper.getConsultAnswerCount(cst_answer);
	}
	
	@Override
	public void writeIsnert(ConsultVO vo) {
		// TODO Auto-generated method stub
		mapper.writeIsnert(vo);
	}

	@Override
	public ConsultVO getConSult(Integer cst_num) {
		// TODO Auto-generated method stub
		return mapper.getConSult(cst_num);
	}

	@Override
	public void cstModify(ConsultVO vo) {
		// TODO Auto-generated method stub
		mapper.cstModify(vo);
	}

	@Override
	@Transactional
	public void cstRemove(Integer cst_num) {
		// TODO Auto-generated method stub
		//답변 삭제
		adMapper.ansRemove(cst_num);
		mapper.cstRemove(cst_num);
	}

	@Override
	public List<ConsultVO> getConSultPaging(Criteria cri, String user_id) {
		// TODO Auto-generated method stub
		return mapper.getConSultPaging(cri, user_id);
	}

	@Override
	public int getTotalCount(Criteria cri, String user_id) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri, user_id);
	}
}
package com.kpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.ConsultVO;
import com.kpet.domain.Criteria;

public interface UserConsultMapper {

	public List<ConsultVO> conSultList(String user_id);
	
	public void writeIsnert(ConsultVO vo);
	
	public ConsultVO getConSult(Integer cst_num);
	
	public void updateCstAnswer(Integer cst_num);
	
	public void cstModify(ConsultVO vo);
	
	public void cstRemove(Integer cst_num);
		
	public List<ConsultVO> getConSultPaging(@Param("cri") Criteria cri,@Param("user_id") String user_id);
		
	public int getTotalCount(@Param("cri") Criteria cri,@Param("user_id") String user_id);
	
}

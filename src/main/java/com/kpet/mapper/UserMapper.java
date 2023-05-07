package com.kpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.ConsultVO;
import com.kpet.domain.Criteria;
import com.kpet.domain.UserVO;

public interface UserMapper {

public int join(UserVO vo);
	
	public String checkID(String user_id);
	
	public UserVO login(String user_id);
	
	public int modify(UserVO vo);
	
	public String searchPwByEmail(String user_email);
	
	public String searchIdByEmail(String user_email);
	
	public int changePw(@Param("user_email") String user_email, @Param("user_pw") String user_pw);
	
	public String currentPwConfirm(String user_id);
	
	public int changeNewPw(@Param("user_id") String user_id, @Param("change_user_pw") String change_user_pw);
	
	public int regDelete(String user_id);
	
	public List<ConsultVO> conSultList(String user_id);
	
	public void writeIsnert(ConsultVO vo);
	
	public ConsultVO getConSult(Integer cst_num);
	
	public void updateCstAnswer(Integer cst_num);
	
	public void cstModify(ConsultVO vo);
	
	public void cstRemove(Integer cst_num);
	
	public void ansRemove(Integer cst_num);
	
	public List<ConsultVO> getConSultPaging(@Param("cri") Criteria cri,@Param("user_id") String user_id);
		
	public int getTotalCount(@Param("cri") Criteria cri,@Param("user_id") String user_id);
	
}

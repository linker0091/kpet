package com.kpet.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;

import com.kpet.domain.ConsultVO;
import com.kpet.domain.Criteria;
import com.kpet.domain.UserVO;

public interface UserService {
	
public int join(UserVO vo);
	
	public String checkID(String user_id);
	
	public UserVO login(String user_id);
	
	public int modify(UserVO vo);
	
	public String searchPwByEmail(String user_email);
	
	public String searchIdByEmail(String user_email);
	
	public int changePw(String user_email, String user_pw);
	
	public String currentPwConfirm(String user_id, PasswordEncoder cryptPassEnc, String cur_user_pw, String change_user_pw);
	
	public int regDelete(String user_id, PasswordEncoder cryptPassEncm,String user_pw);
	
	public List<ConsultVO> conSultList(String user_id);
	
	public void writeIsnert(ConsultVO vo);
	
	public ConsultVO getConSult(Integer cst_num);
	
	//public void updateCstAnswer(Integer cst_num);
	
	public void cstModify(ConsultVO vo);
	
	public void cstRemove(Integer cst_num);
	
	public List<ConsultVO> getConSultPaging(Criteria cri, String user_id);
	
	public int getTotalCount(Criteria cri, String user_id);
	
}

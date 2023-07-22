package com.kpet.service;

import java.util.Date;

import org.springframework.security.crypto.password.PasswordEncoder;

import com.kpet.domain.UserVO;

public interface UserService {
	
public int join(UserVO vo);
	
	public String checkID(String user_id);
	
	public UserVO login(String user_id);
	
	public int modify(UserVO vo);
	
	public String searchPwByEmail(String user_email);
	
	public int changePw(String user_email, String user_pw);
	
	public String searchIdByEmail(String user_email);
		
	public String currentPwConfirm(String user_id, PasswordEncoder cryptPassEnc, String cur_user_pw, String change_user_pw);
	
	public int regDelete(String user_id, PasswordEncoder cryptPassEncm,String user_pw);

	public int updateLastlogin(Date user_lastlogin, String user_id);
	
}

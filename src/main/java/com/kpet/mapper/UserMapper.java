package com.kpet.mapper;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.kpet.domain.UserVO;

public interface UserMapper {

public int join(UserVO vo);
	
	public String checkID(String user_id);
	
	public UserVO login(String user_id);
	
	public int modify(UserVO vo);
	
	public String searchPwByEmail(String user_email);
	
	public String searchIdByEmail(String user_email);
	
	public String currentPwConfirm(String user_id);

	public int changePw(@Param("user_email") String user_email, @Param("user_pw") String user_pw);

	public int changeNewPw(@Param("user_id") String user_id, @Param("change_user_pw") String change_user_pw);
	
	public int regDelete(String user_id);

	public int updateLastlogin(@Param("user_lastlogin") Date user_lastlogin, @Param("user_id") String user_id);
	
}

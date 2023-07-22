package com.kpet.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.kpet.domain.UserVO;
import com.kpet.mapper.UserMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserServiceImpl implements UserService {

	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;
	
	@Override
	public int join(UserVO vo) {
		// TODO Auto-generated method stub
		return mapper.join(vo);
	}

	@Override
	public String checkID(String user_id) {
		// TODO Auto-generated method stub
		return mapper.checkID(user_id);
	}

	@Override
	public UserVO login(String user_id) {
		// TODO Auto-generated method stub
		return mapper.login(user_id);
	}

	@Override
	public int modify(UserVO vo) {
		// TODO Auto-generated method stub
		return mapper.modify(vo);
	}

	@Override
	public String searchPwByEmail(String user_email) {
		// TODO Auto-generated method stub
		return mapper.searchPwByEmail(user_email);
	}
	
	@Override
	public int changePw(String user_email, String user_pw) {
		// TODO Auto-generated method stub
		return mapper.changePw(user_email, user_pw);
	}
	
	@Override
	public String currentPwConfirm(String user_id, PasswordEncoder cryptPassEnc, String cur_user_pw, String change_user_pw) {
		// TODO Auto-generated method stub
		
		String result = "noPw";
		
		// 디비의 암호화된 비밀번호가 사용자가 입력한 평문암호(현재비밀번호)로 생성된것인지 여부체크
		if(cryptPassEnc.matches(cur_user_pw, mapper.currentPwConfirm(user_id))){
			mapper.changeNewPw(user_id, change_user_pw);
			result = "success";
		}
		
		return result;
	}

	@Override
	public int regDelete(String user_id, PasswordEncoder cryptPassEnc, String user_pw) {
		
		int count = 0;
		
		if(cryptPassEnc.matches(user_pw, mapper.currentPwConfirm(user_id))){
			count = mapper.regDelete(user_id);
		}
		
		return count;
	}

	@Override
	public String searchIdByEmail(String user_email) {
		// TODO Auto-generated method stub
		return mapper.searchIdByEmail(user_email);
	}

	@Override
	public int updateLastlogin(Date user_lastlogin, String user_id) {
		// TODO Auto-generated method stub
		return mapper.updateLastlogin(user_lastlogin,user_id);
	}

}
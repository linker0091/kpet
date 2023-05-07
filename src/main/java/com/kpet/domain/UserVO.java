package com.kpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {

	// user_id, user_pw, user_name, user_postcode, user_addr, user_deaddr, user_phone, 
	//user_email, user_emailrec, user_regdate, user_updatedate, user_lastlogin
	
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_postcode;
	private String user_addr;
	private String user_deaddr;
	private String user_phone;
	private String user_email;
	private String user_emailrec;
	private Date user_regdate;
	private Date user_updatedate;
	private Date user_lastlogin;
	
	
}

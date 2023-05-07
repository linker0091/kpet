package com.kpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AdminVO {

	// ad_id, ad_pw, ad_name, ad_lastlogin
	private String ad_id;
	private String ad_pw;
	private String ad_name;
	private String ad_position;
	private Date ad_lastlogin;
}

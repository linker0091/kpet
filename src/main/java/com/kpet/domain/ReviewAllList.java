package com.kpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewAllList {

	// rew_num, user_id, rew_content, rew_score, rew_regdate, pro_num, pro_name, pro_img, pro_rewcount, pro_rewrating
	private Integer rew_num;
	private String user_id;
	private Integer ord_code;	
	private String rew_content;
	private int rew_score;
	private String rew_img;		//파일이미지는 업로드에서 파일이름을 가져와 처리해야 한다
	private String rew_uploadpath;
	private Date rew_regdate;
	private Integer pro_num;
	private String pro_name;
	private String pro_img; 	//파일이미지는 업로드에서 파일이름을 가져와 처리해야 한다
	private String pro_uploadpath;
	private int pro_rewcount;
	private int pro_rewrating;
}

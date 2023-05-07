package com.kpet.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReviewVO {

	// rew_num, user_id, pro_num, rew_content, rew_score, rew_img, rew_uploadpath, rew_regdate
	private Integer rew_num;
	private String user_id;
	private Integer ord_code;	
	private Integer pro_num;
	private String rew_content;
	private int rew_score;
	private String rew_img;	//파일이미지는 업로드에서 파일이름을 가져와 처리해야 한다..
	private String rew_uploadpath;
	private Date rew_regdate;
	
	private MultipartFile upload;
	
}

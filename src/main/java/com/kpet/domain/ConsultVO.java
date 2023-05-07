package com.kpet.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ConsultVO {

	//cst_num, consulttype, cst_title, user_id, 
	//cst_content, cst_answer, cst_regdate, cst_updatedate
	
	private Integer rn;
	private Integer cst_num;
	private String cst_type;
	private String cst_title;
	private String user_id;
	private String cst_content;
	private String cst_img;
	private String cst_uploadpath;
	private String cst_answer;
	private Date cst_regdate;
	private Date cst_updatedate;
	
	// <input type="file" id="user_upload" name="user_upload">
	private MultipartFile cst_upload;
	
}

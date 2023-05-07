package com.kpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AnswerVO {
	//ans_num, cst_num, ans_title, ad_id, ans_content, 
	//ans_regdate, ans_updatedate
	
	private Integer ans_num;
	private Integer cst_num;
	private String ans_title;
	private String ad_id;
	private String ans_content;
	private Date ans_regdate;
	private Date ans_updatedate;
}

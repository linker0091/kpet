package com.kpet.domain;

import lombok.Data;

@Data
public class CategoryVO {

	// cate_code, cate_prt_code, cate_name
	
	private Integer cate_code;	// 기본카테고리 코드 (3차)
	private Integer cate_prtcode;	// 부모카테고리 코드 (1차)
	private Integer cate_subprtcode;  // 서브카테고리코드 (2차)
	private String cate_name;  
}

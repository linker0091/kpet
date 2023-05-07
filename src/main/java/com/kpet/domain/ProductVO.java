package com.kpet.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {

	// pro_num, cate_code, cate_prtcode, cate_subprtcode, pro_name, pro_price, pro_discount, pro_promo, pro_tag, pro_content,
	// pro_img, pro_uploadpath, pro_amount, pro_purchase, pro_rewcount, pro_rewrating, pro_date, pro_updatedate
	
	private Integer	pro_num;
	private Integer	cate_code;	// 기본 카테고리 코드(3차)
	private Integer	cate_prtcode;	// 부모 카테고리 코드 (1차)
	private Integer	cate_subprtcode;   // 서브카테고리 코드 (2차)
	private String pro_name;
	private int	pro_price; //
	private int pro_discount;
	private String pro_promo;
	private String pro_tag;
	private String pro_content;
	private String pro_img;	//파일이미지는 업로드에서 파일이름을 가져와 처리해야 한다..
	private String pro_uploadpath;  // 날짜폴더. 추가
	private int pro_amount;
	private String pro_purchase;
	private int pro_rewcount;
	private int pro_rewrating;
	private Date pro_date;
	private Date pro_updatedate;
	
	// <input type="file" id="upload" name="upload">
	private MultipartFile upload;
}

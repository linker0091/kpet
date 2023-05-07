package com.kpet.domain;

import lombok.Data;

//장바구니테이블과 상품테이블의 조인한 결과를 저장
@Data
public class CartListVO {

	/*
	 c.cart_code, c.pro_num, c.mbsp_id, c.cart_amount, 
    p.pro_num, p.cate_prt_code, p.cate_code, p.pro_name, p.pro_price, p.pro_discount, p.pro_publisher, p.pro_content, 
    p.pro_img, p.pro_amount, p.pro_buy, p.pro_date, p.pro_updatedate, p.pro_uploadpath 
	 */
	private Long cart_code;
	private Integer pro_num;
	private String user_id;
	private int cart_amount;
	private String pro_name;
	private String pro_img;
	private String pro_uploadpath;
	private int pro_price;
	private int pro_discount;
}

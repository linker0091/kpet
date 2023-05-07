package com.kpet.domain;

import lombok.Data;

@Data
public class DetailOrderInfo {

	/* od.ord_code, 
	od.pro_num, 
	p.pro_name, 
	od.dt_amount, 
	od.dt_price, 
	p.pro_uploadpath, 
	p.pro_img
	*/
	
	private Integer ord_code;
	private String pro_name;
	private Integer pro_num;
	private int	dt_ord_amount;
	private int dt_ord_price;
	private String pro_uploadpath;
	private String pro_img;
}

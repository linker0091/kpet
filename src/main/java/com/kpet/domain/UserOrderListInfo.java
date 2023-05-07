package com.kpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserOrderListInfo {

	private Integer ord_code; 
	private Integer pro_num;
	private String pro_name;
	private int dt_ord_amount; 
	private int dt_ord_price;
	private String pro_uploadpath; 
	private String pro_img;
	private String ord_state;
	private int ord_price;
	private String ord_name;
	private Date ord_regdate;
	
}

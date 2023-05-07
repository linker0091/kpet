package com.kpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {

	// ord_code, user_id, ord_name, ord_postcode, ord_addr_basic, ord_addr_detail, ord_phone,
	// ord_price, ord_depositor, ord_message, ord_state, ord_regdate
	private Integer ord_code;
	private String user_id;
	private String ord_name;
	private String ord_postcode;
	private String ord_addr_basic;
	private String ord_addr_detail;
	private String ord_phone;
	private int ord_price;
	private String ord_depositor;
	private String ord_message;
	private String ord_state;
	private Date ord_regdate;
}

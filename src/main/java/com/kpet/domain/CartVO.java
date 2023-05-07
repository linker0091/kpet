package com.kpet.domain;

import lombok.Data;

@Data
public class CartVO {

	// cart_code, pro_num, mbsp_id, cart_amount
	private Long cart_code;
	private Integer pro_num;
	private String user_id;
	private int cart_amount;
}

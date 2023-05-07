package com.kpet.domain;

import lombok.Data;

@Data
public class DetailOrder {

	// 주문상세 : 주문상품이 여러개 존재.(최소 1개이상)
	// ord_code, pro_num, dt_amount, dt_price
	private Integer ord_code;
	private Integer pro_num;
	private int dt_ord_amount;
	private int dt_ord_price;
}

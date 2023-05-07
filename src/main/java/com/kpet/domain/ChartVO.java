package com.kpet.domain;

import lombok.Data;

@Data
public class ChartVO {
	
	private String cate_name;
	private int sales;
	
	private String year;
	private int totalprice;
}

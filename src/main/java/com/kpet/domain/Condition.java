package com.kpet.domain;

import java.util.Arrays;

import lombok.Data;

@Data
public class Condition {

	private int cate_prtcode;
	private String keyword;
	private int price_min;
	private int price_max;
	private String scores;
	
	public int[] getScores() {
	    return scores == null || scores.isEmpty() ? null : Arrays.stream(scores.split(",")).mapToInt(Integer::parseInt).toArray();
	}
	
}

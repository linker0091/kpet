package com.kpet.service;

import java.util.List;

import com.kpet.domain.ChartVO;

public interface ChartService {

	public List<ChartVO> primaryChart();
	public List<ChartVO> secondaryChart();
	public List<ChartVO> thirdlyChart();
	public List<ChartVO> salesByYearChart();
	
	public List<ChartVO> primaryChartByMonth(String ord_date);
	public List<ChartVO> secondaryChartByMonth(String ord_date);
	public List<ChartVO> thirdlyChartByMonth(String ord_date);
	
	public List<String> getSalesYears();
}

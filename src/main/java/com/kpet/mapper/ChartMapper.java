package com.kpet.mapper;

import java.util.List;

import com.kpet.domain.ChartVO;

public interface ChartMapper {

	public List<ChartVO> primaryChart();
	public List<ChartVO> secondaryChart();
	public List<ChartVO> thirdlyChart();
	public List<ChartVO> salesByYearChart();
	
	public List<ChartVO> primaryChartByMonth(String ord_date);
	public List<ChartVO> secondaryChartByMonth(String ord_date);
	public List<ChartVO> thirdlyChartByMonth(String ord_date);
	
	public List<String> getSalesYears();
	
}

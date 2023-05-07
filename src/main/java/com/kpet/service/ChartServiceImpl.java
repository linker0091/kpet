package com.kpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpet.domain.ChartVO;
import com.kpet.mapper.ChartMapper;

@Service
public class ChartServiceImpl implements ChartService {

	@Autowired
	private ChartMapper chartMapper;
	
	@Override
	public List<ChartVO> primaryChart() {
		// TODO Auto-generated method stub
		return chartMapper.primaryChart();
	}

	@Override
	public List<ChartVO> secondaryChart() {
		// TODO Auto-generated method stub
		return chartMapper.secondaryChart();
	}
	
	@Override
	public List<ChartVO> thirdlyChart() {
		// TODO Auto-generated method stub
		return chartMapper.thirdlyChart();
	}

	@Override
	public List<ChartVO> salesByYearChart() {
		// TODO Auto-generated method stub
		return chartMapper.salesByYearChart();
	}

	@Override
	public List<ChartVO> primaryChartByMonth(String ord_date) {
		// TODO Auto-generated method stub
		return chartMapper.primaryChartByMonth(ord_date);
	}

	@Override
	public List<ChartVO> secondaryChartByMonth(String ord_date) {
		// TODO Auto-generated method stub
		return chartMapper.secondaryChartByMonth(ord_date);
	}

	@Override
	public List<ChartVO> thirdlyChartByMonth(String ord_date) {
		// TODO Auto-generated method stub
		return chartMapper.thirdlyChartByMonth(ord_date);
	}

	@Override
	public List<String> getSalesYears() {
		// TODO Auto-generated method stub
		return chartMapper.getSalesYears();
	}

}

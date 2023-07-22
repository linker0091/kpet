package com.kpet.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kpet.domain.ChartVO;
import com.kpet.service.ChartService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/chart/*")
@Controller
public class ChartController {

	
	@Autowired
	private ChartService service;
	
	//(전체) 통계차트 페이지
	@GetMapping("/overall")
	public ModelAndView overallChart() throws Exception{
		
		// 통계차트 데이타
		/*
		 2차원 배열구조
		  [
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]
		
		 
		 */
		
		ModelAndView mv = new ModelAndView();
		
		
		/*-------------------------1차 카테고리 차트작업------------------------------*/
		List<ChartVO> primary_list = service.primaryChart();
		
		String primaryData = "[['1차 카테고리', '매출'],";
		
		int i = 0;
		for(ChartVO vo : primary_list) {
			primaryData += "['" + vo.getCate_name() + "'," + vo.getSales() + "]";
			i++;
			// 마지막 데이타 작업시 콤마(,)는 추가하지않는다.
			if(i < primary_list.size()) primaryData += ",";	
		}

		primaryData += "]";
		
		log.info("primary_list: " + primary_list);

		
		
		/*---------------------------2차 카테고리 차트작업----------------------------*/
		
		List<ChartVO> second_list = service.secondaryChart();
		
		String secondData = "[['2차 카테고리', '매출'],";
		
		int j = 0;
		for(ChartVO vo : second_list) {
			secondData += "['" + vo.getCate_name() + "'," + vo.getSales() + "]";
			j++;
			// 마지막 데이타 작업시 콤마(,)는 추가하지않는다.
			if(j < second_list.size()) secondData += ",";	
		}

		secondData += "]";
		
		log.info("second_list: " + second_list);

		
		
		/*---------------------------3차 카테고리 차트작업----------------------------*/
		
		List<ChartVO> third_list = service.thirdlyChart();
		
		String thirdData = "[['2차 카테고리', '매출'],";
		
		int k = 0;
		for(ChartVO vo : third_list) {
			thirdData += "['" + vo.getCate_name() + "'," + vo.getSales() + "]";
			k++;
			// 마지막 데이타 작업시 콤마(,)는 추가하지않는다.
			if(k < third_list.size()) thirdData += ",";	
		}

		thirdData += "]";
		
		log.info("third_list: " + third_list);

		
		/*---------------------------년도별 매출 차트작업----------------------------*/
		
		List<ChartVO> salesByYearList = service.salesByYearChart();
		
		String salesYearData = "[['연도', '총매출'],";
		
		int l = 0;
		for(ChartVO vo : salesByYearList) {
			salesYearData += "['" + vo.getYear() + "'," + vo.getTotalprice() + "]";
			l++;
			// 마지막 데이타 작업시 콤마(,)는 추가하지않는다.
			if(l < salesByYearList.size()) salesYearData += ",";	
		}

		salesYearData += "]";
		
		
				
		// mv.addObject("Model이름", 데이타);
		mv.addObject("prime_chart", primaryData);
		mv.addObject("second_chart", secondData);
		mv.addObject("third_chart", thirdData);
		mv.addObject("salesYear_chart", salesYearData);
		// jsp파일명
		mv.setViewName("/admin/chart/overall");
		
		return mv;
	}
	
	@GetMapping("/monthlyOrder")
	public ModelAndView monthlyOrderChart(@RequestParam(value = "ord_date", required = false) String ord_date, Model model) throws Exception{
			
	    ModelAndView mv = new ModelAndView();
			
	    log.info(ord_date);
	    //주어진 날짜가 없을 때 현재 날짜로	
	    if(StringUtils.isEmpty(ord_date)) {
	        Date now = new Date();
					
	        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM");
	        ord_date = format.format(now);  // 2022/04
	    }

	    String ord_year = ord_date.substring(0, 4);
	    String ord_month = ord_date.substring(5, 7);
	   
		/*-------------------------1차 카테고리 차트작업------------------------------*/
	    List<ChartVO> primary_list = service.primaryChartByMonth(ord_date);
			
	    String primaryData = "[['1차 카테고리', '년월매출'],";
			
	    int i = 0;
	    for(ChartVO vo : primary_list) {
	    	primaryData += "['" + vo.getCate_name() + "'," + vo.getSales() + "]";
	        i++;
	        // 마지막 데이타 작업시 콤마(,)는 추가하지않는다.
	        if(i < primary_list.size()) primaryData += ",";	
	    }

	    primaryData += "]";
		log.info("primary_list : " + primary_list);

		/*-------------------------2차 카테고리 차트작업------------------------------*/    
	    
	    List<ChartVO> second_list = service.secondaryChartByMonth(ord_date);
		
	    String secondData = "[['2차 카테고리', '년월매출'],";
			
	    int j= 0;
	    for(ChartVO vo : second_list) {
	    	secondData += "['" + vo.getCate_name() + "'," + vo.getSales() + "]";
	        j++;
	        // 마지막 데이타 작업시 콤마(,)는 추가하지않는다.
	        if(j < second_list.size()) secondData += ",";	
	    }

	    secondData += "]";
		log.info("second_list: " + second_list);

		/*-------------------------3차 카테고리 차트작업------------------------------*/   
	    
	    List<ChartVO> third_list = service.thirdlyChartByMonth(ord_date);
		
	    String thirdData = "[['3차 카테고리', '년월매출'],";
			
	    int k = 0;
	    for(ChartVO vo : third_list) {
	    	thirdData += "['" + vo.getCate_name() + "'," + vo.getSales() + "]";
	        k++;
	        // 마지막 데이타 작업시 콤마(,)는 추가하지않는다.
	        if(k < third_list.size()) thirdData += ",";	
	    }

	    thirdData += "]";
		log.info("third_list: " + third_list);
		
		/*-------------------------연도 데이터 작업------------------------------*/
		List<String> years = service.getSalesYears();
		// 추가
		List<String> months = new ArrayList<String>();
	    for (int l = 1; l <= 12; l++) {
	        String month = String.format("%02d", l); // 두 자리 숫자로 포맷팅
	        months.add(month);
	    }
	    //추가끝
		
		mv.addObject("years", years);
		//추가
	    mv.addObject("months", months);
	    mv.addObject("ord_year", ord_year);
	    mv.addObject("ord_month", ord_month);
	    //추가 끝
	    mv.addObject("prime_month_chart", primaryData);
	    mv.addObject("second_month_chart", secondData);
	    mv.addObject("third_month_chart", thirdData);
	    mv.setViewName("/admin/chart/monthlyOrder");
	    return mv;
	}
	
}

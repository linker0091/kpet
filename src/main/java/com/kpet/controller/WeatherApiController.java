package com.kpet.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kpet.domain.UserVO;
import com.kpet.weather.ApiData;
import com.kpet.weather.Response.Items;
import com.kpet.weather.UltraSrtNcst;
import com.kpet.weather.UltraSrtNcst.CategoryType;
import com.kpet.weather.WeatherInfo;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/api/*")
@Controller
public class WeatherApiController {
	
	//도시별 날씨
	@GetMapping("/cityWeather")
	public void getVilageFcst(Model model,HttpSession session) {
	   
		String city;
	    UserVO userVO = (UserVO) session.getAttribute("loginStatus");
	    if (userVO == null || userVO.getUser_addr() == null || userVO.getUser_addr().isEmpty()) {
	        city = "서울";
	    } else {
	        city = userVO.getUser_addr();
	    }
		
		LocalDate currentDate = LocalDate.now();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        
        LocalTime currentTime = LocalTime.now();
        LocalTime before30Minutes = currentTime.minusMinutes(30);
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HHmm");
        String currentTimeString = currentTime.format(timeFormatter);
       
        String dateString = currentDate.format(dateFormatter);
        String timeString = before30Minutes.format(timeFormatter);        

	    log.info("도시: " + city );
	    log.info("현재날짜: " +dateString );
	    log.info("현재시간: " +timeString );		
		
		
	  final String BASE_URL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
	  final String serviceKey = "c6L4gXLR%2FNzWVlfqw%2F6pXXyvlZ3Cb%2Fayz%2BAuA901YvaUMQG2fCEnMyaVYK0dMeSmQnSsJ%2Bt3bwiJlLO7dHEm2Q%3D%3D"; /*공공데이터포털에서 받은 인증키*/

	  // GeoCoding(지오코딩)? 주소를 입력시 위,경도 값으로 변환하는 기능.
	  
	  String nx = "";
	  String ny = "";
	  String cityName="";
	  
	  	if (city.contains("서울")) {
		    cityName = "서울";
		    nx = "60";
		    ny = "127";
		} else if (city.contains("대전")) {
		    cityName = "대전";
		    nx = "67";
		    ny = "100";
		} else if (city.contains("대구")) {
		    cityName = "대구";
		    nx = "89";
		    ny = "90";
		} else if (city.contains("광주")) {
		    cityName = "광주";
		    nx = "58";
		    ny = "74";
		} else if (city.contains("부산")) {
		    cityName = "부산";
		    nx = "98";
		    ny = "76";
		} else if (city.contains("세종")) {
		    cityName = "세종";
		    nx = "66";
		    ny = "103";
		} else if (city.contains("제주")) {
		    cityName = "제주";
		    nx = "52";
		    ny = "38";
		} else if (city.contains("인천")) {
		    cityName = "인천";
		    nx = "55";
		    ny = "124";
		} else if (city.contains("울산")) {
		    cityName = "울산";
		    nx = "102";
		    ny = "84";
		} else if (city.contains("경기")) {
		    cityName = "경기";
		    nx = "60";
		    ny = "120";
		} else if (city.contains("강원")) {
		    cityName = "강원";
		    nx = "73";
		    ny = "134";
		} else if (city.contains("충청북도")) {
		    cityName = "충청북도";
		    nx = "67";
		    ny = "107";
		} else if (city.contains("충청남도")) {
		    cityName = "충청남도";
		    nx = "68";
		    ny = "100";
		} else if (city.contains("전라북도")) {
		    cityName = "전라북도";
		    nx = "63";
		    ny = "89";
		} else if (city.contains("전라남도")) {
		    cityName = "전라남도";
		    nx = "51";
		    ny = "67";
		} else if (city.contains("경상북도")) {
		    cityName = "경상북도";
		    nx = "89";
		    ny = "91";
		} else if (city.contains("경상남도")) {
		    cityName = "경상남도";
		    nx = "91";
		    ny = "77";
		}


//	  log.info(nx);
//	  log.info(ny);
		
	  try {
	    StringBuilder urlBuilder = new StringBuilder(BASE_URL);
	    urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + serviceKey);
	    urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); 
	    urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("base_date", "UTF-8") + "=" + URLEncoder.encode(dateString, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("base_time", "UTF-8") + "=" + URLEncoder.encode(timeString, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("nx", "UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("ny", "UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8"));

	    
	    log.info(urlBuilder.toString());
	    
	    URL url = new URL(urlBuilder.toString());
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    conn.setRequestMethod("GET");
	    conn.setRequestProperty("Content-type", "application/json");

	    System.out.println("Response code: " + conn.getResponseCode());

	    if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	        StringBuilder sb = new StringBuilder();

	        // 스트림을 이용하여, JSON데이타를 모두 읽어들임.
	        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        in.lines().forEach(line -> {
	          sb.append(line);
	        });

	        in.close();
	        conn.disconnect();

	        System.out.println(sb.toString());
	        List<WeatherInfo> list = setWeatherInfo(sb.toString());
	        
	        model.addAttribute("weatherList", list);
	        model.addAttribute("cityName", cityName);
	    }
	  } catch (Exception e) {
	    e.printStackTrace();
	  }
	}

	/**
	  * 동네예보 데이터 파싱
	  * @param json
	  */
	private List<WeatherInfo> setWeatherInfo(String json) {
	  
		List<WeatherInfo> list = new ArrayList<WeatherInfo>();
		
		try {
			
		// json문자열 데이타를 ApiData 클래스 객체로 변환작업
		// json데이타의 매핑하고자 하는 타입이 다르면, 에러발생.
	    ObjectMapper objectMapper = new ObjectMapper();
	    ApiData data = objectMapper.readValue(json, ApiData.class);

	    Items items = data.getResponse().getBody().getItems();
		log.info("items: " + items);
	    
	    for (UltraSrtNcst item : items.getItem()) {
		      
		      
	    if (item.getCategory() == CategoryType.T1H) {
	    	  // 기온
	    	  list.add(new WeatherInfo("기온", item.getObsrValue()));
	    	  log.info("기온: " + item.getObsrValue());
	      } else if (item.getCategory() == CategoryType.PTY) {
	    	  //강수형태
	    	  list.add(new WeatherInfo("강수형태", item.getObsrValue()));
	    	  log.info("강수: " + item.getObsrValue());
	      } else if (item.getCategory() == CategoryType.WSD) {
	    	  //풍속
	    	  list.add(new WeatherInfo("풍속", item.getObsrValue()));
	    	  log.info("풍속: " + item.getObsrValue());
	      }
	    }
		
		
	  } catch (JsonMappingException e) {
	    e.printStackTrace();
	  } catch (JsonProcessingException e) {
	    e.printStackTrace();
	  } catch(Exception e) {
		  e.printStackTrace();
	  }
		
		return list;
	}
	
    // 매 40분마다 실행
    @Scheduled(cron = "0 0/40 * * * ?")
    public void scheduledTask() {
        log.info("스케쥴링 테스트");
    }
}

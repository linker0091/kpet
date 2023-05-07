package com.kpet.weather;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class WeatherInfo {

	private String category; // category
	private String fcstValue; // fcstValue
	
}

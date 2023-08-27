package com.kpet.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

//모든 컨트롤러에서 예외가 발생이되면, 개별 컨트롤러에서 예외처리를 하는 것이 아니라 공통예외처리를 담당하는 클래스를 생성한다.
@ControllerAdvice 
public class CommonExceptionAdvice {

	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);
	
	
	// 모든 예외처리는 아래 어노테이션이 담당.
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		
		logger.error("Exception...." + ex.getMessage());
		model.addAttribute("exception", ex);
		logger.error(model.toString());
		
		return "/error/error_page";
	}
	
	// 예외중 특정한 예외가 발생이되면 처리할 경우(잘못된 URL을 호출할 경우)
	// 컨트롤러가 동작되는 주소로 테스트하면 안된다.  예를 들면.  /sample 로 시작하는 주소로인하여 SampleController로가 동작됨.
	// 테스트주소 : http://localhost:8888/sample/ex10000 이런 형식은 SampleController 가동작되므로
	// http://localhost:8888/ex10000 'sample'이 빠진 형태로 시작해야 한다.
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		
		return "/error/custom404";
	}
}

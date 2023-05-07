package com.kpet.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


// 인터셉터기능을 담당하는 클래스는 HandlerInterceptorAdapter 추상클래스를 상속받아 구현해야 한다.
// 인터셉터 클래스가 동작하기위하여 servlet-context.xml 파일에서 설정작업을 해야한다.
public class TestInterceptor extends HandlerInterceptorAdapter {

	
	/*
	- preHandle()?
		컨트롤러가 호출되기전에 실행하는 특징. 예>/member/mypage, /order/orderinfo, /cart/cartlist
		컨트롤러의 매핑주소의 메서드가 실행이전에 처리해야 할 작업 또는 클라이언트로 부터 넘어온 요청정보를 가공하거나 추가하는 경우의 작업
		리턴값? boolean
		1) true: preHandle()메서드가 실행이 되고, 제어가 컨트롤러의 매핑주소로 진행이 이루어진다.
		2) false: 작업이 중단된다. 요청한 컨트롤러와 남은 인터셉터의 관련작업은 진행되지 않는다.
	*/
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 일련의 작업
		return super.preHandle(request, response, handler);
	}

	/*
	 -  postHandle()?
	 	컨트롤러의 매핑주소 메서드가 실행완료가 되고, JSP(뷰)가 생성되기 이전에 호출된다.
	 	ModelAndView 타입의 정보가 파라미터로 받음. 요청했던 매핑주소의 메서드에서 진행된 뷰(View)에 정보를 전달받아 정보를 참조하거나, 조작이 가능하다.
	 	preHandle()메서드에서 리턴값이 false인 경우 실행되지 않음.
	 	- 적용중인 인터셉터가 여러 개인 경우 preHandle() 역순으로 호출됨.
	 	- 비동기적 요청처리시는 실행되지 않는다.
	*/
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	/*
	 afterCompletion()?
	   - 매핑주소의 메서드가 동작되고, 해당 뷰(View)가 최종 결과를 생성하는 작업이 완료된 후에 실행
	   - 요청 처리중에 사용한 리소스를 반환작업이 적당하다.
	   preHandle()메서드에서 리턴값이 false인 경우 실행되지 않음.
	   - 적용중인 인터셉터가 여러 개인 경우 preHandle() 역순으로 호출됨.
	   - 비동기적 요청처리시에 호출되지 않음.
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	
}

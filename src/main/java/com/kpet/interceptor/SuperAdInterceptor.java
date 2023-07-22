package com.kpet.interceptor;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kpet.domain.AdminVO;

import lombok.extern.log4j.Log4j;
@Log4j
// 관리자 로그인 인터셉터 클래스
public class SuperAdInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(SuperAdInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.info("======== AuthInterceptor preHandle() called ========");
		
		// 세션처리작업
		HttpSession session = request.getSession();
		AdminVO admin = (AdminVO) session.getAttribute("adminStatus");
		
        if (admin != null) {  // 관리자 객체가 null이 아닌 경우
            String position = admin.getAd_position();

            if (position.equals("super_admin")) {  // 관리자 권한이 있는 경우
                // 로그인 페이지 로드 전에 요청된 페이지 정보 저장
                getDestination(request);
                return true;
            }
        } else {
            loginAlert(response); // admin이 null인 경우 loginAlert 실행
            return false;
        }
        
        positionAlert(response); // 관리자 권한이 없는 경우
        return false;
    }


	// 인터셉터 동작 전에 요청된 주소 정보를 저장하는 메소드
	private void getDestination(HttpServletRequest request){
		
		String uri = request.getRequestURI();
		String query = request.getQueryString();
		
		// 쿼리스트링
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;
		}
		
		String destination = uri + query; 
		
		if(request.getMethod().equals("GET")) {
			logger.info("destination : " + destination);
			// 원래 요청된 주소 저장
			request.getSession().setAttribute("destination", destination);
		}
	}
	
	private void positionAlert(HttpServletResponse response) throws IOException {
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter printwriter = response.getWriter();
		printwriter.print("<script>alert('현재 관리자 권한으로 접근이 불가합니다.');"
				+ "location.href = '/admin/main/';</script>");
		printwriter.flush();
		printwriter.close();
			
		}
	
	private void loginAlert(HttpServletResponse response) throws IOException {
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter printwriter = response.getWriter();
		printwriter.print("<script>alert('로그인을 다시 해주십시오');"
				+ "location.href = '/admin/logon/';</script>");
		printwriter.flush();
		printwriter.close();
			
		}
	
}

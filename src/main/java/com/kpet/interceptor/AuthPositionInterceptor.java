package com.kpet.interceptor;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kpet.domain.AdminVO;

// 관리자 로그인 인터셉터 클래스
public class AuthPositionInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		// 세션처리작업
		HttpSession session = request.getSession();
		AdminVO admin = (AdminVO) session.getAttribute("adminStatus");
		
		//관리자 직책
		String ad_position = admin.getAd_position();
		
		if(admin == null) {  
			// 관리자 미 로그인 시, 로그인 페이지 로드
			logger.info("===== Admin not logged in =====");

			// 로그인 페이지 로드 전에 요청된 페이지 정보 저장
			getDestination(request);
			
			response.sendRedirect("/admin/logon");
			
			return false;
		}
		
		
        // MiddleAdmin 사용자인지 체크
        boolean isMiddleAdmin = checkMiddleAdminAuth(request, ad_position);
        
        // UnderAdmin 사용자인지 체크
        boolean isUnderAdmin = checkUnderAdminAuth(request, ad_position);
        
        // 각 권한에 따라 접근 불가능한 페이지 체크
        if (isMiddleAdmin) {
            // Admin 권한이 있는 사용자만 접근 불가능한 페이지 목록 - 중간관리자 접근불가 페이지 목록
            List<String> adminPageList = Arrays.asList("/admin/adManagement");
            
            // 접근하려는 페이지가 접근 불가능한 페이지 목록에 포함되어 있는지 체크
            if (adminPageList.contains(request.getRequestURI())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return false;
            }
        }
        
        if (isUnderAdmin) {
            // Super Admin 권한이 있는 사용자 접근 불가능한 페이지 목록- 하위관리자 접근불가 페이지 목록
            List<String> superAdminPageList = Arrays.asList("/admin/adManagement", "/admin/product/productList");
            
            // 접근하려는 페이지가 접근 불가능한 페이지 목록에 포함되어 있는지 체크
            if (superAdminPageList.contains(request.getRequestURI())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return false;
            }
        }
        
        /*
        // 권한이 없는 경우 예외 처리
        if (!isMiddleAdmin && !isUnderAdmin) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }*/
        
     
    
    // MiddleAdmin 권한 체크
    private boolean checkMiddleAdminAuth(HttpServletRequest request, String ad_position) {
        // ...
    	if(ad_position != "중간관리자") {
    		return false;
    	}
    	return true;
    }
    
    // UnderAdmin 권한 체크
    private boolean checkUnderAdminAuth(HttpServletRequest request, String ad_position) {
        // ...
    	if(ad_position != "하위관리자") {
    		return false;
    	}
    	return true;
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
	
	}

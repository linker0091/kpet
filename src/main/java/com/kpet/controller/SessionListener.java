package com.kpet.controller;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.stereotype.Component;

import com.kpet.domain.UserVO;

@Component
public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        // 세션 생성 이벤트 처리
    }
    
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
    	
        HttpSession session = se.getSession();
        UserVO loginStatus = (UserVO) session.getAttribute("loginStatus");
        if (loginStatus == null) {
            // 로그아웃 상태를 클라이언트에게 알리는 코드
        	session.removeAttribute("loginStatus");
            session.setAttribute("timeLogout", true);
        }
    }
}
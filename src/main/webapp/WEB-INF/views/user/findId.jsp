<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/find_id.css" rel="stylesheet" /> 
     <!-- Header-->
	    <%@include file="/WEB-INF/views/user/include/header.jsp" %>
     <!-- Header-->
	<body>
    <div id="wrap">
        <section id="contents">
            <div class="container">
                <div class="title_area">
                    <h1>아이디 찾기</h1>
                </div>
                <div class="login_box">
                    <fieldset>
                        <legend>아이디 찾기</legend>
                        <div class="login_wrap">
                            <form action="#">
                                <div class="login_info">
                                    <label for="user_name" title="이름">이름
                                        <input type="text" class="form_control" name="user_name" id="user_name">
                                    </label>
                                </div>
                                <div class="login_info">
                                    <label for="user_pw" title="이메일로 찾기">이메일로 찾기
                                        <input type="password" class="form_control" name="user_pw" id="user_pw">
                                    </label>
                                </div>
                            </form>
                            <div class="loginbtn_box">
                                <button type="button" id="login_btn">확인</button>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
        </section>
    </div>
	</body>
     <!-- Footer-->
	    <%@include file="/WEB-INF/views/user/include/footer.jsp" %>
     <!-- Footer-->
</html>

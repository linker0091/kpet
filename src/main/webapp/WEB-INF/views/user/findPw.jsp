<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/find_pw.css" rel="stylesheet" /> 
     <!-- Header-->
	    <%@include file="/WEB-INF/views/user/include/header.jsp" %>
     <!-- Header-->
	<body>
    <div id="wrap">
        <section id="contents">
            <div class="container">
                <div class="title_area">
                    <h1>비밀번호 찾기</h1>
                </div>
                <div class="login_box">
                    <fieldset>
                        <legend>비밀번호 찾기</legend>
                        <div class="login_wrap">
                            <form action="#">
                                <div class="login_info">
                                    <label for="user_email" title="이메일">임시 비밀번호 발송
                                        <input type="text" class="form_control" name="user_email" id="user_email" placeholder="이메일형식">
                                    </label>
                                </div>
                            </form>
                            <div class="loginbtn_box">
                                <button type="button" id="login_btn">메일 전송하기</button>
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/reigster.css" rel="stylesheet" /> 
     <!-- Header-->
	    <%@include file="/WEB-INF/views/user/include/header.jsp" %>
     <!-- Header-->
	<body>
    <div id="wrap">
        <section id="contents">
            <div class="container">
                <div class="title_area">
                    <h1>회원가입</h1>
                </div>
                <div class="register_box">
                    <form action="/user/join" method="post" id="joinForm" class="form_horizontal">
                        <div class="info_toptitle clearfix">
                            <h3>기본정보</h3>
                            <p><span>*</span>필수입력사항</p>
                        </div>
                        <div class="bor-top">
                            <div class="base_info clearfix">
                                <div class="info_title bg_1a">
                                    <p>아이디<span>*</span></p>
                                </div>
                                <div class="info_box">
                                    <input type="text" class="form-control" name="user_id" id="user_id">
                                    <span>(영문소문자/숫자, 4~16자)</span>
                                </div>
                            </div>
                            <div class="base_info clearfix">
                                <div class="info_title bg_1a">
                                    <p>비밀번호<span>*</span></p>
                                </div>
                                <div class="info_box">
                                    <input type="text" class="form-control" name="user_id" id="user_id">
                                    <span>(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)</span>
                                </div>
                            </div>
                            <div class="base_info clearfix">
                                <div class="info_title bg_1a">
                                    <p>비밀번호 확인<span>*</span></p>
                                </div>
                                <div class="info_box">
                                    <input type="text" class="form-control" name="user_id" id="user_id">
                                </div>
                            </div>
                            <div class="base_info clearfix">
                                <div class="info_title bg_1a">
                                    <p>이름<span>*</span></p>
                                </div>
                                <div class="info_box">
                                    <input type="text" class="form-control" name="user_id" id="user_id">
                                </div>
                            </div>
                            <div class="base_info clearfix">
                                <div class="info_title bg_1a ht">
                                    <p>주소</p>
                                </div>
                                <div class="info_box">
                                    <div class="lining">
                                        <input type="text" class="form-control" name="user_id" id="user_id">
                                        <button type="button" class="postn_srcbtn">우편번호</button>
                                    </div>
                                    <input type="text" class="form-control3" name="user_id" id="user_id">
                                    <span>기본주소</span>
                                    <input type="text" class="form-control3" name="user_id" id="user_id">
                                    <span>나머지주소 (선택입력가능)</span>
                                </div>
                            </div>
                            <!-- <div class="base_info clearfix">
                                <div class="info_title bg_1a">
                                    <p>일반전화</p>
                                </div>
                                <div class="info_box">
                                    <input type="text" class="form-control" name="user_id" id="user_id">
                                </div>
                            </div> -->
                            <div class="base_info clearfix">
                                <div class="info_title bg_1a">
                                    <p>휴대전화<span>*</span></p>
                                </div>
                                <div class="info_box phone_input">
                                    <input type="text" class="form-control" name="user_id" id="user_id"><span class="space">-</span>
                                    <input type="text" class="form-control" name="user_id" id="user_id"><span class="space">-</span>
                                    <input type="text" class="form-control" name="user_id" id="user_id">
                                </div>
                            </div>
                            <div class="base_info clearfix">
                                <div class="info_title bg_1a">
                                    <p>이메일<span>*</span></p>
                                </div>
                                <div class="info_box">
                                    <input type="text" class="form-control" name="user_id" id="user_id">
                                </div>
                            </div>
                            <!-- <div class="base_info clearfix">
                                <div class="info_title bg_1a">
                                    <p>평생회원</p>
                                </div>
                                <div class="info_box">
                                    <input type="text" class="form-control" name="user_id" id="user_id">
                                    <p>평생회원으로 가입하시면 PETHOOH 회원 탈퇴시까지는 휴면회원으로 전환되지 않으며, 고객님의 개인정보가 탈퇴시까지 안전하게 보관됩니다.</p>
                                </div>
                            </div> -->
                        </div>
                        <div class="btn_box">
                            <button type="submit">회원가입</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </div>
	</body>
     <!-- Footer-->
	    <%@include file="/WEB-INF/views/user/include/footer.jsp" %>
     <!-- Footer-->
</html>

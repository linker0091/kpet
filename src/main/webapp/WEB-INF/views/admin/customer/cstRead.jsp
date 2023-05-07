<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<!-- css, js 파일포함 -->
<!-- 절대경로  /WEB-INF/views/include/header_info.jsp -->
<%@include file="/WEB-INF/views/admin/include/header_info.jsp" %>
<link rel="stylesheet" href="/resources/css/admin_consult.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<script>
	
</script>
<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/left_menu.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
	
	
	   <div class="container">

	<div class="consult_wrap consult_inner">
		<div class="page_title">
			<h2>문의글</h2>
		</div>
		
		<div class="consult_box">
				     <!--고객 문의 글  -->
		     <div class="consult_list">
		     	<ul class="clearfix">
					<li>${cstInner.cst_title}</li>
		            <li>${cstInner.cst_type}</li>
	         	</ul>
	         	<ul class="clearfix">
					<li>작성자</li>
		            <li>${cstInner.user_id}</li>
		            <li>답변여부</li>
		            <li class="answerVal">${cstInner.cst_answer}</li>
	         	</ul>
	         	<ul class="clearfix">
					<li>문의일시</li>
		            <li><fmt:formatDate value="${cstInner.cst_regdate}" pattern="yyyy-MM-dd" /></li>
	         	</ul>
	         	<ul class="clearfix">
					<li>내용</li>
		            <li id="cont_txt">${cstInner.cst_content}</li>
	         	</ul>
	         </div>
	         <!-- admin 답변작성 -->
	         <c:if test="${cstInner.cst_answer eq 'N'}">
	         <form action="/admin/customer/writeAnswer" method="post" id="adminForm">
					<div class="consult_wrap clearfix">
						<div class="page_title">
							<h2>답변글</h2>
						</div>
						<div class="consult_writebox">
							<!-- 상담 글쓰기 페이지 -->
						     <div class="title_box">
						     <input type="hidden" name="cst_num" value="${cstInner.cst_num}" >
						     	<ul class="clearfix">
						     		<li class="answerName">답변자</li>
						     		<li>						     			
										<input type="text" name="ad_id" class="inputTypeText" value="<c:out value='${sessionScope.adminStatus.ad_id}' />">
						     		</li>
						     	</ul>
						     	<ul class="clearfix">
						     		<li class="answerName">제목</li>
						     		<li>						     			
										<input type="text" name="ans_title" class="inputTypeText"  value="문의 답변입니다.">
						     		</li>
						     	</ul>
						     </div>
						     <div class="title_box write_inner">
						     	<ul class="clearfix">
							     	<li>내용</li>
							     	<textarea id="ans_content" type="text" class="write_text" name="ans_content" rows="10" cols="80"></textarea>
							     </ul>
						     </div>						     
						</div>
						<input type="hidden" name="cst_answer" value="${cstInner.cst_answer}" >
						<button type="button" class="btnstyle cst_listbtn">목록</button>
						<button type="button" class="btnstyle cst_answerbtn">답변등록</button>
					</div>
	         	</form>
	         </c:if>
	         
	         <!-- 답변된것 -->
	         <c:if test="${cstInner.cst_answer eq 'Y'}">
	              <div class="consult_list">
	              	<ul class="clearfix">
	         			<li>제목</li>
	              		<li><c:out value="${cstWrite.ans_title }"></c:out></li>
         			</ul>
			     	<ul class="clearfix">
						<li>답변자</li>
			            <li><c:out value="${cstWrite.ad_id }"></c:out></li>
		         	</ul>
		         	<ul class="clearfix">
						<li>답변일시</li>
			            <li><fmt:formatDate value="${cstWrite.ans_regdate }" pattern="yyyy-MM-dd" /></li>
		         	</ul>
		         	<ul class="clearfix">
						<li>내용</li>
			            <li id="cont_txt"><c:out value="${cstWrite.ans_content }"></c:out></li>
		         	</ul>
		         </div>
	         </c:if>
     		 <button type="button" class="btnstyle cst_listbtn">목록</button>
	    </div> 
	</div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer (기타 footer태그밑에 소스포함)-->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/admin/include/plugin_js.jsp" %>

<script>
	// 답변 등록
	/*
	$(".cst_answerbtn").on("click", function(){
		location.href = "/admin/customer/writeAnswer";		
	});*/
	$(".cst_answerbtn").on("click", function(){
		let adminForm = $("#adminForm");
		let cst_num = $("input[name='cst_num']").val();
		console.log(cst_num);
		adminForm.append("<input type='hidden' name='cst_num' value='" + cst_num + "'>");

		adminForm.submit();		
	});
	
	
	//리스트버튼
    $(".cst_listbtn").on("click", function(){
    	location.href = "/admin/customer/consult";
		//location.href = "/user/consult";
		let cst_answer =  $(".answerVal").text();; 
    	if(cst_answer != 'N') {
			location.href = "/admin/customer/consult?cst_answer=" + cst_answer;
		};
	});
	
	

</script>

</body>
</html>

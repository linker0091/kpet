<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<form action="/admin/adminRegister" method="post" id="adminForm">
		<div class="form-row">
		    <input type="button" value="접수중[${cst_answer_n}]" data-ans_state="N" name="cst_answer">
		    <input type="button" value="답변완료[${cst_answer_y}]" data-ans_state="Y" name="cst_answer">
	   </div>
	   
	   <div class="container">

	<div class="consult_wrap">
		<div class="page_title">
			<h2>1:1 맞춤상담</h2>
		</div>
		
		<div class="consult_box">
				     <!-- 상담 페이지 -->
		     <div class="consult_list">
		     	<ul class="clearfix">
					<li>번호</li>
		            <li>카테고리</li>
		            <li>제목</li>
		            <li>작성자</li>
		            <li>작성일</li>
		            <li>답변</li>
	         	</ul>
	         <c:if test="${empty conSultList}">
	         	<p>검색결과가 없습니다.</p>
	         </c:if>
	         <c:if test="${not empty conSultList}">
				<c:forEach items="${conSultList}" var="conSultVO" varStatus="status">
					<%-- <input type="hidden" id="inputCstAnswer" name="cst_answer" value="${conSultVO.cst_answer}">--%>
	         		<a href="${conSultVO.cst_num }" class="sonsult">
	         			<ul>
		         			<li><c:out value="${conSultVO.cst_num}"></c:out></li>
		              		<li><c:out value="${conSultVO.cst_type }"></c:out></li>
		              		<li><c:out value="${conSultVO.cst_title }"></c:out></li>
		              		<li><c:out value="${conSultVO.user_id }"></c:out></li>
		              		<li><fmt:formatDate value="${conSultVO.cst_regdate }" pattern="yyyy-MM-dd" /></li>
		              		<li><c:out value="${conSultVO.cst_answer }"></c:out></li>
	         			</ul>
              		</a>
	         	</c:forEach>
	         </c:if>
	         </div>
	    </div> 
	</div>
</div>
   </form>
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
	//답변등록 클릭시.
	$("#write").on("click", function(){
		location.href = "/adim/cstWrite";		
	});
	
	// 글 클릭시.
	$(".sonsult").on("click", function(e){
		e.preventDefault();
		let num = $(this).attr('href');
		let urlN = "/admin/customer/cstRead?cst_num=" + num;
		location.href = urlN;
		/*
		let cst_answer =  $("#inputCstAnswer").val();
		if(cst_answer != 'N') {
			location.href = urlN + "&cst_answer=" + cst_answer;
		};*/
	});
	
	//미완료, 답변완료 리스트 클릭시.
	$("input[name='cst_answer']").on("click", function(){
		console.log("클릭");
		let ans_state = $(this).data("ans_state");
		location.href = "/admin/customer/consult?cst_answer=" + ans_state;		
	});
	
	
	$(document).ready(function(){
		let msg = '${msg}';
		if( msg == insertOk) {
			alert("답변등록이 완료되었습니다.");
			}
	});
	/*	
	  $(document).ready(function() {
          let msg = '${msg}';
          if (msg == 'insertOk') {
              alert("답변등록이 완료되었습니다.");
          }
      });
	*/
</script>

</body>
</html>

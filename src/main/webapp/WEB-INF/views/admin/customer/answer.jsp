<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	
	   <div class="container">

	<div class="consult_wrap answer_wrap">
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
	         		<a href="${conSultVO.cst_num }" class="sonsult">
	         			<ul>
		         			<li><c:out value="${status.count}"></c:out></li>
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
     		 <button type="button" id="write">글쓰기</button>
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

</body>
</html>

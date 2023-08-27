<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- css, js 파일포함 -->
<%@include file="/WEB-INF/views/admin/include/header_info.jsp"%>
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

	<div class="wrapper">

		<!-- Main Header -->
		<%@include file="/WEB-INF/views/admin/include/header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/admin/include/left_menu.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>맞춤 상담</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<form action="/admin/adminRegister" method="post" id="adminForm">

					<div class="container">

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
									<c:forEach items="${conSultList}" var="conSultVO"
										varStatus="status">
										<a href="${conSultVO.cst_num }" class="sonsult">
											<ul>
												<li><c:out value="${status.count}"></c:out></li>
												<li><c:out value="${conSultVO.cst_type }"></c:out></li>
												<li><c:out value="${conSultVO.cst_title }"></c:out></li>
												<li><c:out value="${conSultVO.user_id }"></c:out></li>
												<li><fmt:formatDate value="${conSultVO.cst_regdate }"
														pattern="yyyy-MM-dd" /></li>
												<li><c:out value="${conSultVO.cst_answer }"></c:out></li>
											</ul>
										</a>
									</c:forEach>
								</c:if>
							</div>
							<button type="button" id="write">글쓰기</button>
						</div>
					</div>
				</form>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer (기타 footer태그밑에 소스포함)-->
		<%@include file="/WEB-INF/views/admin/include/footer.jsp"%>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->
	<%@include file="/WEB-INF/views/admin/include/plugin_js.jsp"%>

</body>
</html>

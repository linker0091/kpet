<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<!-- css, js 파일포함 -->
<!-- 절대경로  /WEB-INF/views/include/header_info.jsp -->
<%@include file="/WEB-INF/views/admin/include/header_info.jsp"%>
<script>
	let msg = '${msg}';

	if (msg == "insertOk") {
		alert("상품등록 성공");
	} else if (msg == "modifyOk") {
		alert("상품수정 성공");
	} else if (msg == "deleteOk") {
		alert("상품삭제성공");
	}
</script>

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
<style>
.move {
	margin-right: 20px;
}

#example2 td {
	vertical-align: middle;
}
</style>

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
				<h1>상품리스트</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
            | Your Page Content Here |
            -------------------------->

				<div class="row">
					<div class="col-xs-12">
						<div class="box">

							<!-- /.box-header -->
							<div class="box-body">
								<div id="example2_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap">
									<div class="row">
										<div class="col-sm-6"></div>
										<div class="col-sm-6"></div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<table id="example2"
												class="table table-bordered table-hover dataTable"
												role="grid" aria-describedby="example2_info">
												<thead>
													<tr role="row">
														<th><input type="checkbox" id="checkAll"
															name="checkAll"></th>
														<th>번호</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Browser: activate to sort column ascending">상품명</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Platform(s): activate to sort column ascending">등록일</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">가격</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">재고</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">진열</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">수정</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">삭제</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${productList }" var="productVO"
														varStatus="status">
														<tr role="row"
															class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
															<td><input type="checkbox" class="check"
																value='<c:out value="${productVO.pro_num }"></c:out>'>
																<input type="hidden" name="pro_img"
																value='<c:out value="${productVO.pro_img }"></c:out>'>
																<input type="hidden" name="pro_uploadpath"
																value='<c:out value="${productVO.pro_uploadpath }"></c:out>'>
															</td>
															<td class="sorting_1"><c:out
																	value="${productVO.pro_num }"></c:out></td>
															<td><img name="proudctImage"
																src="/admin/product/displayFile?fileName=s_<c:out value="${productVO.pro_img }"></c:out>&uploadPath=<c:out value="${productVO.pro_uploadpath }"></c:out>">
																<span><c:out value="${productVO.pro_name }"></c:out></span>
															</td>
															<td><fmt:formatDate value="${productVO.pro_date }"
																	pattern="yyyy-MM-dd" /></td>
															<td><span><c:out
																		value="${productVO.pro_price }"></c:out></span></td>
															<td><span><c:out
																		value="${productVO.pro_amount }"></c:out></span></td>
															<td><input type="checkbox" disabled
																style="pointer-events: none;"
																value="<c:out value="${productVO.pro_purchase }"></c:out>"
																<c:out value="${productVO.pro_purchase == 'Y' ? 'checked': '' }"></c:out>>
															</td>
															<td><input type="button" name="btnProductModify"
																value="수정"
																data-pro_num='<c:out value="${productVO.pro_num }"></c:out>'></td>
															<td><input type="button" name="btnProductDelete"
																value="삭제"
																data-pro_num='<c:out value="${productVO.pro_num }"></c:out>'></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-5 dataTables_info">
											<form id="searchForm" action="/admin/product/productList"
												method="get">
												<select name="type">
													<option value=""
														<c:out value="${pageMaker.cri.type == null? 'selected':'' }" />>--</option>
													<option value="N"
														<c:out value="${pageMaker.cri.type eq 'N'? 'selected':'' }" />>상품명</option>
													<option value="P"
														<c:out value="${pageMaker.cri.type eq 'P'? 'selected':'' }" />>내용</option>
												</select> <input type="text" name="keyword"
													value="<c:out value="${ pageMaker.cri.keyword}" />">
												<input type="hidden" name="pageNum"
													value="${pageMaker.cri.pageNum}"> <input
													type="hidden" name="amount" value="${pageMaker.cri.amount}">
												<button class="btn btn-primary">Search</button>
											</form>
										</div>
										<div class="col-sm-7">
											<div class="dataTables_paginate paging_simple_numbers"
												id="example2_paginate">
												<ul class="pagination">
													<c:if test="${pageMaker.prev }">
														<li
															class='paginate_button previous ${pageMaker.prev ? "": "disabled" }'
															id="example2_previous"><a
															href="${pageMaker.startPage - 1}"
															aria-controls="example2" data-dt-idx="0" tabindex="0">Previous</a></li>
													</c:if>
													<c:forEach begin="${pageMaker.startPage }"
														end="${pageMaker.endPage }" var="num">
														<li
															class='paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }'><a
															href="${num}" aria-controls="example2" data-dt-idx="1"
															tabindex="0">${num}</a></li>
													</c:forEach>
													<c:if test="${pageMaker.next }">
														<li class="paginate_button next" id="example2_next"><a
															href="${pageMaker.endPage + 1}" aria-controls="example2"
															data-dt-idx="7" tabindex="0">Next</a></li>
													</c:if>
												</ul>
											</div>
										</div>
										<!--prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
										<form id="actionForm" action="/admin/product/productList"
											method="get">
											<!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
											<input type="hidden" name="pageNum"
												value="${pageMaker.cri.pageNum}"> <input
												type="hidden" name="amount" value="${pageMaker.cri.amount}">
											<input type="hidden" name="type"
												value="${pageMaker.cri.type}"> <input type="hidden"
												name="keyword" value="${pageMaker.cri.keyword}">
											<!--글번호추가-->
										</form>
									</div>
								</div>
							</div>
							<!-- /.box-body -->
						</div>
					</div>
					<!-- /.col -->
				</div>
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

	<script>
		$(document)
				.ready(
						function() {

							let isCheck = true;
							/*전체선택 체크박스 클릭*/
							$("#checkAll").on("click", function() {
								$(".check").prop("checked", this.checked);

								isCheck = this.checked;
							});

							// 데이터행 체크박스 클릭
							$(".check").on("click", function() {

								$("#checkAll").prop("checked", this.checked);

								$(".check").each(function() {
									if (!$(this).is(":checked")) { // 체크박스중 하나라도 해제된 상태라면  false
										$("#checkAll").prop("checked", false);
									}

								});
							});

							let actionForm = $("#actionForm");
							//페이지번호 클릭시 : 선택한 페이지번호, 페이징정보, 검색정보
							$(".paginate_button a").on(
									"click",
									function(e) {
										e.preventDefault(); // <a href="">기능취소
										//기존 페이지번호를 사용자가 선택한 페이지번호로 변경
										actionForm
												.find("input[name='pageNum']")
												.val($(this).attr("href"));
										actionForm.submit();

									});

							//상품 체크 삭제
							$("#btnCheckDelete")
									.on(
											"click",
											function() {
												if ($(".check:checked").length == 0) {
													alert("삭제할 상품을 선택하세요.");
													return;
												}

												let isDel = confirm("선택한 상품을 삭제하겠습까?");

												if (!isDel)
													return;

												// 데이터행에서 체크된 상품코드, 상품이미지

												//자바스크립트 배열
												let pro_numArr = []; //상품코드 배열
												let pro_imgArr = []; //상품이미지 배열
												let pro_uploadpathArr = []; //날짜폴더이름 

												//선택된 체크박스 일 경우
												$(".check:checked")
														.each(
																function() {
																	let pro_num = $(
																			this)
																			.val();
																	let pro_img = $(
																			this)
																			.next()
																			.val();
																	let pro_uploadpath = $(
																			this)
																			.next()
																			.next()
																			.val();

																	pro_numArr
																			.push(pro_num);
																	pro_imgArr
																			.push(pro_img);
																	pro_uploadpathArr
																			.push(pro_uploadpath);
																})

												$
														.ajax({
															url : '/admin/product/checkDelete',
															type : 'post',
															dataType : 'text',
															data : {
																pro_numArr : pro_numArr,
																pro_imgArr : pro_imgArr,
																pro_uploadpathArr : pro_uploadpathArr
															},
															success : function(
																	data) {
																if (data == "success") {
																	alert("선택된 상품이 삭제됨");

																	// 리스트주소 이동 또는 선택된 행을 동적삭제.
																	//location.href= "주소";

																	console
																			.log($(".check:checked").length);
																	//테이블의 행을 의미하는 <tr>태그 제거.
																	$(
																			".check:checked")
																			.each(
																					function() {
																						$(
																								this)
																								.parent()
																								.parent()
																								.remove();
																					});
																}
															},
															error : function() {
																alert("주문 내역이 있는 상품은 삭제가 불가합니다. 판매안함으로 바꾸어주세요.");
															}
														});

											});

							//수정버튼 클릭시
							$("input[name='btnProductModify']")
									.on(
											"click",
											function() {

												let pro_num = $(this).data(
														"pro_num");

												actionForm
														.attr("action",
																"/admin/product/productModify");
												actionForm
														.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
												actionForm.submit();

											});

							//삭제버튼 클릭시
							$("input[name='btnProductDelete']")
									.on(
											"click",
											function() {

												if (!confirm("삭제하겠읍니까?"))
													return;

												let pro_num = $(this).data(
														"pro_num");

												actionForm
														.attr("action",
																"/admin/product/productDelete");
												actionForm.attr("method",
														"post");
												actionForm
														.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
												actionForm.submit();

											});

						});
	</script>
</body>
</html>

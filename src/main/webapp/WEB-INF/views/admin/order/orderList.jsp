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
<style>
	input[name='btnOrdState'] {width: 120px;}
</style>

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
				<h1>
					Page Header <small>Optional description</small>
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


				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">주문리스트</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div class="row">
										<div class="col-sm-1">
											진행상태
										</div>
										<div class="col-sm-11">
											<input type="button" value="전체" data-ordstate="전체" name="btnOrdState">
											<input type="button" value="주문접수[${ord_count}]" data-ordstate="주문접수" name="btnOrdState">
											<input type="button" value="결제완료[${ord_pay}]" data-ordstate="결제완료" name="btnOrdState">
											<input type="button" value="배송준비중[${ord_delivery}]" data-ordstate="배송준비중" name="btnOrdState">
											<input type="button" value="배송처리" data-ordstate="배송처리" name="btnOrdState">
											<input type="button" value="배송완료" data-ordstate="배송완료" name="btnOrdState">
											<input type="button" value="주문취소" data-ordstate="주문취소" name="btnOrdState">
											<input type="button" value="미주문" data-ordstate="미주문" name="btnOrdState"><br>
											<input type="button" value="취소요청[${ord_cancel}]" data-ordstate="취소요청" name="btnOrdState">
											<input type="button" value="취소완료" data-ordstate="취소완료" name="btnOrdState">
											<input type="button" value="교환요청[${ord_change}]" data-ordstate="교환요청" name="btnOrdState">
											<input type="button" value="교환완료" data-ordstate="교환완료" name="btnOrdState">
										</div>
								</div>
								<form id="searchForm" action="/admin/order/orderList" method="get">
								<div class="row" style="margin-top: 10px;">
										<div class="col-sm-1">기간</div>
										<div class="col-sm-11">
											<input type="date" name="startDate" value="${startDate}"> ~ <input type="date" name="endDate" value="${endDate}">
										</div>
								</div>
								
								<div class="row" style="margin-top: 10px;">
										<div class="col-sm-1">
											조건검색
										</div>
										<div class="col-sm-11">
											
												<select name="type" style="height: 25px;">
													<option value=""
														<c:out value="${pageMaker.cri.type == null? 'selected':'' }" />>--</option>
													<option value="N"
														<c:out value="${pageMaker.cri.type eq 'N'? 'selected':'' }" />>주문자</option>
												<option value="C"
														<c:out value="${pageMaker.cri.type eq 'C'? 'selected':'' }" />>주문번호</option>
													<!-- 
													<option value="W"
														<c:out value="${pageMaker.cri.type eq 'W'? 'selected':'' }" />>작성자</option>
													<option value="TC"
														<c:out value="${pageMaker.cri.type eq 'TC'? 'selected':'' }" />>제목 or 내용</option>
													<option value="TW"
														<c:out value="${pageMaker.cri.type eq 'TW'? 'selected':'' }" />>제목 or 작성자</option>
													<option value="TWC"
														<c:out value="${pageMaker.cri.type eq 'TWC'? 'selected':'' }" />>제목 or 작성자 or 내용</option>
									 				-->
												</select> 
												<input type="text" name="keyword" value="<c:out value="${ pageMaker.cri.keyword}" />">
												<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"> 
												<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
												<button class="btn btn-primary">Search</button>
											
										</div>
								</div>
								</form>
							</div>
							<div class="box-body">
								<div id="example2_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap">
									<div class="row">
										<div class="col-sm-6">총 주문건수 : ${ord_total }</div>
										<div class="col-sm-6"></div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<table id="orderlist"
												class="table table-bordered table-hover dataTable"
												role="grid" aria-describedby="example2_info">
												<thead>
													<tr role="row">
														<th><input type="checkbox" id="checkAll"
															name="checkAll"></th>
														<th>주문일</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Browser: activate to sort column ascending">주문번호</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Platform(s): activate to sort column ascending">주문자명</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">주문방법</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">주문금액</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">주문상태</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">기능</th>
													</tr>
												</thead>
												<tbody>

													<c:forEach items="${orderList }" var="orderVO"
														varStatus="status">
														<tr role="row"
															class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
															<td><input type="checkbox" class="check"
																value='<c:out value="${orderVO.ord_code }"></c:out>'>

															</td>
															<td class="sorting_1"><fmt:formatDate
																	value="${orderVO.ord_regdate }"
																	pattern="yyyy-MM-dd mm:hh" /></td>
															<td><a class="move"
																href="<c:out value="${orderVO.ord_code }"></c:out>">
																	${orderVO.ord_code } </a></td>
															<td><input type="text"
																value='<c:out value="${orderVO.ord_name }" />'>
															</td>
															<td>주문방법</td>
															<td><input type="text"
																value='<c:out value="${orderVO.ord_price }"></c:out>'></td>
															<td><select name="ord_state">
																	<option value=""
																		<c:out value="${orderVO.ord_state == null? 'selected':'' }" />>주문상태
																		선택</option>
																	<option value="주문접수"
																		<c:out value="${orderVO.ord_state eq '주문접수'? 'selected':'' }" />>주문접수</option>
																	<option value="결제완료"
																		<c:out value="${orderVO.ord_state eq '결제완료'? 'selected':'' }" />>결제완료</option>
																	<option value="배송준비중"
																		<c:out value="${orderVO.ord_state eq '배송준비중'? 'selected':'' }" />>배송준비중</option>
																	<option value="배송처리"
																		<c:out value="${orderVO.ord_state eq '배송처리'? 'selected':'' }" />>배송처리</option>
																	<option value="배송완료"
																		<c:out value="${orderVO.ord_state eq '배송완료'? 'selected':'' }" />>배송완료</option>
																	<option value="주문취소"
																		<c:out value="${orderVO.ord_state eq '주문취소'? 'selected':'' }" />>주문취소</option>
																	<option value="취소요청"
																		<c:out value="${orderVO.ord_state eq '취소요청'? 'selected':'' }" />>취소요청</option>
																	<option value="취소완료"
																		<c:out value="${orderVO.ord_state eq '취소완료'? 'selected':'' }" />>취소완료</option>
																	<option value="교환요청"
																		<c:out value="${orderVO.ord_state eq '교환요청'? 'selected':'' }" />>교환요청</option>
																	<option value="교환완료"
																		<c:out value="${orderVO.ord_state eq '교환완료'? 'selected':'' }" />>교환완료</option>
																	<option value="반품요청"
																		<c:out value="${orderVO.ord_state eq '반품요청'? 'selected':'' }" />>반품요청</option>
																	<option value="반품완료"
																		<c:out value="${orderVO.ord_state eq '반품완료'? 'selected':'' }" />>반품완료</option>
															</select></td>
															<td><input type="button" name="btnOrderStateChange"
																value="적용" data-ord_code="${orderVO.ord_code }">
																<input type="button" name="btnOrderDetail" value="상세보기"
																data-ord_code="${orderVO.ord_code }"></td>



														</tr>


													</c:forEach>
												</tbody>

											</table>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-5 dataTables_info">

											

											<!--
							<div class="dataTables_info" id="example2_info" role="status"
								aria-live="polite">Showing 1 to 10 of 57 entries</div>
								-->
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
										<form id="actionForm" action="/admin/order/orderList" method="get">
											<!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
											<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"> 
											<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
											<input type="hidden" name="type" value="${pageMaker.cri.type}">
											<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
											<input type="hidden" name="startDate" value="${startDate}">
											<input type="hidden" name="endDate" value="${endDate}">
											<!--주문상태정보추가-->
										</form>


									</div>
									<div class="row">
										<div class="col-sm-12">
											<input type="button" name="btnOrderStateAll" id="btnOrderStateAll" value="상태일괄변경">
											<input type="button" id="btnCheckDelete" value="선택삭제">
											<input type="button" id="btnExcelDownload" value="엑셀파일저장">
										</div>
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


										// 주문상태정보 추가
										actionForm.append("<input type='hidden' name='ord_state' value='${ord_state}'>");
										
										//날짜 정보 추가
										//actionForm.append("<input type='hidden' name='startDate' value='${startDate}'>");
										//actionForm.append("<input type='hidden' name='ord_state' value='${ord_state}'>");

										if('${ord_state}' != '') {
											actionForm.attr("action", "/admin/order/orderStateList");
										}
																				
										actionForm.submit();

									});

							//선택주문삭제
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
												let ord_codeArr = []; //주문번호 배열

												//선택된 체크박스 일 경우
												$(".check:checked")
														.each(
																function() {
																	let ord_code = $(
																			this)
																			.val();
																	ord_codeArr
																			.push(ord_code);

																})

												/*
												$("table tbody").find("동적").each(function() {

												});
												 */

												//console.log("상품코드: " + pro_numArr);
												//console.log("상품이미지: " + pro_imgArr);
												$
														.ajax({
															url : '/admin/order/checkDelete',
															type : 'post',
															dataType : 'text',
															data : {
																ord_codeArr : ord_codeArr
															},
															success : function(
																	data) {
																if (data == "success") {
																	alert("선택된 주문이 삭제됨");

																	// 리스트주소 이동 또는 선택된 행을 동적삭제.
																	//location.href= "/admin/order/checkDelete";  get방식

																	// post방식
																	actionForm
																			.attr(
																					"action",
																					"/admin/order/checkDelete");
																	actionForm
																			.attr(
																					"method",
																					"post");
																	actionForm
																			.submit();

																	console
																			.log($(".check:checked").length);
																	location.href = "/admin/order/orderList";
																	//테이블의 행을 의미하는 <tr>태그 제거.
																	/*
																	check:checked").each(function(){
																		$(this).parent().parent().remove();
																	});
																	 */
																}
															}
														});

											});

							//주문상세보기 btnOrderDetail
							$("input[name='btnOrderDetail']").on("click", function() {
												let tr = $(this).parent().parent();
												let ord_code = $(this).data("ord_code");

												tr.next(".tr_detail").remove();
												//상품상세내용을 가지고 있는 추가된 tr태그를 화면에서 사라지게 함
												$("#orderlist tr.tr_detail")
														.css("display", "none");
												// 선택한 주문상세 tr에 화면에 나타나게 함.
												tr.next(".tr_detail").css("dispaly", '');

												// tr태그를 하나추가
												tr.after("<tr class='tr_detail'><td colspan='8'></td></tr>");

												//let detailInfo = tr.find(".detailInfo"); 선택자 접근지원 안함.
												let detailInfo = tr.next().children("td"); // 생성된 tr태그의 td태그를 가리킴.
												//console.log("detailInfo: " + detailInfo.html());
												//detailInfo.html(""); // td태그의 내용을 빈문자열
												//detailInfo.empty();

												let url = "/admin/order/detailInfo?ord_code=" + ord_code;
												detailInfo.load(url);
											});

							//수정버튼 클릭시 -- 이거 나중에 뺴야함.
							$("input[name='btnProductModify']")
									.on(
											"click",
											function() {

												let pro_num = $(this).data(
														"pro_num");

												/*
												let url = "/admin/product/productModify?pro_num=" + pro_num;
												location.href = url;
												 */
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

												/*
												let url = "/admin/product/productModify?pro_num=" + pro_num;
												location.href = url;
												 */
												actionForm
														.attr("action",
																"/admin/product/productDelete");
												actionForm.attr("method",
														"post");
												actionForm
														.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
												actionForm.submit();

											});

							$("#btnOrderStateAll").on("click", function() {
												if ($(".check:checked").length == 0) {
													alert("주문상태변경 항목을 선택하세요.");
													return;
												}

												//자바스크립트 배열
												let ord_codeArr = []; //주문번호 배열
												let ord_StateArr = []; //주문상태 배열

												//선택된 체크박스 일 경우
												$(".check:checked").each( function() {
													let ord_code = $(
															this)
															.val();
													let ord_state = $(
															this)
															.parent()
															.parent()
															.find(
																	"select[name='ord_state']")
															.val();

													ord_codeArr
															.push(ord_code);
													ord_StateArr
															.push(ord_state);

												})

												console.log(ord_codeArr);
												console.log(ord_StateArr);

												$
														.ajax({
															url : '/admin/order/orderStateAll',
															type : 'post',
															dataType : 'text',
															data : {
																ord_codeArr : ord_codeArr,
																ord_StateArr : ord_StateArr
															},
															success : function(
																	data) {
																if (data == "success") {
																	alert("선택된 항목이 주문상태가 변경됨");
																	location.reload();
																}
															}
														});

											});
							
							// 셀렉트 변경시
							$("select[name='ord_state']").on("change", function() {
							// 셀렉트 박스가 변경되면 체크박스 선택 여부 변경
							let checkbox = $(this).closest("tr").find("input[type='checkbox']");
							checkbox.prop("checked", $(this).val() !== "");
							});

							//주문상태변경
							$("input[name='btnOrderStateChange']").on("click", function() {

												if ($(".check:checked").length == 0) {
													alert("주문상태변경 항목을 선택하세요.");
													return;
												}

												let ord_code = $(this).data(
														"ord_code");
												let ord_state = $(this)
														.parent()
														.parent()
														.find(
																"select[name='ord_state']")
														.val();

												console.log(ord_code + ","
														+ ord_state);

												//자바스크립트 배열
												let ord_codeArr = []; //주문번호 배열
												ord_codeArr.push(ord_code);
												let ord_StateArr = []; //주문상태 배열
												ord_StateArr.push(ord_state);

												$
														.ajax({
															url : '/admin/order/orderStateAll',
															type : 'post',
															dataType : 'text',
															data : {
																ord_codeArr : ord_codeArr,
																ord_StateArr : ord_StateArr
															},
															success : function(
																	data) {
																if (data == "success") {
																	alert("주문상태가 변경됨");
																	location.reload();
																}
															}
														});
											});




		// 주문진행상태별 목록보기
		$("input[name='btnOrdState']").on("click", function(){
			if($(this).data("ordstate") == "전체"){
				location.href = "/admin/order/orderList";
			}else{
				location.href = "/admin/order/orderStateList?ord_state=" + $(this).data("ordstate");
			}
		});	
		
		$("#btnExcelDownload").on("click", function(){
			let ord_state = "${ord_state}";
			
			if(ord_state == null || ord_state == ""){
				console.log("클릭");
				// 검색정보 가져오기
				let startDate = $("#searchForm").find("input[name='startDate']").val();
				let endDate = $("#searchForm").find("input[name='endDate']").val();
				let type = $("#actionForm").find("input[name='type']").val();
				let keyword = $("#searchForm").find("input[name='keyword']").val();
				console.log(type);
				console.log(keyword);
				console.log(startDate);
				console.log(endDate);
				
				
				location.href = "/admin/order/excelDown?startDate=" + startDate + "&endDate=" + endDate + "&type=" + type + "&keyword=" + keyword;
			}else{
				
				location.href = "/admin/order/excelDown?ord_state=" + ord_state;
			}
		});

						});
	</script>
</body>
</html>

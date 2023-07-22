<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.88.1">
<title>Pricing example · Bootstrap v4.6</title>

<link rel="canonical"
	href="https://getbootstrap.com/docs/4.6/examples/pricing/">
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

table.ck {
	margin-bottom: 7rem;
	color: #212529;
}
</style>

<!-- Custom styles for this template -->
<link href="/css/orderComplete.css" rel="stylesheet">
</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-sm-6">총 주문건수 : ${pageMaker.total }</div>
			<div class="col-sm-6"></div>
		</div>

		<c:set var="prev_ord_code" value="" />

		<!-- 한번만 출력 -->
		<div class="">
			<div id="" class="">
				<div class="row">
					<div class="col-sm-6"></div>
					<div class="col-sm-6"></div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<c:forEach items="${list}" var="listVO">
							<table id="orderlist"
								class="table table-bordered table-hover dataTable" role="grid"
								width="90%" aria-describedby="example2_info">
								<thead>
									<tr role="row">
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
											aria-label="Engine version: activate to sort column ascending">총
											주문금액</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Engine version: activate to sort column ascending">주문상태</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Engine version: activate to sort column ascending">주문변경</th>
									</tr>
								</thead>
								<tbody>
									<tr role="row"
										class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
										<td class="sorting_1"><fmt:formatDate
												value="${listVO.ord_regdate }" pattern="yyyy-MM-dd HH:mm" /></td>
										<td><a class="move"
											href="<c:out value="${listVO.ord_code }"></c:out>">
												${listVO.ord_code } </a></td>
										<td><c:out value="${listVO.ord_name }" /></td>
										<td>주문방법</td>
										<td><c:out value="${listVO.ord_price }"></c:out></td>
										<td class="cur_ord_state"><c:out
												value="${listVO.ord_state}" /></td>
										<td>
											<!-- 버튼 --> <c:if
												test="${listVO.ord_state eq '주문접수' || listVO.ord_state eq '결제완료'}">
												<button type="button" class="btn btn-outline-danger btn-sm"
													name="btnOrderCancel" data-ord_code="${listVO.ord_code }">취소</button>
											</c:if> <c:if
												test="${listVO.ord_state eq '배송준비중' || listVO.ord_state eq '배송중' || listVO.ord_state eq '배송완료'}">
												<button type="button" class="btn btn-outline-info btn-sm"
													name="btnOrderExchange" data-ord_code="${listVO.ord_code }">교환</button>
												<button type="button"
													class="btn btn-outline-secondary btn-sm"
													name="btnOrderReturn" data-ord_code="${listVO.ord_code }">반품</button>
											</c:if> <input type="hidden" name="ord_state"
											value="${listVO.ord_state}">
										</td>
									</tr>

									<c:if test="${listVO.ord_state eq '주문접수'}">
										<tr>
											<td colspan="8">계좌에 입금 해주세요 - [국민] 01122233-43-222222</td>
										</tr>
									</c:if>
								</tbody>
							</table>
							<!--  여기까지 한번만 출력 -->
							<!-- /.box-body -->

							<table class="table table-bordered table-hover dataTable ck"
								role="grid" width="90%">
								<thead>
									<tr role="row">
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="9"
											aria-label="Browser: activate to sort column ascending"
											style="text-align: center; color: red;">[주문상세내역]</th>
									</tr>
									<tr role="row">
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Browser: activate to sort column ascending">상품코드</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Browser: activate to sort column ascending">상품명</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Platform(s): activate to sort column ascending">상품이미지</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Engine version: activate to sort column ascending">주문가격</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="2"
											aria-label="Engine version: activate to sort column ascending">수량</th>
										<th class="sorting2" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="3"
											aria-label="Engine version: activate to sort column ascending">주문상태</th>
								</thead>

								<!-- 상품목록 -->
								<c:forEach items="${oDetailList}" var="oDetailVO">
									<tbody>
										<c:if test="${listVO.ord_code == oDetailVO.ord_code}">
											<tr role="row"
												class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
												<td><c:out value="${oDetailVO.pro_num }"></c:out></td>
												<td><c:out value="${oDetailVO.pro_name }" /></td>
												<td><a href="${oDetailVO.pro_num }" class="proDetail">
														<img name="proudctImage" width="100" height="100"
														src="/order/displayFile?fileName=s_<c:out value="${oDetailVO.pro_img }"></c:out>&uploadPath=<c:out value="${oDetailVO.pro_uploadpath }"></c:out>">
												</a></td>
												<td><c:out value="${oDetailVO.dt_ord_price }"></c:out></td>
												<td colspan="2"><c:out
														value="${oDetailVO.dt_ord_amount }"></c:out></td>
												<td rowspan="1" colspan="2" class="cur_ord_state">
													<p class="state_txt">${oDetailVO.ord_state }</p> <c:if
														test="${oDetailVO.ord_state eq '배송완료' || oDetailVO.ord_state eq '교환요청' || oDetailVO.ord_state eq '반품요청'}">
														<button type="button"
															class="review_btn btn btn-outline-info btn-sm"
															data-code="${oDetailVO.ord_code}"
															value="${oDetailVO.pro_num}">리뷰쓰기</button>
													</c:if> <c:forEach items="${reviewVO}" var="review">
														<c:if
															test="${review.ord_code == oDetailVO.ord_code && review.pro_num == oDetailVO.pro_num}">
															<button type="button"
																class="review_modify_btn btn btn-outline-success btn-sm"
																data-code="${oDetailVO.ord_code}"
																value="${oDetailVO.pro_num}">리뷰수정</button>
														</c:if>
													</c:forEach>
												</td>
											</tr>
										</c:if>
									</tbody>
								</c:forEach>
							</table>
						</c:forEach>

						<!-- 페이징 -->
						<div class="dataTables_paginate paging_simple_numbers"
							id="example2_paginate">
							<ul class="pagination">
								<c:if test="${pageMaker.prev }">
									<li
										class='paginate_button previous ${pageMaker.prev ? "": "disabled" }'
										id="example2_previous"><a
										href="${pageMaker.startPage - 1}" aria-controls="example2"
										data-dt-idx="0" tabindex="0"><</a></li>
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
										data-dt-idx="7" tabindex="0">></a></li>
								</c:if>
							</ul>
						</div>

						<!--prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
						<form id="actionForm" action="/order/orderComplete" method="get">
							<!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
							<input type="hidden" name="pageNum"
								value="${pageMaker.cri.pageNum}"> <input type="hidden"
								name="amount" value="${pageMaker.cri.amount}">
						</form>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-5 dataTables_info"></div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>

</body>

<script>
	//리뷰쓰기 클릭시
	$(".review_btn")
			.on(
					"click",
					function() {
						let pro_num = $(this).val();
						let ord_code = $(this).data("code");

						//location.href = "/review/reviewWrite?pro_num=" + pro_num + "&ord_code=" + ord_code;
						let actionForm = $("#actionForm");
						actionForm
								.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
						actionForm
								.append("<input type='hidden' name='ord_code' value='" + ord_code + "'>");
						actionForm.attr("action", "/review/reviewWrite");

						actionForm.submit();

					});

	//리뷰수정 클릭시    
	$(".review_modify_btn")
			.on(
					"click",
					function() {
						let pro_num = $(this).val();
						let ord_code = $(this).data("code");

						//location.href = "/review/reviewModify?pro_num=" + pro_num + "&ord_code=" + ord_code;

						let actionForm = $("#actionForm");
						actionForm
								.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
						actionForm
								.append("<input type='hidden' name='ord_code' value='" + ord_code + "'>");

						actionForm.attr("action", "/review/reviewModify");

						actionForm.submit();

					});

	$(function() {
		$('td:has(.review_btn):has(.review_modify_btn)').find('.review_btn')
				.hide();
	});

	// *페이지 번호 클릭시 동작. previous, page number, next 에 해당하는 <a>태그 선택
	$(".paginate_button a").on("click", function(e) {
		e.preventDefault();
		let num = $(this).attr("href");
		console.log("click: " + num);

		let actionForm = $("#actionForm");
		actionForm.find("input[name='pageNum']").val(num);

		actionForm.submit();
	});

	// 취소버튼 클릭시
	$('button[name="btnOrderCancel"]').on('click', function() {

		//현재 주문 상태    	
		let old_ord_state = $(this).siblings("input[name='ord_state']").val();
		console.log(old_ord_state);

		let ord_code = $(this).data('ord_code');
		let ord_state = "취소요청";
		if (!confirm('주문 상품을 취소하시겠습니까?')) {
			// "아니요"를 클릭한 경우
			return;
		}

		if (old_ord_state == "배송완료") {
			alert("배송완료 상태입니다. 교환이나 반품신청을 해주세요.");
			return;
		}

		$.ajax({
			url : '/order/orderStateChange',
			type : 'post',
			dataType : 'text',
			data : {
				ord_code : ord_code,
				ord_state : ord_state
			},
			success : function(data) {
				if (data == "success") {
					alert("주문 상품을 취소 요청 하였습니다.");
					location.reload();
				}
			}
		});
	});

	// 교환버튼 클릭시
	$("button[name='btnOrderExchange']").on("click", function() {
		//현재 주문 상태
		let old_ord_state = $(this).siblings("input[name='ord_state']").val();
		console.log(old_ord_state);

		let ord_code = $(this).data('ord_code');
		let ord_state = "교환요청";
		if (!confirm('주문을 교환 하시겠습니까?')) {
			// "아니요"를 클릭한 경우
			return;
		}

		if (old_ord_state == "주문접수") {
			alert("배송완료 상태가 아닙니다. 상품취소를 해주세요.");
			return;
		}

		$.ajax({
			url : '/order/orderStateChange',
			type : 'post',
			dataType : 'text',
			data : {
				ord_code : ord_code,
				ord_state : ord_state
			},
			success : function(data) {
				if (data == "success") {
					alert("주문 상품을 교환 요청 하였습니다.");
					location.reload();
				}
			}
		});
	});

	// 반품버튼 클릭시
	$("button[name='btnOrderReturn']").on("click", function() {

		//현재 주문 상태
		let old_ord_state = $(this).siblings("input[name='ord_state']").val();
		console.log(old_ord_state);

		let ord_code = $(this).data('ord_code');
		let ord_state = "반품요청";

		if (!confirm('주문을 반품 하시겠습니까?')) {
			// "아니요"를 클릭한 경우
			return;
		}

		if (old_ord_state == "주문접수") {
			alert("배송완료 상태가 아닙니다. 상품취소를 해주세요.");
			return;
		}

		$.ajax({
			url : '/order/orderStateChange',
			type : 'post',
			dataType : 'text',
			data : {
				ord_code : ord_code,
				ord_state : ord_state
			},
			success : function(data) {
				if (data == "success") {
					alert("주문 상품을 반품 요청 하였습니다.");
					location.reload();
				}
			}
		});
	});

	//상품 상세페이지 이동
	$("a.proDetail").on("click", function(e) {
		e.preventDefault();
		let pro_num = $(this).attr("href");
		location.href = "/product/productDetail?pro_num=" + pro_num;
	});
</script>

</html>

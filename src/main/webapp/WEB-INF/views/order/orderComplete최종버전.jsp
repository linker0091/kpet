<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Pricing example · Bootstrap v4.6</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="pricing.css" rel="stylesheet">
  </head>
  <body>
    
<%@include file="/WEB-INF/views/user/include/header.jsp" %>

<!-- 
<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  <h1 class="display-4">Pricing</h1>
  <p class="lead">Quickly build an effective pricing table for your potential customers with this Bootstrap example. It’s built with default Bootstrap components and utilities with little customization.</p>
</div>
 -->
<div class="container">
  
  <h5>결제하기</h5>
  <div class="row">
	<div class="col-sm-12">
   		<h4>결제완료</h4>
  	</div>
  </div>  
  <%--
<c:set var="prev_ord_code" value="" />

<c:forEach items="${orderList}" var="order">
  <c:if test="${order.ord_code ne prev_ord_code}">
	
	
		
	
  
  
	<div class="box-body">
		<div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
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

							<c:forEach items="${orderList }" var="orderVO" varStatus="status">
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
									</select></td>
									<td><input type="button" name="btnOrderStateChange"
										value="적용" data-ord_code="${orderVO.ord_code }">
										<input type="button" name="btnOrderDetail" value="상세보기"
										data-ord_code="${orderVO.ord_code }"></td>
								</tr>
								<!--  여기까지 한번만 출력 -->
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
			</div>
		</div>
	</div>
	<!-- /.box-body -->
	</c:if> <!-- 공통 끝 END -->
	<c:if test="${order.ord_code ne prev_ord_code}">
	<table id="ord_detailInfo" class="table table-bordered table-hover dataTable" style="width: 80%;margin-left: auto; margin-right: auto" role="grid" aria-describedby="example2_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="6"
				aria-label="Browser: activate to sort column ascending" style="text-align: center;color: red;">[주문상세내역]</th>										
		</tr>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Browser: activate to sort column ascending">상품코드</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Browser: activate to sort column ascending">상품이미지</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Platform(s): activate to sort column ascending">상품명</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">주문가격</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">수량</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">기능</th>														
		</tr>
	</thead>
    <tbody>
<!-- 여기위에는 ord_code가 다를때만 돌리고싶어 -->
	
	<tr role="row"
		class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
		<td>
			<a class="move" href="<c:out value="${oDetailVO.pro_num }"></c:out>">${oDetailVO.pro_num }</a>
			<br>
			<a class="move" href="<c:out value="${oDetailVO.ord_code }"></c:out>">${oDetailVO.ord_code }</a>
		</td>
		<td>
			<input type="text" value='<c:out value="${oDetailVO.pro_name }" />'>
		</td>
		<td>
			<img name="proudctImage" width="100" height="100" src="/order/displayFile?fileName=s_<c:out value="${oDetailVO.pro_img }"></c:out>&uploadPath=<c:out value="${oDetailVO.pro_uploadpath }"></c:out>">
		</td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_price }"></c:out>'></td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_amount }"></c:out>'></td>
		<td>
			<input type="button" name="btnOrderStateChange" value="취소" data-ord_code="${oDetailVO.ord_code }">
			
			
		</td>
	</tr>
	
	<td><input type="text" value='<c:out value="${oDetailVO.ord_regdate}"></c:out>'></td>
	<!-- 주문상태 -->
	<c:out value="${oDetailVO.ord_state}" />
	<td>총주문금액</td>
	<td><input type="text" value='<c:out value="${oDetailVO.ord_price }"></c:out>'></td>

</tbody>

</table>
	
	
	 </c:if>
  <c:set var="prev_ord_code" value="${order.ord_code}" />
</c:forEach>
  <!-- 여기까지 씌우기. -->
   --%>
  
  
  
  <!-- -   2번 시작  -->
  
  
  
  
<c:set var="prevOrdCode" value="" />
<c:forEach items="${oDetailList }" var="oDetailVO" varStatus="status">
  <c:if test="${oDetailVO.ord_code ne prevOrdCode}">
    <!-- 주문상세내역 테이블을 한번만 출력 -->
    <div class="box-body">
		<div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
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
						
								<tr role="row"
									class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
									<td><input type="checkbox" class="check"
										value='<c:out value="${oDetailVO.ord_code }"></c:out>'>

									</td>
									<td class="sorting_1"><fmt:formatDate
											value="${oDetailVO.ord_regdate }"
											pattern="yyyy-MM-dd mm:hh" /></td>
									<td><a class="move"
										href="<c:out value="${oDetailVO.ord_code }"></c:out>">
											${oDetailVO.ord_code } </a></td>
									<td><input type="text"
										value='<c:out value="${oDetailVO.ord_name }" />'>
									</td>
									<td>주문방법</td>
									<td><input type="text"
										value='<c:out value="${oDetailVO.ord_price }"></c:out>'></td>
									<td><c:out value="${oDetailVO.ord_state}" /></td>
									<td><input type="button" name="btnOrderStateChange"
										value="적용" data-ord_code="${oDetailVO.ord_code }">
										<input type="button" name="btnOrderDetail" value="상세보기"
										data-ord_code="${oDetailVO.ord_code }"></td>
								</tr>
								<!--  여기까지 한번만 출력 -->
							
							
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
			</div>
		</div>
	</div>
	<!-- /.box-body -->
	<table id="ord_detailInfo" class="table table-bordered table-hover dataTable" style="width: 80%;margin-left: auto; margin-right: auto" role="grid" aria-describedby="example2_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="6"
				aria-label="Browser: activate to sort column ascending" style="text-align: center;color: red;">[주문상세내역]</th>										
		</tr>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Browser: activate to sort column ascending">상품코드</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Browser: activate to sort column ascending">상품이미지</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Platform(s): activate to sort column ascending">상품명</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">주문가격</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">수량</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">기능</th>														
		</tr>
	</thead>
	</table>
    <tbody>
  </c:if>
  <!-- 주문상세내역의 한 행씩 출력 (중복부분) -->
  <table id="ord_detailInfo" class="table table-bordered table-hover dataTable" style="width: 80%;margin-left: auto; margin-right: auto" role="grid" aria-describedby="example2_info">
	
    <tbody>
	
	<tr role="row" class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
		<td>
			<a class="move" href="<c:out value="${oDetailVO.pro_num }"></c:out>">${oDetailVO.pro_num }</a>
			<br>
			<a class="move" href="<c:out value="${oDetailVO.ord_code }"></c:out>">${oDetailVO.ord_code }</a>
		</td>
		<td>
			<input type="text" value='<c:out value="${oDetailVO.pro_name }" />'>
		</td>
		<td>
			<img name="proudctImage" width="100" height="100" src="/order/displayFile?fileName=s_<c:out value="${oDetailVO.pro_img }"></c:out>&uploadPath=<c:out value="${oDetailVO.pro_uploadpath }"></c:out>">
		</td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_price }"></c:out>'></td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_amount }"></c:out>'></td>
		<td>
			<input type="button" name="btnOrderStateChange" value="취소" data-ord_code="${oDetailVO.ord_code }">
			
			
		</td>
	</tr>
	
	<td class="sorting_1"><fmt:formatDate value="${oDetailVO.ord_regdate }" pattern="yyyy-MM-dd mm:hh" /></td>
	<!-- 주문상태 -->
	
	<td>총주문금액</td>
	<td><input type="text" value='<c:out value="${oDetailVO.ord_price }"></c:out>'></td>

</tbody>

</table>
  <c:set var="prev_ord_code" value="${oDetailVO.ord_code}" />
</c:forEach>
  
  
  
  
  
  
  <%-- 
<!-- 주문완료테이블 -->
<c:forEach items="${oDetailList }" var="oDetailVO" varStatus="status">
<table id="ord_detailInfo" class="table table-bordered table-hover dataTable" style="width: 80%;margin-left: auto; margin-right: auto" role="grid" aria-describedby="example2_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="6"
				aria-label="Browser: activate to sort column ascending" style="text-align: center;color: red;">[주문상세내역]</th>										
		</tr>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Browser: activate to sort column ascending">상품코드</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Browser: activate to sort column ascending">상품이미지</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Platform(s): activate to sort column ascending">상품명</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">주문가격</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">수량</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">기능</th>														
		</tr>
	</thead>
    <tbody>
<!-- 여기위에는 ord_code가 다를때만 돌리고싶어 -->
	
	<tr role="row"
		class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
		<td>
			<a class="move" href="<c:out value="${oDetailVO.pro_num }"></c:out>">${oDetailVO.pro_num }</a>
			<br>
			<a class="move" href="<c:out value="${oDetailVO.ord_code }"></c:out>">${oDetailVO.ord_code }</a>
		</td>
		<td>
			<input type="text" value='<c:out value="${oDetailVO.pro_name }" />'>
		</td>
		<td>
			<img name="proudctImage" width="100" height="100" src="/order/displayFile?fileName=s_<c:out value="${oDetailVO.pro_img }"></c:out>&uploadPath=<c:out value="${oDetailVO.pro_uploadpath }"></c:out>">
		</td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_price }"></c:out>'></td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_amount }"></c:out>'></td>
		<td>
			<input type="button" name="btnOrderStateChange" value="취소" data-ord_code="${oDetailVO.ord_code }">
			
			
		</td>
	</tr>
	
	<td><input type="text" value='<c:out value="${oDetailVO.ord_regdate}"></c:out>'></td>
	<!-- 주문상태 -->
	<c:out value="${oDetailVO.ord_state}" />
	<td>총주문금액</td>
	<td><input type="text" value='<c:out value="${oDetailVO.ord_price }"></c:out>'></td>

</tbody>

</table>
</c:forEach>
  <!-- 주문완료테이블 END -->
  --%>


</div>

<h2>테스트</h2>

<c:set var="prev_ord_code" value="" />

<c:forEach items="${oDetailList}" var="oDetailVO">
  <c:if test="${oDetailVO.ord_code ne prev_ord_code}">
  	<!-- 한번만 출력 -->
    <div class="box-body">
		<div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
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
						
								<tr role="row"
									class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
									<td><input type="checkbox" class="check"
										value='<c:out value="${oDetailVO.ord_code }"></c:out>'>

									</td>
									<td class="sorting_1"><fmt:formatDate
											value="${oDetailVO.ord_regdate }"
											pattern="yyyy-MM-dd mm:hh" /></td>
									<td><a class="move"
										href="<c:out value="${oDetailVO.ord_code }"></c:out>">
											${oDetailVO.ord_code } </a></td>
									<td><input type="text"
										value='<c:out value="${oDetailVO.ord_name }" />'>
									</td>
									<td>주문방법</td>
									<td><input type="text"
										value='<c:out value="${oDetailVO.ord_price }"></c:out>'></td>
									<td><c:out value="${oDetailVO.ord_state}" /></td>
									<td><input type="button" name="btnOrderStateChange"
										value="적용" data-ord_code="${oDetailVO.ord_code }">
										<input type="button" name="btnOrderDetail" value="상세보기"
										data-ord_code="${oDetailVO.ord_code }"></td>
								</tr>
								<!--  여기까지 한번만 출력 -->
							
							
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
			</div>
		</div>
	</div>
	<!-- /.box-body -->
	<table id="ord_detailInfo" class="table table-bordered table-hover dataTable" style="width: 80%;margin-left: auto; margin-right: auto" role="grid" aria-describedby="example2_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="6"
				aria-label="Browser: activate to sort column ascending" style="text-align: center;color: red;">[주문상세내역]</th>										
		</tr>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Browser: activate to sort column ascending">상품코드</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Browser: activate to sort column ascending">상품이미지</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Platform(s): activate to sort column ascending">상품명</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">주문가격</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">수량</th>
			<th class="sorting" tabindex="0" aria-controls="example2"
				rowspan="1" colspan="1"
				aria-label="Engine version: activate to sort column ascending">기능</th>														
		</tr>
	</thead>
	</table>
    <tbody>
  </c:if>
  <c:if test="${oDetailVO.ord_code ne prev_ord_code}">
    </ul>
  </c:if>
  <!-- 상품목록 -->
  <table id="ord_detailInfo" class="table table-bordered table-hover dataTable" style="width: 80%;margin-left: auto; margin-right: auto" role="grid" aria-describedby="example2_info">
	
    <tbody>
	
	<tr role="row" class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
		<td>
			<a class="move" href="<c:out value="${oDetailVO.pro_num }"></c:out>">${oDetailVO.pro_num }</a>
			<br>
			<a class="move" href="<c:out value="${oDetailVO.ord_code }"></c:out>">${oDetailVO.ord_code }</a>
		</td>
		<td>
			<input type="text" value='<c:out value="${oDetailVO.pro_name }" />'>
		</td>
		<td>
			<img name="proudctImage" width="100" height="100" src="/order/displayFile?fileName=s_<c:out value="${oDetailVO.pro_img }"></c:out>&uploadPath=<c:out value="${oDetailVO.pro_uploadpath }"></c:out>">
		</td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_price }"></c:out>'></td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_amount }"></c:out>'></td>
		<td>
			<input type="button" name="btnOrderStateChange" value="취소" data-ord_code="${oDetailVO.ord_code }">
			
			
		</td>
	</tr>
	
	<td class="sorting_1"><fmt:formatDate value="${oDetailVO.ord_regdate }" pattern="yyyy-MM-dd mm:hh" /></td>
	<!-- 주문상태 -->
	
	<td>총주문금액</td>
	<td><input type="text" value='<c:out value="${oDetailVO.ord_price }"></c:out>'></td>

</tbody>

</table>
  
  <c:set var="prev_ord_code" value="${oDetailVO.ord_code}" />
</c:forEach>


<%--
<c:set var="prev_ord_code" value="" />

<c:forEach items="${oDetailList}" var="order">
  <c:if test="${order.ord_code ne prev_ord_code}">
    <h2>제목 (${order.ord_code})</h2>
    <ul>
  </c:if>
  <c:if test="${order.ord_code ne prev_ord_code}">
    </ul>
  </c:if>
  <li>상품목록 (${order.ord_code})</li>
  <img name="proudctImage" width="100" height="100" src="/order/displayFile?fileName=s_<c:out value="${order.pro_img }"></c:out>&uploadPath=<c:out value="${order.pro_uploadpath }"></c:out>">
  
  <c:set var="prev_ord_code" value="${order.ord_code}" />
</c:forEach>
  --%>

<%--
<c:forEach items="${oDetailList}" var="order">
  <c:if test="${order.ord_code == prev_ord_code}">
    <!-- ord_code가 이전과 같은 경우에는 상품 정보 출력 -->
    <p>${order.product_name} - ${order.price}</p>
  </c:if>
  <c:if test="${order.ord_code != prev_ord_code}">
    <!-- ord_code가 이전과 다른 경우에는 새로운 주문코드 출력 -->
    <h3>주문코드: ${order.ord_code}</h3>
    <p>${order.product_name} - ${order.price}</p>
  </c:if>
  <!-- 이전 ord_code 값을 저장 -->
  <c:set var="prev_ord_code" value="${order.ord_code}" />
</c:forEach>
--%>


  <%@include file="/WEB-INF/views/user/include/footer.jsp" %>


  </body>
  
  
</html>

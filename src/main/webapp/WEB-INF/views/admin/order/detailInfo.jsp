<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


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

	<c:forEach items="${oDetailList }" var="oDetailVO" varStatus="status">
	<tr role="row"
		class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
		<td>
			<a class="move" href="<c:out value="${oDetailVO.pro_num }"></c:out>">${oDetailVO.pro_num }</a>
		</td>
		<td>
			<input type="text" value='<c:out value="${oDetailVO.pro_name }" />'>
		</td>
		<td>
			<img name="proudctImage" width="100" height="100" src="/admin/order/displayFile?fileName=s_<c:out value="${oDetailVO.pro_img }"></c:out>&uploadPath=<c:out value="${oDetailVO.pro_uploadpath }"></c:out>">
		</td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_price }"></c:out>'></td>
		<td><input type="text" value='<c:out value="${oDetailVO.dt_ord_amount }"></c:out>'></td>
		<td>
			<input type="button" name="btnOrderStateChange" value="취소" data-ord_code="${oDetailVO.ord_code }">
			
		</td>
	</tr>


</c:forEach>
</tbody>

</table>

<script>

	$(document).ready(function(){
		$("input[name='btnOrderStateChange']").on("click", function(){
			
			let tr = $(this).parent().parent();
			let ord_code = $(this).data("ord_code");
			let pro_num = $(this).parent().parent().find("a.move").text();

			console.log(ord_code);
			console.log(pro_num);

			$.ajax({
				url: '/admin/order/detailListDelete',
				type:'post',
				dataType: 'text',
				data:  {
					ord_code : ord_code,
					pro_num : pro_num
				},
				success: function(data){
					if(data == "success") {
						alert("주문을 취소하였음.");

						tr.remove();
						
						
					}
				}
			});
		});
	});

</script>

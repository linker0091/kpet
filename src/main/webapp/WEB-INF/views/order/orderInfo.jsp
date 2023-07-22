<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

#btn_kakaopay {
	opacity: 0.8;
}

#btn_kakaopay:hover {
	opacity: 1;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.row .container h3 {
	width: 80%;
	font-size: 30px;
	margin-bottom: 30px;
}

#example2 input {
	border: none;
	outline: none;
}

.form-row input, textarea {
	border-radius: 5px;
	border: 1px solid #dee2e6;
	padding: 10px 11px 10px 10px;
	color: #757575;
	margin: 5px;
}

.row .container h5 {
	width: 80%;
	font-size: 15px;
	margin-top: 20px;
	margin-bottom: 30px;
	font-weight: bolder;
}
</style>


<!-- Custom styles for this template -->
<link href="pricing.css" rel="stylesheet">
</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>

	<div class="row">
		<div class="container">
			<h3>주문내역</h3>
			<div class="col-sm-12">
				<form action="/order/orderAction" method="post" id="orderForm">
					<table id="example2" class="table table-bordered dataTable"
						role="grid" aria-describedby="example2_info">
						<thead>
							<tr role="row">
								<th class="sorting" tabindex="0" aria-controls="example2"
									rowspan="1" colspan="1"
									aria-label="Browser: activate to sort column ascending">상품이미지</th>
								<th class="sorting" tabindex="0" aria-controls="example2"
									rowspan="1" colspan="1"
									aria-label="Browser: activate to sort column ascending">상품명</th>
								<th class="sorting" tabindex="0" aria-controls="example2"
									rowspan="1" colspan="1"
									aria-label="Engine version: activate to sort column ascending">수량</th>
								<th class="sorting" tabindex="0" aria-controls="example2"
									rowspan="1" colspan="1"
									aria-label="Platform(s): activate to sort column ascending">주문가격</th>
								<th class="sorting" tabindex="0" aria-controls="example2"
									rowspan="1" colspan="1"
									aria-label="Engine version: activate to sort column ascending">합계</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty orderInfo}">
								<tr role="row">
									<td colspan="5">주문정보가 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty orderInfo}">
								<c:forEach items="${orderInfo }" var="orderInfoVO"
									varStatus="status">
									<tr role="row"
										class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if>">
										<td><a class="move"
											href="<c:out value="${orderInfoVO.pro_num }"></c:out>"> <img
												name="proudctImage"
												src="/order/displayFile?fileName=s_<c:out value="${orderInfoVO.pro_img }"></c:out>&uploadPath=<c:out value="${orderInfoVO.pro_uploadpath }"></c:out>">
										</a></td>
										<td><input type="text" id="pro_name"
											value='<c:out value="${orderInfoVO.pro_name }"></c:out>'
											readonly> <input type="hidden"
											name="orderDetailList[${status.index }].pro_num"
											value='<c:out value="${orderInfoVO.pro_num }"></c:out>'>
										</td>
										<td><input type="text"
											name="orderDetailList[${status.index }].dt_ord_amount"
											value='<c:out value="${orderInfoVO.cart_amount }"></c:out>'
											readonly></td>
										<td><input type="text"
											value='<c:out value="${orderInfoVO.pro_discount }"></c:out>'>
										</td>
										<td><input type="text" class="order_price"
											name="orderDetailList[${status.index }].dt_ord_price"
											value='<c:out value="${orderInfoVO.orderprice }"></c:out>'>
										</td>
									</tr>
								</c:forEach>
								<tr>
									<td colspan="5">주문 총합계 : <input type="text"
										name="ord_price" id="ord_price" readonly></td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<br>
					<c:if test="${not empty orderInfo}">
						<h5>주문자정보</h5>
						<hr>
						<div class="form-row">
							<div class="col-md-2">
								<label for="user_name">이름</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 500px" id="user_name"
									name="user_name" value="${sessionScope.loginStatus.user_name}"
									readonly>
							</div>
							<div class="col-md-2">
								<label for="user_email">이메일</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 500px" id="user_email"
									name="user_email"
									value="${sessionScope.loginStatus.user_email}">
							</div>
							<div class="col-md-2">
								<label for="user_phone">연락처</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 500px" id="user_phone"
									name="user_phone"
									value="${sessionScope.loginStatus.user_phone}">
							</div>
							<div class="col-md-2">
								<label for="user_postcode">우편번호</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 250px" id="user_postcode"
									name="user_postcode"
									value="${sessionScope.loginStatus.user_postcode}">
							</div>
							<div class="col-md-2">
								<label for="user_addr">주소</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 250px" id="user_addr"
									name="user_addr" value="${sessionScope.loginStatus.user_addr}">
								- <input type="text" style="width: 250px" id="user_deaddr"
									name="user_deaddr"
									value="${sessionScope.loginStatus.user_deaddr}">
							</div>
						</div>
						<br>
						<h5>배송 정보</h5>
						<input type="checkbox" id="orderInfoCopy">위정보와 같음
            <hr>
						<div class="form-row">
							<div class="col-md-2">
								<label for="ord_name">이름</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 250px" id="ord_name"
									name="ord_name">
							</div>
							<div class="col-md-2">
								<label for="ord_phone">연락처</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 250px" id="ord_phone"
									name="ord_phone">
							</div>
							<div class="col-md-2">
								<label for="ord_postcode">우편번호</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 250px" id="ord_postcode"
									name="ord_postcode">
							</div>
							<div class="col-md-2">
								<label for="ord_addr_basic">주소</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 250px" id="ord_addr_basic"
									name="ord_addr_basic"> - <input type="text"
									style="width: 250px" id="ord_addr_detail"
									name="ord_addr_detail">
							</div>
							<div class="col-md-2">
								<label for="ord_message">배송메세지<br>(100자내외)
								</label>
							</div>
							<div class="col-md-10">
								<textarea rows="3" style="width: 100%" name="ord_message"
									id="ord_message"></textarea>
							</div>
							<div class="col-md-2">
								<label for="ord_depositor">무통장 입금자명</label>
							</div>
							<div class="col-md-10">
								<input type="text" style="width: 250px;" id="ord_depositor"
									name="ord_depositor">(주문자와 같을경우 생략가능)
								<!-- ord_state -->
								<input type="hidden" name="ord_state" value="주문접수">
							</div>
							<div class="col-md-12">
								<input type="button" class="ord_btn"
									style="width: 250px; height: 47px; margin: 42px 10px;"
									value="주문하기"> <img
									src="/resources/img/payment_icon_yellow_small.png"
									id="btn_kakaopay"
									style="cursor: pointer; width: 250px; margin: 42px 10px;">
								<input type="button" class="orderCancel"
									style="width: 250px; height: 47px; margin: 42px 10px;"
									value="주문취소">
							</div>
						</div>
					</c:if>
				</form>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>
	<script>

  $(document).ready(function(){
    //주문하기 수정*
      $(".ord_btn").on("click", function(){
        let ord_name = $('input[name="ord_name"]').val();
        let ord_phone = $('input[name="ord_phone"]').val();
        let ord_addr_basic = $('input[name="ord_addr_basic"]').val();
        let ord_addr_detail = $('input[name="ord_addr_detail"]').val();

          if(ord_name == "" || ord_name == null){
              alert("이름을 입력하세요.");
              return;
            }
          if(ord_phone == "" || ord_phone == null){
              alert("연락처를 입력하세요.");
              return;
            }
          if(ord_addr_basic == "" || ord_addr_basic == null){
              alert("주소를 입력하세요.");
              return;
            }
          if(ord_addr_detail == "" || ord_addr_detail == null){
              alert("상세주소를 입력하세요.");
              return;
            }
            
        $("#orderForm").submit();
      }); 
    
    
      //주문취소
      $(".orderCancel").click(function () {
        location.href="http://localhost:8888/cart/cartList"
      });
      
    //카카오페이결제
    $("#btn_kakaopay").click(function () {
      let pro_name = $("#pro_name").val();
      let ord_price = $("#ord_price").val();
      let ord_name = $("#ord_name").val();
      let ord_postcode = $("#ord_postcode").val();
      
      var IMP = window.IMP; // 생략가능
      IMP.init('imp66873418'); 
      // i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
      // ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
      IMP.request_pay({
        pg: 'kakaopay',
        pay_method: 'card',
        merchant_uid: 'merchant_' + new Date().getTime(),
        /* 
        *  merchant_uid에 경우 
        *  https://docs.iamport.kr/implementation/payment
        *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
        */
        name: pro_name,//'주문명 : 아메리카노',
        // 결제창에서 보여질 이름
        // name: '주문명 : ${auction.a_title}',
        // 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
        amount: ord_price,
        // amount: ${bid.b_bid},
        // 가격 
        buyer_name: ord_name,
        // 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
        // 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
        buyer_postcode: ord_postcode,
        }, function (rsp) {
          console.log(rsp);
        if (rsp.success) {
          var msg = '결제가 완료되었습니다.';
          msg += '결제 금액 : ' + rsp.paid_amount;
          $("input[name=ord_state]").val("결제완료");
          $("input[name=ord_depositor]").val("kakao");
          $('#orderForm').submit();
          // 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
          // 자세한 설명은 구글링으로 보시는게 좋습니다.
        } else {
          var msg = '결제에 실패하였습니다.';
          msg += '에러내용 : ' + rsp.error_msg;
        }
        alert(msg);
      });
    });
        
      
    // 주문 전체금액
      let orderTotalPrice = function() {

      let totalPrice = 0;
      $(".order_price").each(function(){
        totalPrice += parseInt($(this).val());
      });

      $("input[name=ord_price]").val(totalPrice);

    }

    orderTotalPrice();

    // 주문자정보 복사
    $("#orderInfoCopy").on("click", function(){
        $("#ord_name").val($("#user_name").val());
        $("#ord_phone").val($("#user_phone").val());

        $("#ord_addr_basic").val($("#user_addr").val());
        $("#ord_addr_detail").val($("#user_deaddr").val());
        $("#ord_postcode").val($("#user_postcode").val());
    });
    

  });


  </script>

	<!--우편번호 DAUM API-->
	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
	<div id="layer"
		style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
			id="btnCloseLayer"
			style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
			onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
      // 우편번호 찾기 화면을 넣을 element
      var element_layer = document.getElementById('layer');

      function closeDaumPostcode() {
          // iframe을 넣은 element를 안보이게 한다.
          element_layer.style.display = 'none';
      }

      function sample2_execDaumPostcode() {
          new daum.Postcode({
              oncomplete: function(data) {
                  // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var addr = ''; // 주소 변수
                  var extraAddr = ''; // 참고항목 변수

                  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                      addr = data.roadAddress;
                  } else { // 사용자가 지번 주소를 선택했을 경우(J)
                      addr = data.jibunAddress;
                  }

                  // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                  if(data.userSelectedType === 'R'){
                      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                          extraAddr += data.bname;
                      }
                      // 건물명이 있고, 공동주택일 경우 추가한다.
                      if(data.buildingName !== '' && data.apartment === 'Y'){
                          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                      }
                      // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                      if(extraAddr !== ''){
                          extraAddr = ' (' + extraAddr + ')';
                      }
                      // 조합된 참고항목을 해당 필드에 넣는다.
                      document.getElementById("sample2_extraAddress").value = extraAddr;
                  
                  } else {
                      document.getElementById("sample2_extraAddress").value = '';
                  }

                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('user_postcode').value = data.zonecode;
                  document.getElementById("user_addr").value = addr;
                  // 커서를 상세주소 필드로 이동한다.
                  document.getElementById("user_deaddr").focus();

                  // iframe을 넣은 element를 안보이게 한다.
                  // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                  element_layer.style.display = 'none';
              },
              width : '100%',
              height : '100%',
              maxSuggestItems : 5
          }).embed(element_layer);

          // iframe을 넣은 element를 보이게 한다.
          element_layer.style.display = 'block';

          // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
          initLayerPosition();
      }

      // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
      // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
      // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
      function initLayerPosition(){
          var width = 300; //우편번호서비스가 들어갈 element의 width
          var height = 400; //우편번호서비스가 들어갈 element의 height
          var borderWidth = 5; //샘플에서 사용하는 border의 두께

          // 위에서 선언한 값들을 실제 element에 넣는다.
          element_layer.style.width = width + 'px';
          element_layer.style.height = height + 'px';
          element_layer.style.border = borderWidth + 'px solid';
          // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
          element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
          element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
      }
  </script>

</body>
</html>

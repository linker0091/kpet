<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<!-- <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script> -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
   		<img src="/resources/img/payment_icon_yellow_medium.png" id="btn_kakaopay" style="cursor:pointer;">
  	</div>
  </div>  
  


</div>
  <%@include file="/WEB-INF/views/user/include/footer.jsp" %>

<script>
  
//카카오결제
	$(function(){
		
		//카카오페이결제
		$("#btn_kakaopay").click(function () {
			var IMP = window.IMP; // 생략가능
			IMP.init('imp66873418'); 
			// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
			// ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
			IMP.request_pay({
				pg: 'kakaopay',
				//pg : 'kcp.{TC0ONETIME}',
				pay_method: 'card',
				merchant_uid: 'merchant_' + new Date().getTime(),
				/* 
				 *  merchant_uid에 경우 
				 *  https://docs.iamport.kr/implementation/payment
				 *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
				 */
				name: '${pro_name}',//'주문명 : 아메리카노',
				// 결제창에서 보여질 이름
				// name: '주문명 : ${auction.a_title}',
				// 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
				amount: '${order.ord_price}',
				// amount: ${bid.b_bid},
				// 가격 
				buyer_name: '${order.ord_name}',
				// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
				// 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
				buyer_postcode: '${order.ord_postcode}',
				m_redirect_url : 'http://localhost:8888/order/orderComplete'
				}, function (rsp) {
					console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '결제 금액 : ' + rsp.paid_amount;
					// success.submit();
					// 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
					// 자세한 설명은 구글링으로 보시는게 좋습니다.
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
			});
		});
		/*
		$("#btn_kakaopay2").click(function(){
			
			// 필수입력값을 확인.
			var name = $("#form-payment input[name='pay-name']").val();
			var tel = $("#form-payment input[name='pay-tel']").val();
			var email = $("#form-payment input[name='pay-email']").val();
			
			if(name == ""){
				$("#form-payment input[name='pay-name']").focus();
			}
			if(tel == ""){
				$("#form-payment input[name='pay-tel']").focus();
			}
			if(email == ""){
				$("#form-payment input[name='pay-email']").focus();
			}
			
			// 결제 정보를 form에 저장한다.
			let totalPayPrice = parseInt($("#total-pay-price").text().replace(/,/g,''));
			let totalPrice = parseInt($("#total-price").text().replace(/,/g,''));
			let discountPrice = totalPrice - totalPayPrice; 
			let usePoint = $("#point-use").val();
			let useUserCouponNo = $(":radio[name='userCoupon']:checked").val();
			
			// 카카오페이 결제전송
			$.ajax({
				type:'get'
				,url:'/order/pay'
				,data:{
					total_amount: totalPayPrice
					,payUserName: name
					,sumPrice:totalPrice
					,discountPrice:discountPrice
					,totalPrice:totalPayPrice
					,tel:tel
					,email:email
					,usePoint:usePoint
					,useCouponNo:useUserCouponNo	
					
				},
				success:function(response){
					location.href = response.next_redirect_pc_url;		
				}
			});
		});
		*/
	});
  </script>
  </body>
  
  
</html>

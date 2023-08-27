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
<link href="/css/pro_detail.css" rel="stylesheet" />
<link rel="canonical"
	href="https://getbootstrap.com/docs/4.6/examples/pricing/">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	list-style: none;
	text-decoration: none;
}

.tab {
	position: relative;
	top: 0;
	left: 0;
	width: 100%;
	display: block;
	height: 59px;
}

.flex {
	display: flex; */
	height: 50px;
	width: 100%;
	justify-content: space-around;
	position: absolute;
	left: 50%;
	bottom: 0;
	transform: translateX(-50%);
}

.panel {
	display: block;
	float: left;
	width: 25%;
	vertical-align: top;
	border: 1px solid #d9d9d9;
	border-bottom: 2px solid #111;
	box-sizing: border-box;
	height: 58px;
	color: #757575;
	font-size: 15px;
	line-height: 58px;
	text-align: center;
}

.tab_active {
	border: 2px solid #111;
	border-bottom: 2px solid #fff;
	color: #202020;
}

.content {
	display: none;
	height: max-content;
	padding-top: 78px;
}

.on {
	display: block !important;
}

#contents1 img {
	display: block;
	margin: 0 auto;
	width: 75%;
}
</style>

<!-- Custom styles for this template -->
<link href="pricing.css" rel="stylesheet">
</head>

<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>


	<div
		class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center"></div>
	<div class="container product-detail">
		<div class="padding-tb">
			<div class="row">
				<div class="col-sm-6">
					<img class="product-img" name="proudctImage"
						src="/product/displayFile?fileName=<c:out value="${productVO.pro_img }"></c:out>&uploadPath=<c:out value="${productVO.pro_uploadpath }"></c:out>">
				</div>
				<div id="pro_title_box" class="col-sm-6">
					<span class="product-name">${productVO.pro_name }</span> <span
						class="product-price"><fmt:formatNumber type="currency"
							value="${productVO.pro_price }" /></span> <span
						class="product-discount"><fmt:formatNumber type="currency"
							value="${productVO.pro_discount }" /></span>
					<table class="totalProducts_box">
						<tbody>
							<tr>
								<td><input type="number" name="pro_amount" id="pro_amount"
									value="1" min="0" max="${productVO.pro_amount+1}"></td>
							</tr>
							<tr id="sum_price_tr">
								<td>총 상품금액 : <span class="sum_price"></span>원
								</td>
							</tr>
						</tbody>
					</table>

					<input type="hidden" name="pro_num" id="pro_num"
						value="${productVO.pro_num }">
					<c:if test="${productVO.pro_amount != '0'}">
						<div class="clearfix" id="btn_group_box">
							<button type="button" name="btnBuyAdd">구매하기</button>
							&nbsp;
							<button type="button" name="btnCartAdd">장바구니 담기</button>
							&nbsp;
							<button type="button" name="btnProductList">List</button>
							&nbsp;
						</div>
					</c:if>
					<c:if test="${productVO.pro_amount  == '0'}">
						<div class="clearfix" id="btn_group_box">
							<button type="button" name="btnSoldout" class="btn-outline-dark">품절</button>
							<button type="button" name="btnProductList">List</button>
							&nbsp;
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<!--  내가 만든 탭메뉴 -->
	<div class="container">
		<div class="tab">
			<div class="flex">
				<a href="#" class="panel tab_active">상세정보</a> <a href="#"
					class="panel product_review_tab">리얼리뷰</a> <a href="#" class="panel">상품문의</a>
				<a href="#" class="panel">배송/교환/반품</a>
			</div>
		</div>
		<div id="contents1" class="product_detail content on">
			${productVO.pro_content }</div>
		<div id="contents2" class="product_review content">컨텐츠 2</div>
		<div id="contents3" class="product_consult content">
			<a href="/consult/cstWrite">상품문의 하기</a>
		</div>
		<div id="contents4" class="product_other content">
			<img src="/resources/img/ask_img.png">
		</div>
	</div>

	<!--  내가 만든 탭메뉴 END -->

	<!-- 탭 내용 -->
	<form id="actionForm" action="" method="get">
		<!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
		<!-- Criteria클래스가 기본생성자에 의하여 기본값으로 파라미터가 사용 -->
			<input type="hidden" name="pageNum" value="${cri.pageNum}">
			<input type="hidden" name="amount" value="${cri.amount}">
		<input type="hidden" name="cate_code" value="${productVO.cate_code}">
		<input type="hidden" name="cate_subprtcode"
			value="${productVO.cate_subprtcode}"> <input type="hidden"
			name="cate_prtcode" value="${productVO.cate_prtcode}">
	</form>
</body>

<%@include file="/WEB-INF/views/user/include/footer.jsp"%>

<script>

  //합계 계산
    function sum_price() {
    	 let amount = $('#pro_amount').val();
		 let discount = parseFloat('${productVO.pro_discount}');
	    // sum_price 계산
	    let sumPrice = discount * amount;
	    // sum_price 업데이트
	    $('.sum_price').text(sumPrice);
       console.log("amount" + amount);
    	}
    
    $(function() {
	 //할인율 및 합계 가져오기
		let discount = parseFloat('${productVO.pro_discount}');
		let price = parseFloat("${productVO.pro_price}");
		
		let discountedPrice = price - discount;
		let discountRate = Math.floor((discountedPrice / price) * 10000) / 100; // 소수점 둘째자리까지 표시하기 위해 100을 곱한 후 다시 100으로 나눔
	  $('.product-discount').after('<span class="discount-rate">' + Math.floor(discountRate) + '%</span>');
	  sum_price();
	  
    	  // pro_amount 변경 이벤트 감지
    	  $('#pro_amount').change(function() {

    		  sum_price();
    	  });
    	  
    
    	 //탭메뉴
 		$('.flex a').click(function(e){
 			e.preventDefault();
            let index = $(this).index();
            index++;
            $('.flex a').removeClass('tab_active');
            $(this).addClass('tab_active');

            $('.content').removeClass('on');
            $('#contents'+index).addClass('on');
        });
    	 
 	// 상품 후기 가져오기
   $(".product_review_tab").on("click", function(){
     let pageNum = $('#rewPageNum').val();
     let amount = $('#rewAmount').val();

     if (pageNum && amount) { // pageNum과 amount가 모두 존재하는 경우
       $(".product_review").load("/review/productReview?pro_num=" + "${productVO.pro_num}" + "&pageNum=" + pageNum + "&amount=" + amount);
     } else { // pageNum과 amount가 존재하지 않는 경우
            console.log("pageNum: " + pageNum + "/" + "amount: " + amount);
       $(".product_review").load("/review/productReview?pro_num=" + "${productVO.pro_num}");
     }
   });
 	
    });
 	 
      // jquery ready()이벤트 구문.
      $(function(){
    	  let maxVal = parseInt($("#pro_amount").attr("max"));
    	  if (parseInt(maxVal) == 1) {
    	    $('#pro_amount').val(0);
    	  }
    	  
        let actionForm = $("#actionForm");
        
        //구매 가능 수량
  		$("#pro_amount").on("input", function() {
  	  	  let minVal = parseInt($("#pro_amount").attr("min"));
  		  let pro_amount = parseInt($('#pro_amount').val());
  		  if (parseInt(maxVal) === 1) {
  			if(pro_amount === maxVal) {
  				alert("품절되었습니다.");
  				$('#pro_amount').val(0);
  				return false;
  			}
  		  } else {
  		 if(pro_amount === maxVal) {
  	  	      alert("최대 구매 가능한 수량은 " + parseInt(maxVal-1) + "개 입니다.");
  	  	  $('#pro_amount').val(parseInt(maxVal-1));
  	  	    }
   	    if(pro_amount === minVal) {
    	      alert("최소 주문수량은 1개 입니다.");
    	      $('#pro_amount').val(parseInt(minVal+1));
    	    }
  		  }
  		 });

        //장바구니 담기코드
        $("button[name='btnCartAdd']").on("click", function(){
            let pro_num = $('#pro_num').val();
        	let pro_amount = $("#pro_amount").val();
            if(pro_amount == null){
                alert("상품이 품절되었습니다.");
                return false;
            }

            console.log("상품코드" + pro_amount);

           $.ajax({
              url: '/cart/cartAdd',
              type: 'post',
              dataType: 'text',
              data: {pro_num: pro_num , cart_amount : pro_amount},
              headers: { "AJAX" : "true"},
              success: function(data) {
                if(data == "success") {
                  if(confirm("장바구니에 추가되었습니다.\n 지금 확인하겠습니까?")){
                    location.href = "/cart/cartList";
                  } else
                      location.reload();
                }
              },
              error:function(data) {
              	if(data.status == 400){
              		alert("로그인을 다시 해주십시오");
                  	location.href = ("/user/login/");
              	}
              }
           });
        });


        $("button[name='btnBuyAdd']").on("click", function(){
            let pro_num = $("#pro_num").val();
            let pro_amount = $("#pro_amount").val();
            if(pro_amount == null){
                alert("상품이 품절되었습니다.");
                return false;
            }
            location.href = "/order/orderInfo?type=direct&pro_num="+pro_num+"&pro_amount="+ pro_amount;
        });

        //리스트 클릭
        $("button[name='btnProductList']").on("click", function(){

        	let cate_code = $("input[name=cate_code]");
        	let cate_subprtcode = $("input[name=cate_subprtcode]"); 
        	console.log(cate_code);
        	console.log(cate_subprtcode);
        	if (${cateType == 'main'} ){
            	  alert('메인으로 돌아갑니다.');
            	  location.href="/";
            	  return;
              };
          actionForm.attr("action", "/product/productList");
          if(${cateType == 'firstCate'}){
        	  alert('첫번쨰 카테고리로 돌아갑니다.');
        	  cate_code.remove();
        	  cate_subprtcode.remove();
          }else if (${cateType == 'secondCate'} ){
        	  alert('두번쨰 카테고리로 돌아갑니다.');
        	  cate_code.remove();
          }else{
        	  alert('세번쨰 카테고리로 돌아갑니다.');
          }
          
          actionForm.submit();
        });

     
	   // 찾기 버튼 클릭	   
	  $(".show_all").on("click", function(e){
		   e.preventDefault();
		   $(".show_all").addClass("search_area_on");
	   });
	   $(".closebtn").on("click", function(e){
		   e.preventDefault();
		   $(".search_area").removeClass("search_area_on");
	   });	
	       
      
      // 전체보기 버튼 클릭 시
      $(document).on('click', '.all_img_btn', function(e){ 
        e.preventDefault();

        // pro_num 가져오기
        let pro_num = $(this).data('pronum');
        
        // 새로운 링크 생성
        let newLink = '/review/productReviewImg?pro_num=' + pro_num;

        // 기존 링크 변경
        $('.all_img_btn').attr('href', newLink);
        location.href = newLink;
      });
      
    	
    });
    </script>

</html>

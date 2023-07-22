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

<!-- Bootstrap core CSS -->
<!-- <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://getbootstrap.com/docs/4.6/dist/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">

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

#category {
	width: 29%;
	cursor: pointer;
	border: 1px solid #e5e5e5;
	margin-top: 3px;
}

#search_btn {
	display: inline-block;
}

#reset_btn {
	display: inline-block;
}

.card-text {
	margin-bottom: 12px;
}

#buy_btn_style {
	width: 89%;
	width: 95px;
}

#cart_btn_style {
	width: 89%;
	width: 95px;
}

.proDetail2 {
	display: block;
	margin-bottom: 10px
}

.discount-rate {
	display: inline-block;
	font-size: 24px;
	color: #35cde8;
	font-weight: 800;
	margin-left: 11px;
	vertical-align: text-bottom;
	margin-bottom: -1px;
}

.product-price {
	display: block;
	text-decoration: line-through;
	font-size: 16px;
	font-weight: 600;
	color: #959595;
}

.product-discount {
	font-size: 22px;
	color: #202020;
	font-weight: 800;
}
</style>

<!-- Custom styles for this template -->
<link href="pricing.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/search.css">

</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>

	<div
		class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center"></div>
	<div class="container">
		<div class="contents">
			<div class="page_title">
				<h2>상품 검색</h2>
			</div>
			<div class="ec-base-box searchbox">
				<fieldset>
					<div class="item clarfix">
						<strong>상품분류</strong> <select id="category" name="category">
							<option value="">상품분류 선택</option>
							<c:forEach items="${mainCategory}" var="categoryVO">
								<option value="${categoryVO.cate_code}"
									<c:if test="${categoryVO.cate_code eq con.cate_prtcode}">selected</c:if>>${categoryVO.cate_name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="item clarfix">
						<strong>상품검색</strong> <input id="keyword" class="inputTypeText"
							size="15" type="text" value="<c:out value="${ con.keyword}" />">
					</div>
					<div class="item clarfix">
						<strong>판매가격대</strong> <input id="price_min" class="input01"
							placeholder="" size="15" type="text"
							value="<c:out value="${ con.price_min != 0 ? con.price_min : ''}" />">
						~ <input id="price_max" class="input01" placeholder="" size="15"
							type="text"
							value="<c:out value="${ con.price_max != 0 ? con.price_max : ''}" />">
					</div>
					<div class="item clarfix">
						<button id="search_btn" type="button" class="btnSubmitFix sizeM">검색</button>
						<button id="reset_btn" type="button" class="btnSubmitFix sizeM">검색
							초기화</button>
					</div>
				</fieldset>
			</div>
		</div>

		<div class="searchResult">
			<p class="record">
				총 <strong>${pageMaker.total }</strong> 개 의 상품이 검색되었습니다.
			</p>
			<ul class="orderby">
				<li data-orderby="pro_date"><a>신상품순</a></li>
				<li data-orderby="pro_name"><a>상품명순</a></li>
				<li data-orderby="low"><a>낮은가격순</a></li>
				<li data-orderby="high"><a>높은가격순</a></li>
				<li data-orderby="pro_rewcount"><a>사용후기순</a></li>
			</ul>
			<!-- orderby 인풋-->
			<input type="hidden" id="orderby" name="orderby" value="${orderby }">
		</div>

		<div class="row">
			<c:forEach items="${productList }" var="productVO" varStatus="status">
				<div class="col-md-3">
					<div class="card mb-4 shadow-sm">
						<a href="${productVO.pro_num }" class="proDetail"> <img
							name="proudctImage" width="100%" height="225"
							src="/product/displayFile?fileName=<c:out value="${productVO.pro_img }"></c:out>&uploadPath=<c:out value="${productVO.pro_uploadpath }"></c:out>">
						</a>
						<div class="card-body">
							<p class="card-text">
								<a href="${productVO.pro_num }" class="proDetail2"> <c:out
										value="${productVO.pro_name }"></c:out>
								</a> <span class="product-price"><fmt:formatNumber
										type="currency" value="${productVO.pro_price }" /></span> <span
									class="product-discount"><fmt:formatNumber
										type="currency" value="${productVO.pro_discount }" /></span> <input
									type="hidden" name="product-price"
									value="${ productVO.pro_price }" /> <input type="hidden"
									name="product-discount" value="${ productVO.pro_discount}" /> <input
									type="hidden" name="pro_num" value="${productVO.pro_num }">
								<input type="hidden" name="cate_code"
									value="${productVO.cate_code }">
							</p>
							<div class="d-flex justify-content-between align-items-center">
								<div class="btn-group">
									<c:if test="${productVO.pro_amount != 0}">
										<button type="button" name="btnBuyAdd" id="buy_btn_style"
											class="btn btn-sm btn-outline-secondary">Buy</button>
										<button type="button" name="btnCartAdd" id="cart_btn_style"
											class="btn btn-sm btn-outline-secondary">Cart</button>
									</c:if>
									<c:if test="${productVO.pro_amount == 0}">
										<button type="button" name="btnSoldout"
											class="btn btn-secondary">품절</button>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<!-- 페이징 출력 -->
		<div class="dataTables_paginate paging_simple_numbers"
			id="example2_paginate">
			<ul class="pagination clearfix">
				<c:if test="${pageMaker.prev }">
					<li
						class='paginate_button previous ${pageMaker.prev ? "": "disabled" }'
						id="example2_previous"><a href="${pageMaker.startPage - 1}"
						aria-controls="example2" data-dt-idx="0" tabindex="0"><</a></li>
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

		<!--검색, 정렬 및 prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
		<form id="searchList" action="/product/productSearchList" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		</form>

		<div class="col-sm-5"></div>
	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>

	<script>
    $(document).ready(function(){
    	//정렬 상태확인 style
    	$(function(){
    		let orderByValue = "${orderby }"; // 서버에서 받은 데이터
    		let current = $("li[data-orderby='" + orderByValue + "']");
			console.log(current);    		
    		current.addClass("orderby_color");
    	});
    });
    
    $(function() {
    	
    	//검색 관련 수정*
	    let searchList = $("#searchList");
	    
    	//검색 버튼 클릭시 
    	  $("#search_btn").on("click", function(){
    		$("#orderby").val("basic");
    		searchList.find("input[name='pageNum']").val(1);
    		searchList_submit();
    	  });
    	
    	  //검색 초기화 버튼 클릭시
    	  $("#reset_btn").click(function() {
    		    // 입력값 초기화
    		    $("#category").val("");
    		    $("#keyword").val("");
    		    $("#price_min").val("");
    		    $("#price_max").val("");
    		    $("#searchList").submit();
    		  });
		
    	//상품 정렬 클릭
	    $('.orderby li').on('click', function(e) {
	        e.preventDefault();
	        <%--
	        $(".orderby li").removeClass("orderby_color");
	        $(this).addClass("orderby_color");
	        --%>
			$("#orderby").val($(this).data('orderby'));
    		searchList.find("input[name='pageNum']").val(1);
   		 	searchList_submit();
	    });
    	
	  
	    
		//페이지번호 클릭시 : 선택한 페이지번호, 페이징정보, 검색정보
		$(".paginate_button a").on("click", function(e){
			e.preventDefault(); // <a href="">기능취소
			//기존 페이지번호를 사용자가 선택한 페이지번호로 변경
			searchList.find("input[name='pageNum']").val($(this).attr("href"));
	 		searchList_submit();    
  	 	 });
			 
	//검색 정보 및 정렬, 페이징 정보 넘기기  	    
    function searchList_submit() {
    	
	    // 상품카테고리 가져오기
    	let cate_prtcode = $("#category option:selected").val();

	    // 상품검색어 가져오기
	    let keyword = $("#keyword").val();

	    // 판매가격대 최소값 가져오기
	    let price_min = $("#price_min").val();

	    // 판매가격대 최대값 가져오기
	    let price_max = $("#price_max").val();

	    //정렬 데이터 가져오기
	    let orderby = $("#orderby").val();
		
	    // 빈 값이 아닌 경우에만 input 태그를 동적으로 생성하여 searchList에 추가
	    if(cate_prtcode !== "" && cate_prtcode !== null) {
	      $("#searchList").append("<input type='hidden' name='cate_prtcode' value='" + cate_prtcode + "'>");
	    }
	    if(keyword !== "" && keyword !== null) {
	      $("#searchList").append("<input type='hidden' name='keyword' value='" + keyword + "'>");
	    }
	    if(price_min !== "" && price_min !== null) {
	      $("#searchList").append("<input type='hidden' name='price_min' value='" + price_min + "'>");
	    }
	    if(price_max !== "" && price_max !== null) {
  	      $("#searchList").append("<input type='hidden' name='price_max' value='" + price_max + "'>");
  	    }
	    if(orderby !== "" && orderby !== null) {
	  	  $("#searchList").append("<input type='hidden' name='orderby' value='" + orderby + "'>");
	    }
	    if(orderby == "" && orderby == null) {
		  $("#searchList").append("<input type='hidden' name='orderby' value='basic'>");
		}

	    // searchList 제출
	    $("#searchList").submit();

    	} 
	
    
    //상세페이지 이동
    $("a.proDetail").on("click", function(e){
      e.preventDefault();
        let pro_num = $(this).attr("href");
        let cate_code = $(this).parent().find("input[name='cate_code']").val();
        searchList.append("<input type='hidden' name='cate_code' value='" + cate_code + "'>");
        searchList.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
        searchList.attr("action", "/product/productDetail");
        searchList.submit();
    });
	
	});
    							
		 //장바구니 담기 코드 수정 *
    $("button[name='btnCartAdd']").on("click", function(){
        
        let pro_num = $(this).parents("div.card-body").find("input[name='pro_num']").val();
        
       // console.log("상품코드" + pro_num);

       $.ajax({
          url: '/cart/cartAdd',
          type: 'post',
          dataType: 'text',
          data: {pro_num: pro_num, cart_amount : 1},
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
        
     // 상품구매버튼 클릭시
        $("button[name='btnBuyAdd']").on("click", function(){
            
            let pro_num = $(this).parents("div.card-body").find("input[name='pro_num']").val();
            let pro_amount = 1;
            location.href = "/order/orderInfo?type=direct&pro_num="+pro_num+"&pro_amount="+ pro_amount;
       
        });
     <%--
        $(function() {
       	 //할인율 및 합계 가져오기
       		let discount = $("input[name='pro_discount']").val();
       		let price = $("input[name='pro_price']").val();
       		
       		let discountedPrice = price - discount;
       		let discountRate = Math.floor((discountedPrice / price) * 10000) / 100;
       		console.log("discount: " + discountedPrice);
       		console.log("price: " +  Math.floor((discountedPrice / price) * 10000));
       		// 소수점 둘째자리까지 표시하기 위해 100을 곱한 후 다시 100으로 나눔
       	  $('.product-discount').after('<span class="discount-rate">' + Math.floor(discountRate) + '%</span>');
        });
        
        $("${productList }").each(function(index, productVO) {
        	  let discount_target = $("input[name='pro_discount']")[index];
        	  let price_target = $("input[name='pro_price']")[index];

        	  let discount = discount_target.val();
        	  let price = price_target.val();
        	  
        	  let discountedPrice = price - discount;
         	  let discountRate = Math.floor((discountedPrice / price) * 10000) / 100;
        	  
         	// 소수점 둘째자리까지 표시하기 위해 100을 곱한 후 다시 100으로 나눔
           	$('.product-discount').after('<span class="discount-rate">' + Math.floor(discountRate) + '%</span>');
        	
        	});
	--%>
	
	<%-- 
	$(function() {
		  $('input[name="pro_discount"]').each(function() {
		    // 현재 상품의 가격과 할인율 정보 가져오기
		    let $this = $(this);
		    let discount = $this.val();
		    let price = $this.siblings('input[name="pro_price"]').val();

		    // 할인율 계산
		    let discountedPrice = price - discount;
		    let discountRate = Math.floor((discountedPrice / price) * 10000) / 100;

		    // 해당 상품에 할인율 정보 추가
		    $this.closest('.card-body').find('.product-discount').after('<span class="discount-rate">' + Math.floor(discountRate) + '%</span>');
		  });
		});
--%>
$(function() {
	  // 할인율 및 합계 가져오기
	  $("input[name='product-price']").each(function(i) {
	    let discount = $("input[name='product-discount']").eq(i).val();
	    let price = $(this).val();

	    let discountedPrice = price - discount;
	    let discountRate = Math.floor((discountedPrice / price) * 10000) / 100;

	    // 소수점 둘째자리까지 표시하기 위해 100을 곱한 후 다시 100으로 나눔
	    $('.product-discount').eq(i).after('<span class="discount-rate">' + Math.floor(discountRate) + '%</span>');
	  });
	});
    
    </script>

</body>
</html>

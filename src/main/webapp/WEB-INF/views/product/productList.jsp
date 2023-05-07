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

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      
      #search_btn { display: inline-block; }
      
      #reset_btn { display: inline-block; }
      
      
      .card-text {
      		margin-bottom: 12px;
       }
       
       #buy_btn_style {     width: 89%;
    width: 95px;  }
       
       #cart_btn_style {    width: 89%;
    width: 95px;  }
       
       
      
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
      
      <%--
      .product-price{ display: inline-block;
    text-decoration: line-through;
    font-size: 18px;
    margin-bottom: 4px;
    font-weight: 600;
    color: #959595; }
      
      
      .product-discount { display: block; }--%>
    </style>

    
    <!-- Custom styles for this template -->
    <link href="pricing.css" rel="stylesheet">
  </head>

  <body>
    
<%@include file="/WEB-INF/views/user/include/header.jsp" %>


<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  
</div>

<div class="container">
		<div class="page_title">
			<h2>${cate_prtcode == 1 ? "고양이" : ""}${cate_prtcode == 2 ? "강아지" : ""}</h2>
			
			
		</div>
      <div class="row" style="width: 94%;">
      <c:forEach items="${productList }" var="productVO" varStatus="status">
        <div class="col-md-3">
          <div class="card mb-4 shadow-sm">
            
            <!-- <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"></rect><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg> -->
			<a href="${productVO.pro_num }" class="proDetail">
				<img name="proudctImage" width="100%" height="225" src="/product/displayFile?fileName=s_<c:out value="${productVO.pro_img }"></c:out>&uploadPath=<c:out value="${productVO.pro_uploadpath }"></c:out>">
			</a>
            <div class="card-body">
              <p class="card-text">
              	<a href="${productVO.pro_num }" class="proDetail2">
              		<c:out value="${productVO.pro_name }"></c:out>
              	</a>
              	<span class="product-price"><fmt:formatNumber type="currency" value="${productVO.pro_price }" /></span>
      			<span class="product-discount"><fmt:formatNumber type="currency" value="${productVO.pro_discount }" /></span>
      			<input type="hidden" name="product-price" value="${ productVO.pro_price }"/>
      			<input type="hidden" name="product-discount" value="${ productVO.pro_discount}"/>
              	<input type="hidden" name="pro_num" value="${productVO.pro_num }">
              	<input type="hidden" name="cate_code" value="${productVO.cate_code }">
              </p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" name="btnBuyAdd" id="buy_btn_style" class="btn btn-sm btn-outline-secondary">Buy</button>
                  <button type="button" name="btnCartAdd" id="cart_btn_style" class="btn btn-sm btn-outline-secondary">Cart</button>
                </div>
              </div>
            </div>
          </div>
        </div>
       </c:forEach> 
      </div>
      <!-- 페이징 출력 -->								
			<div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
				<ul class="pagination clearfix">
				<c:if test="${pageMaker.prev }">
					<li class='paginate_button previous ${pageMaker.prev ? "": "disabled" }'
						id="example2_previous"><a href="${pageMaker.startPage - 1}"
						aria-controls="example2" data-dt-idx="0" tabindex="0"><</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">	
					<li class='paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }'><a href="${num}"
						aria-controls="example2" data-dt-idx="1" tabindex="0">${num}</a></li>
				</c:forEach>
				<c:if test="${pageMaker.next }">	
					<li class="paginate_button next" id="example2_next"><a
						href="${pageMaker.endPage + 1}" aria-controls="example2" data-dt-idx="7"
						tabindex="0">></a></li>
				</c:if>
				</ul>
			</div>
		<!--prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
		<form id="actionForm" action="/product/productList" method="get">
			<!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="cate_prtcode" value="${cate_prtcode}">
				<!-- 몇차 카테고리 리스트에서 접근 (구분용) -->
			<input type="hidden" name="cateType" value="${cateType}">
			<c:if test="${cateType eq 'secondCate'}">
				<input type="hidden" name="cate_subprtcode" value="${cate_subprtcode}">
			</c:if>
			<c:if test="${cateType eq 'thirdCate'}">
				<input type="hidden" name="cate_subprtcode" value="${cate_subprtcode}">
				<input type="hidden" name="cate_code" value="${cate_code}">
			</c:if>
			<!--글번호추가-->
		</form>
		<div class="col-sm-5"></div>
      </div>
<%@include file="/WEB-INF/views/user/include/footer.jsp" %>
    <script>

      $(function(){
    	  //페이지 파라미터 캐시 문제 해결- 이전 페이지의 캐시를 삭제  04/07*
    	    window.onpageshow = function(e) {
    	    	  if (e.persisted) {
    	    	    // 페이지가 캐시에서 로드됐을 때
    	    	    window.location.reload(); // 페이지 새로고침
    	    	  }
    	    	};
    	    
        //장바구니 담기코드 수정*
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
        
        
    let actionForm = $("#actionForm");
		//페이지번호 클릭시 : 선택한 페이지번호, 페이징정보, 검색정보
		$(".paginate_button a").on("click", function(e){
			e.preventDefault(); // <a href="">기능취소
			//기존 페이지번호를 사용자가 선택한 페이지번호로 변경
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
    });

    //상세페이지 이동
    $("a.proDetail").on("click", function(e){
      e.preventDefault();
        let pro_num = $(this).attr("href");
        let cate_code = $(this).parent().find("input[name='cate_code']").val();
        actionForm.append("<input type='hidden' name='cate_code' value='" + cate_code + "'>");
        actionForm.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
        actionForm.attr("action", "/product/productDetail");
        actionForm.submit();

    });
    
    
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
    
    
    
  });
    </script>
    
  </body>
</html>

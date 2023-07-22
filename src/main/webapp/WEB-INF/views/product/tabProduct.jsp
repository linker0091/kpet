<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:forEach items="${list}" var="ProductVO">
	<div class="col-md-3 parentDetail">
		<div class="card mb-4 shadow-sm">
			<a href="${ProductVO.pro_num }" class="proDetail"> <img
				name="proudctImage" width="100%" height="225"
				src="/product/displayFile?fileName=<c:out value="${ProductVO.pro_img }"></c:out>&uploadPath=<c:out value="${ProductVO.pro_uploadpath }"></c:out>">
			</a> <input type="hidden" name="cate_code"
				value="${ProductVO.cate_code }">
			<div class="card-body">
				<p class="card-text">
					<a href="${ProductVO.pro_num }" class="proDetail2"> <c:out
							value="${ProductVO.pro_name }"></c:out>
					</a> <span class="product-price"><fmt:formatNumber
							type="currency" value="${ProductVO.pro_price }" /></span> <span
						class="product-discount"><fmt:formatNumber type="currency"
							value="${ProductVO.pro_discount }" /></span> <input type="hidden"
						name="product-price" value="${ ProductVO.pro_price }" /> <input
						type="hidden" name="product-discount"
						value="${ ProductVO.pro_discount}" /> <input type="hidden"
						name="pro_num" value="${ProductVO.pro_num }">
				</p>
				<div class="d-flex justify-content-between align-items-center">
					<div class="btn-group">
						<c:if test="${ProductVO.pro_amount != 0}">
							<button type="button" name="btnBuyAdd" id="buy_btn_style"
								class="btn btn-sm btn-outline-secondary">Buy</button>
							<button type="button" name="btnCartAdd" id="cart_btn_style"
								class="btn btn-sm btn-outline-secondary">Cart</button>
						</c:if>
						<c:if test="${ProductVO.pro_amount == 0}">
							<button type="button" name="btnSoldout" class="btn btn-secondary">품절</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>

<style>
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

<script>
 
	
	//장바구니 담기 코드 수정*
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
           }else{
        	   $.ajax({
       			url: "/cart/cartTotal",
       	        type: 'post',
       	        dataType: 'json',
       	        success: function(data){
       	        	console.log(data);
       	            $(".cartTotal").text(data);	
           	        }		
           		});	
         }
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
	 
	//상세페이지 이동
		$("a.proDetail").on("click", function(e){
		   e.preventDefault();
		  /*
		  let pro_num = $(this).attr("href");
		  actionForm.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
		  actionForm.attr("action", "/product/productDetail");
		  actionForm.submit();
		  */
		  let cate_code = $(this).parents(".parentDetail").find("input[name='cate_code']").val();
		  console.log("카테고리: " + cate_code);
		  //return;
		  location.href = "/product/productDetail?pro_num=" + $(this).attr("href") + "&cate_code=" + cate_code + "&type=N&cateType=main";
		
		});
	 //---------------------------------------------------------
	 
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
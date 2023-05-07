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
	<link href="/css/pro_detail.css" rel="stylesheet" />
    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">
	

    

    <!-- Bootstrap core CSS -->
    
    <!-- <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css"> -->
    <!-- <link rel="stylesheet" href="https://getbootstrap.com/docs/4.6/dist/css/bootstrap.min.css"> -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <!--
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
      
      #star_grade a {
      	font-size: 22px;
      	text-decoration: none;
      	color: lightgray;
      }
      
      #star_grade a.on {
      	color: black;
      }
    </style>
-->
<style>
/* tab menu */
.tab{float:left; width:600px; height:290px;}
.tabnav{font-size:0; width:600px; border:1px solid #ddd;}
.tabnav li{display: inline-block;  height:46px; text-align:center; border-right:1px solid #ddd;}
.tabnav li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:3px; }
.tabnav li a.active:before{background:#7ea21e;}
.tabnav li a.active{border-bottom:1px solid #fff;}
.tabnav li a{ position:relative; display:block; background: #f8f8f8; color: #000; padding:0 30px; line-height:46px; text-decoration:none; font-size:16px;}
.tabnav li a:hover,
.tabnav li a.active{background:#fff; color:#7ea21e; }
.tabcontent{padding: 20px; height:244px; border:1px solid #ddd; border-top:none;}


</style>
    
    <!-- Custom styles for this template -->
    <link href="pricing.css" rel="stylesheet">
  </head>

  <body>
    
<%@include file="/WEB-INF/views/user/include/header.jsp" %>


<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  
</div>

<div class="container product-detail">
	  <div class="padding-tb">
      <div class="row">
      	<div class="col-sm-6">
      		<img class="product-img" name="proudctImage" src="/product/displayFile?fileName=<c:out value="${productVO.pro_img }"></c:out>&uploadPath=<c:out value="${productVO.pro_uploadpath }"></c:out>">
      	</div>
      	
      	<div class="col-sm-4 ">
 		<span class="product-name">${productVO.pro_name }</span>
      	<span class="product-price"><fmt:formatNumber type="currency" value="${productVO.pro_price }" /></span>	
      	<span class="product-discount">${productVO.pro_discount }</span>	
      	<table>
      	<tbody>
      	<tr>
      	<td><input type="number" name="pro_amount" id="pro_amount" value="1"></td>
      	<td><span class="sum_price"></span></td>
      	</tr>
      	</tbody>
      	</table>

      		<input type="hidden" name="pro_num" id="pro_num" value="${productVO.pro_num }"><br>
      		 <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" name="btnBuyAdd" class="btn btn-sm btn-outline-secondary">Buy</button>&nbsp;
                  <button type="button" name="btnCartAdd" class="btn btn-sm btn-outline-secondary">Cart</button>&nbsp;
                  <button type="button" name="btnProductList" class="btn btn-sm btn-outline-secondary">List</button>&nbsp;
                  
                </div>
               
             </div>
      	</div>
      </div>
      </div>
   </div>   <%--
	 <div class="detail-tab">
	  <ul class="nav nav-tabs nav-justified">
	    <li class="nav-item on">
	    <button id="btn1">상세정보</button>
	    </li>
	    <li class="nav-item">
	    <button id="btn2">리얼리뷰</button>
	    </li>
	    <li class="nav-item">
	    <button id="btn3">상품문의</button>
	    </li>
	    <li class="nav-item">
	    <button id="btn4">배송/교환/반품</button>
	    </li>
	  </ul>
	</div>
	--%>
	<!--  내가 만든 탭메뉴 -->
	  <div class="tab">
    <ul class="tabnav">
      <li><a href="#tab01">탭1</a></li>
      <li><a href="#tab02">탭2</a></li>
    </ul>
    <div class="tabcontent">
      <div id="tab01">tab1 content</div>
      <div id="tab02">tab2 content</div>
    </div>
  </div><!--tab-->
	
	<div class="tab_menu">
	  		<ul class="tab_ul">
	  			<li class="active"><a href="#">상세정보</a>
	  				<ul>
		  				<div id="tab_contentbox product_detail" class="product-content" style="display: block;">
		  		    		${productVO.pro_content}
		  		    		<img src="/resources/img/Detail_info_img.png">
		  		  		</div>
		  		  	</ul>
	  			</li>
	  			<li><a href="#">리얼리뷰</a>
	  				<ul>
		  				<div id="tab_contentbox product_review" class="product_review" style="display: none;">
		    
		  				</div>
		  			</ul>
  				</li>
	  			<li><a href="#">상품문의</a>
	  				<ul>
					  	<div id="tab_contentbox product_consult" class="product-content" style="display: none;">
		    
		  				</div>
		  			</ul>
				</li>
	  			<li><a href="#">배송/교환/반품</a>
	  				<ul>
						<div id="tab_contentbox product_other" class="product-content" style="display: none;">
						   
						</div>
					</ul>
				</li>
	  		</ul>
	  	</div>
	<!--  내가 만든 탭메뉴 END -->


	<!-- 탭 내용 -->

	  <div id="product_detail" class="product-content">
	    ${productVO.pro_content}
	  </div>
	  <%--
	  <div id="product_review" class="product_review">
	    
	  </div>
	   --%>
	  <div id="product_consult" class="product-content">
	    
	  </div>
	  <div id="product_other" class="product-content">
	   
	  </div>

 	   

     
      <form id="actionForm" action="" method="get">
        <!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
        
        <!-- Criteria클래스가 기본생성자에 의하여 기본값으로 파라미터가 사용 -->
        <c:if test="${type == 'Y' }">
        <input type="hidden" name="pageNum" value="${cri.pageNum}">
        <input type="hidden" name="amount" value="${cri.amount}">
        </c:if>
        
        <input type="hidden" name="cate_code" value="${productVO.cate_code}">
        <input type="hidden" name="cate_subprtcode" value="${productVO.cate_subprtcode}">
        <input type="hidden" name="cate_prtcode" value="${productVO.cate_prtcode}">
			
   	 </form>

  </body>	 



      <%@include file="/WEB-INF/views/user/include/footer.jsp" %>

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
    	  
	//탭 이동<%--
		$('#btn1').click(function(){

			let offset = $('#product_detail').offset(); //선택한 태그의 위치를 반환

                //animate()메서드를 이용해서 선택한 태그의 스크롤 위치를 지정해서 0.4초 동안 부드럽게 해당 위치로 이동함 

	        $('html').animate({scrollTop : offset.top}, 400);

		});
		$('#btn2').click(function(){

			let offset = $('#product_review').offset(); //선택한 태그의 위치를 반환

                //animate()메서드를 이용해서 선택한 태그의 스크롤 위치를 지정해서 0.4초 동안 부드럽게 해당 위치로 이동함 

	        $('html').animate({scrollTop : offset.top}, 400);

		});
		$('#btn3').click(function(){

			let offset = $('#product_consult').offset(); //선택한 태그의 위치를 반환

                //animate()메서드를 이용해서 선택한 태그의 스크롤 위치를 지정해서 0.4초 동안 부드럽게 해당 위치로 이동함 

	        $('html').animate({scrollTop : offset.top}, 400);

		});
		$('#btn4').click(function(){

			let offset = $('#product_other').offset(); //선택한 태그의 위치를 반환

                //animate()메서드를 이용해서 선택한 태그의 스크롤 위치를 지정해서 0.4초 동안 부드럽게 해당 위치로 이동함 

	        $('html').animate({scrollTop : offset.top}, 400);

		});

    	});--%>
    
    	 //탭메뉴
        $(function(){
		  $('.tabcontent > div').hide();
		  $('.tabnav a').click(function () {
		    $('.tabcontent > div').hide().filter(this.hash).fadeIn();
		    $('.tabnav a').removeClass('active');
		    $(this).addClass('active');
		    return false;
		  }).filter(':eq(0)').click();
  		});
    <%--
	    $(".product_review_tab").on("click", function(){
	    	$("#product_review").load("/review/productReview?pro_num=" + ${productVO.pro_num });
	    });
		--%>  

      //상품후기 가져오기
      let getProductReview = function() {	
    	  $("#product_review").load("/review/productReview?pro_num=" + ${productVO.pro_num });
      }
      getProductReview();      
      //상품후기 페이지 변경시 페이지 가져오기-버튼 이벤트는 리뷰 페이지에
      let getProReviewPaging = function(rewPageNum,rewAmount) {
          $("#product_review").load("/review/productReview?pro_num=" + ${productVO.pro_num } + "&pageNum=" + rewPageNum + "&amount=" + rewAmount);          
      }
      
      
      // jquery ready()이벤트 구문.
      $(function(){

        let actionForm = $("#actionForm");
        
        //장바구니 담기
        $("button[name='btnCartAdd']").on("click", function(){
            
            //let pro_num = $(this).parents("div.card-body").find("input[name='pro_num']").val();
            
           // console.log("상품코드" + pro_num);

           $.ajax({
              url: '/cart/cartAdd',
              type: 'post',
              dataType: 'text',
              data: {pro_num: ${productVO.pro_num }, cart_amount : $("#pro_amount").val()},
              success: function(data) {
                if(data == "success") {
                  if(confirm("장바구니에 추가되었습니다.\n 지금 확인하겠습니까?")){
                    location.href = "/cart/cartList";
                  }else{
                      location.reload();
                  }
                }
              }
           });
        });

        $("button[name='btnBuyAdd']").on("click", function(){
            
            let pro_num = $("#pro_num").val();
            let pro_amount = $("#pro_amount").val();
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

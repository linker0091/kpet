<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/user/include/plugin_js.jsp" %>

<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/main_style.css" rel="stylesheet" />
<link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">

    <div class="wrap_gnb">
        <div class="container">
            <p>첫 구매하고 <strong>0원 체험</strong> 하세요!</p>
            <button class="topbnr_close">오늘 하루 보지 않기</button>
        </div>
    </div>
    <!-- Header-->
    <header id="header">
        <div class="header_top">
            <div class="container pdt">
                <h1>
                    <a href="/">KPET</a>
                </h1>
                <div class="side_menu clearfix">
                    <ul class="clearfix">
                    
                    <!-- 로그인 이전상태 표시 -->
                <c:if test="${sessionScope.loginStatus == null }">
                    <li><a href="/user/login">로그인</a></li>
                        <li><a href="/user/join">회원가입</a></li>
                </c:if>
                <!-- 로그인 이후상태 표시 -->
                <c:if test="${sessionScope.loginStatus != null }">
                    <li><a href="/user/logout">로그아웃</a></li>
                        <li><a href="/user/modify">회원정보 수정</a></li>
                        <li><a href="/order/orderInfo">상품구매</a></li>
                        <li><a href="/user/mypage">마이페이지</a></li>
                </c:if>
                        <li><a href="/board/list">커뮤니티</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="header_bottom">
            <div class="container">
                <div class="header_gnb">
                    <ul class="clearfix">
                        <c:forEach items="${userCategory}" var="categoryVO">
                            <li class="nav-item dropdown">
                                <!-- 1차 카테 -->
                                <a class="nav-link category_menu" data-toggle="dropdown" href="${categoryVO.cate_code }" role="button">${categoryVO.cate_name }</a>
                                <!-- drop박스 -->
                                <div class="drop clearfix">
                                    <!-- 2차 카테 -->
                                    <div class="depth2">
                                        <ul class="subCategory depth2_subbox clearfix" id="subCategory_${categoryVO.cate_code }">
                                            <li>
                                               <a class="sub_cate" id="lastsubCategory_${categoryVO.cate_code }"></a>
                                            </li>
                                        </ul>
                                    </div>
                                    <!-- 3차 카테 -->
                                    <div class="depth3">
                                        <ul class="lastsubCategory depth3_subbox" id="lastsubCategory_${categoryVO.cate_code }">
                                        <li>
                                        </li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                </c:forEach>
                
                <li class="nav-item">
               <a class="nav-link category_menu" href="/review/allReview">리얼리뷰</a>
                </li>
                    </ul>
                    <div class="right_icon_menu">
                		<ul>
                		<!-- 날씨 api 추가 -->
                		<li id="weather" style="font-size: 15px;"></li>
                			<li>
                				<a href="#" class="into_search_btn">검색
                					<img src="/img/ico_search.png">
                				</a>
                			</li>
                			<li>
                				<a href="/user/mypage">마이페이지
                					<img src="/img/ico_mypage.png">
                				</a>
             					<ul class="top_login"><!-- 상품리뷰 최근알림 -->
             					<c:if test="${sessionScope.loginStatus == null }">
									<li class=""><a href="/user/login">로그인</a>
									</li>
									<li class=""><a href="/user/join">회원가입</a>
									</li>
									</c:if>
									<c:if test="${sessionScope.loginStatus != null }">
									<li><a href="/user/logout">로그아웃</a></li>
									<li><a href="/user/modify">정보수정</a></li>
									</c:if>
									<li><a href="/order/orderInfo">상품구매</a></li>
									<li><a href="/order/orderComplete">주문조회</a></li>
									<li><a href="/user/mypage">마이페이지</a></li>
									<li><a href="/board/list">커뮤니티</a></li>
									<li><a href="/user/consult">1:1 맞춤상담</a></li>
								</ul>
                			</li>
                			<li>
                				<a href="/cart/cartList">장바구니
                					<img src="/img/ico_cart.png">
                					<span class="cartTotal">0</span>
                				</a>
                			</li>
                		</ul>
                	</div>
                </div>
            </div>
        </div>
    </header>
    <div class="head_area"></div>
    <div class="search_area">
    	<a href="#" class="closebtn">
    		<img src="/img/search_close.png">
    	</a>
	    <div class="inner_box">
	    	<h1>고객님<br>무엇을 찾으세요?</h1>
	    	<div class="search_box">
	    	<form id="searchForm" action="/product/productSearchList" method="get">
	    		<input type="text" class="search" id="search" name="keyword" placeholder="검색어를 입력해주세요."></input>
 	    		<input type="hidden" class="search" name="orderby"></input>
	    		<img id="search_img" class="sch_button" src="/img/top_search_b.png" alt="검색" class="search_cont">
	    		</form>
	    	</div>
	    	<p>인기검색어</p>
	    	<ul class="popular_txt">
		    	<a href="#">#보양식</a>
		    	<a href="#">#츄르</a>
		    	<a href="#">#모래</a>
		    	<a href="#">#간식</a>    	
	    	</ul>
		</div>
    </div>

 <script>
   $(function(){
	   //날씨 api jsp 로드 추가 04/06*
	   $("#weather").load("/api/cityWeather");
	   <%--
	   //오늘 자정의 시간을 계산
	   var midnight = new Date();
	   midnight.setHours(24, 0, 0, 0);

	   $(".topbnr_close").on("click", function(){
	     // 쿠키 이름 'topbnr_hide', 쿠키 값 '1'로 설정.
	     document.cookie = 'topbnr_hide=1;expires=' + midnight.toUTCString() + ';path=/';
	     
	     $(this).parent().css("display", "none");
	   });
	   --%>
	   
	   
		   
		
	   
	   // 찾기 버튼 클릭	   
	  $(".into_search_btn").on("click", function(e){
		   e.preventDefault();
		   $(".search_area").addClass("search_area_on");
	   });
	   $(".closebtn").on("click", function(e){
		   e.preventDefault();
		   $(".search_area").removeClass("search_area_on");
	   });
	   
	      //검색시
       $("#search").keypress(function(e) {
         if (e.keyCode === 13) { // keyCode 13은 Enter를 의미합니다.
           e.preventDefault(); 
           $("#searchForm").submit();
         }
       });
       $("#search_img").click(function() {
       	  $("#searchForm").submit();
       	});
	   

     //1차 카테고리메뉴 호버시
     $(".nav-item a.nav-link").on("mouseover", function(){
      console.log("1차 카테고리메뉴");
      
      //let urlacpt = $(this).attr("href") + 44444;
      let url = "/product/subCategory/" + $(this).attr("href");
        console.log("2차 :"+url);
      let curAnchor = $(this); // ajax메서드 호출전에 선택자 this를 전역변수로 받아야 한다.

        

         $.getJSON(url, function(data){
         
         // 2차카테고리 정보를 모두 삭제해라.(기존제거)
         $(".depth2_subbox").each(function(){
            
           $(this).empty();
         });
         $(".depth3_subbox").each(function(){
             
             $(this).empty();
           });


           //subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate"));
         let subCategoryStr = "";
         for(let i=0; i<data.length; i++) {
            //data[i].cate_code;
            //data[i].cate_name;
            let selector = "#subCategory_" + data[i].cate_prtcode;
            console.log(data[i].cate_prtcode);
                console.log(selector);
            //selector.css("display", "inline");
            //console.log("선택자: " + selector)
            //$(selector).empty();
                plusUrl = "/";
                subCategoryStr = "<a class='nav-link sub_cate' id='" + data[i].cate_prtcode + "&amp;cate_subprtcode=" + data[i].cate_code + "' href=" + data[i].cate_prtcode + plusUrl + data[i].cate_code +">" + data[i].cate_name + "</a>";
                console.log(subCategoryStr);
                console.log("데이타개수"+data.length);
            $(selector).append(subCategoryStr);
                //let subCate_href = new Array();
                //subCate_href[i] = data[i].cate_prtcode + plusUrl + data[i].cate_code;
          }
         
            //let subCate = $(this).children(".sub_cate");
            
            
                // $(subCate).on("click", function(){
                // let url = $(this).attr("href");
                // console.log(url);
                //         return false;
                // });
            
            

            //console.log(data);
        });
      
    });

    // 1차 카테고리 클릭시
    $(".nav-item a.nav-link").on("click", function(){
        let mainCateUrl = "/product/productList?cate_prtcode=" + $(this).attr("href");
        location.href = mainCateUrl;

    });
        
    
    
         /*
         curAnchor.next().empty();
         curAnchor.next().append(subCategoryStr);
         */
         
         
//-------------------------------------------------------------------------------------------------------------------------
        
//2차 카테고리메뉴 호버시
$(document).on("mouseover", ".sub_cate", function(e){
   e.preventDefault();
 
    //let rew_score = $(this).parent().parent().find("[name='rew_score']").val();
    //let pro_price = $(this).parent().parent().find("td span.pro_price").text();
    console.log(this);
    
  console.log("2차 카테고리메뉴");
    console.log($(this).length);
  
   let urlacpt = $(this).attr("href");
    console.log(urlacpt);
 let url = "/product/lastsubCategory/" + urlacpt;
    console.log(url);
 let curAnchor = $(this); // ajax메서드 호출전에 선택자 this를 전역변수로 받아야 한다.

 
    $.getJSON(url, function(data){

        console.log("after : " + "/product/lastsubCategory/" + urlacpt);
       
       //console.log(data);
    //$(this).parent().parent().find("[name='rew_score']").val()
        //let curAnchorUnder = curAnchor.parent().parent().parent().find('ul.depth3');
    // 3차카테고리 정보를 모두 삭제해라.(기존제거)
    $(".depth3_subbox").each(function(){
       
      $(this).empty();
    });


      //subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate"));
    
    let lastsubCategoryStr = "";
       for(let i=0; i<data.length; i++) {
          //data[i].cate_code;
          //data[i].cate_name;
          let selector = "#lastsubCategory_" + data[i].cate_prtcode;
          //selector.css("display", "inline");
          console.log("선택자: " + selector)
          //$(selector).empty();
              plusUrl = "/";
          lastsubCategoryStr = "<a class='lastsub_cate' id='" + data[i].cate_code + "&amp;cate_prtcode=" + data[i].cate_prtcode + "&amp;cate_subprtcode=" + data[i].cate_subprtcode +"' href='cate_code=" + data[i].cate_subprtcode +"'>" + data[i].cate_name + "</a>";
        //"/product/productList?cate_code=" + cate_code + "cate_prtcode=" + data[i].cate_prtcode + "&cate_code= " + data[i].cate_subprtcode
          $(selector).append(lastsubCategoryStr);
          console.log("선택자:2 " + lastsubCategoryStr)
        }

    });

    // 2차 카테고리 클릭시
    /*
    $(document).on("click", ".sub_cate", function(e){
    	e.preventdefault()
        let mainCateUrl = "/product/productSubList?cate_prtcode=" + $(this).attr("id");
        location.href = mainCateUrl;

    });
    */
    /*
    curAnchor.next().empty();
    curAnchor.next().append(subCategoryStr);
    */

  
   //-------------------------------------------------------------------------------------------------------------------------
   //마지막 카테고리 클릭시
           $(".depth2 ul").on("click", "a.sub_cate", function(e){
              e.preventDefault();

               console.log("2차카테고리 클릭");
                location.href = "/product/productList?cate_prtcode=" + $(this).attr("id");
                //"/product/productList?cate_prtcode=" + data[i].cate_prtcode + "&cate_code= " + data[i].cate_code
             });
    //-------------------------------------------------------------------------------------------------------------------------
           $(".depth3 ul").on("click", "a.lastsub_cate", function(e){
               e.preventDefault();

                console.log("3차카테고리 클릭");
                 location.href = "/product/productList?cate_code=" + $(this).attr("id");
                 //"/product/productList?cate_code=" + cate_code + "cate_prtcode=" + data[i].cate_prtcode + "&cate_code= " + data[i].cate_subprtcode
              });
    
         
    
});
         
  





});
   
   /*
	let TimeLogout = function(){
		session.setMaxInactiveInterval(1*60);
 		//session소멸시 로그인페이지 이동
	   if (session.getAttribute("timeLogout") != null) {
		    session.removeAttribute("loginStatus");
			session.removeAttribute("timeLogout");
				
			if (!confirm("세션종료로 로그아웃되었습니다. 다시 로그인 하시겠습니까?")) {
	       // 취소(아니오) 버튼 클릭 시 이벤트
		   location.reload();
		   } else {
		       // 확인(예) 버튼 클릭 시 이벤트
			   response.sendRedirect("/user/login");
		   }
		}
	};			
	TimeLogout();
   */
   
   

</script>

<script>

$(document).ready(function() {
	//--------------------------------
	
	//장바구니 총개수 23-03-09일 작업 -최종 버전.
	let cartTotal = function(){
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
	cartTotal();
	
//----------------		
		
		// .topbnr_close 클릭시
		let topbnr_hide = getCookie("topbnr_hide");
	    let now = new Date();
	   
	   // 쿠키가 있고, 쿠키가 만료되지 않았으면, 오늘하루그만보기 요소를 숨깁니다.
	   if (topbnr_hide && now.getTime() < parseInt(topbnr_hide)) {
		     $('.wrap_gnb').addClass('fixed');
			 $('#header').addClass('fixed2');
	   }
	   
	   $(".wrap_gnb .topbnr_close").on("click", function(){
	     // 쿠키 만료 시간을 계산합니다.
	     let midnight = new Date();
	     midnight.setHours(24, 0, 0, 0);
	     // 쿠키 이름 'topbnr_hide', 쿠키 값 현재 시간+24시간으로 설정.
	     document.cookie = 'topbnr_hide=' + (now.getTime() + (24 * 60 * 60 * 1000)) + ';expires=' + midnight.toUTCString() + ';path=/';
	     // 오늘하루그만보기 요소를 숨깁니다.
	     $('.wrap_gnb').addClass('fixed');
		 $('#header').addClass('fixed2');
	   });
	   
	   // 쿠키 이름으로 쿠키 값을 가져오는 함수
	   function getCookie(name) {
	     let value = "; " + document.cookie;
	     let parts = value.split("; " + name + "=");
	     if (parts.length == 2) return parts.pop().split(";").shift();
	   };


});
	
	


	       
	      
</script>
           			

          


<script>
    // style 스크립트
    
    // 스크롤시 header 스타일 변경
    $(window).scroll(function(evt) {
        var y = $(this).scrollTop();
        if (y > 3) {
        $('#header').addClass('fixed');
        $('.header_top').addClass('fixed');
        } else{
        $('#header').removeClass('fixed');
        $('.header_top').removeClass('fixed');
        }
    });
    
 	
</script>
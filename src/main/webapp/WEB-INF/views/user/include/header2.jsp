<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/user/include/plugin_js.jsp"%>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Shop Homepage - Start Bootstrap Template</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/styles.css" rel="stylesheet" />

<!-- Header-->
<header class="bg-light">
	<div class="container header-top">
		<c:if test="${sessionScope.loginStatus == null }">
			<a class="p-2 text-dark" href="/user/login">로그인</a>
			<a class="p-2 text-dark" href="/user/join">회원가입</a>
		</c:if>
		<!-- 로그인 이후상태 표시 -->
		<c:if test="${sessionScope.loginStatus != null }">
			<a class="p-2 text-dark" href="/user/logout">로그아웃</a>
			<a class="p-2 text-dark" href="/user/modify">회원수정</a>
			<a class="p-2 text-dark" href="/user/mypage">마이페이지</a>
			<a class="p-2 text-dark" href="/cart/cartList"> <i
				class="bi-cart-fill me-1"></i>장바구니
			</a>
		</c:if>
	</div>

	<!-- Navigation-->
	<div class="brand container">
		<a class="navbar-brand" href="/">K-chef</a>
	</div>

	<!-- 네비 메뉴  -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<c:forEach items="${userCategory}" var="categoryVO">
						<li class="nav-item dropdown"><a class="nav-link"
							id="navbarDropdown" href="${categoryVO.cate_code }" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">${categoryVO.cate_name }</a>
							<div class="subCategory"
								id="subCategory_${categoryVO.cate_code }"></div></li>
					</c:forEach>
				</ul>
				<div class="navbar-nav">
					<a class="nav-link" href="" role="button">이벤트</a> <a
						class="nav-link" href="/review/allProductReview" role="button">리뷰</a>
					<a class="nav-link" href="" role="button">메뉴찾기</a>
				</div>
			</div>
		</div>
	</nav>

	<script>
  $(function(){
        
      //1차카테고리 클릭시
      $(".nav-item a.nav-link").on("click", function(){
        console.log("1차카테고리");

        let url = "/product/subCategory/" + $(this).attr("href");
        let curAnchor = $(this); // ajax메서드 호출전에 선택자 this를 전역변수로 받아야 한다.

          $.getJSON(url, function(data){
          
          // 2차카테고리 정보를 모두 삭제해라.(기존제거)
          $(".nav-item div.subCategory").each(function(){
              
              $(this).empty();
          });


            //subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate"));
          let subCategoryStr = "";
          for(let i=0; i<data.length; i++) {
              //data[i].cate_code;
              //data[i].cate_name;
              let selector = "#subCategory_" + data[i].cate_prt_code;
              //selector.css("display", "inline");
              //console.log("선택자: " + selector)
              //$(selector).empty();
              subCategoryStr = "<a class='sub_cate nav-link-n' href='" + data[i].cate_code + "'>" + data[i].cate_name + "</a>";
              $(selector).append(subCategoryStr);
          }
          
          
          /*
          curAnchor.next().empty();
          curAnchor.next().append(subCategoryStr);
          */

          });
      });

      $("div.subCategory").on("click", "a.sub_cate", function(e){
        e.preventDefault();

        //console.log("2차카테고리 클릭");
        location.href = "/product/productList?cate_code=" + $(this).attr("href");
      });
    });
  </script>
</header>
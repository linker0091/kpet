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
<title>- KPET</title>

<!-- Bootstrap core CSS -->
<!-- <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://getbootstrap.com/docs/4.6/dist/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/slick.css">

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

#header {
	z-index: 999999;
}
</style>
</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>


	<!-- 슬라이드 -->
	<div class="slide_nav_box">
		<div class="slide_box">
			<div class="slider">
				<a href="#">
					<div class="main_txt">
						<span class="t0" style="background-color: #53a3a4;">0원 체험</span>
						<div class="t1">
							첫 구매시<br>
							<strong>인기 상품이 0원</strong>
						</div>
						<div class="t2">신규회원 체험 이벤트</div>
					</div> <img src="img/banner_visual_83.jpg" alt="">
				</a>
			</div>
			<div class="slider">
				<a href="#">
					<div class="main_txt">
						<span class="t0" style="background-color: #00A0BE;">신상품</span>
						<div class="t1">
							Kpet Dr.HOOH<br>
							<strong>맞춤솔루션 동결건조 트릿</strong>
						</div>
						<div class="t2">유산균/관절 케어/덴탈 케어</div>
					</div> <img src="img/banner_visual_101.jpg" alt="">
				</a>
			</div>
			<div class="slider">
				<a href="#">
					<div class="main_txt">
						<span class="t0" style="background-color: #D9307D;">재출시</span>
						<div class="t1">
							휴먼그레이드 맞춤솔루션<br>
							<strong>관절건강 오리</strong>
						</div>
						<div class="t2">강아지 전연령</div>
					</div> <img src="img/banner_visual_109.jpg" alt="">
				</a>
			</div>
			<div class="slider">
				<a href="#">
					<div class="main_txt">
						<span class="t0" style="background-color: #7B4285;">신상품</span>
						<div class="t1">
							휴먼그레이드<br>
							<strong>펫후 TRUE 심쿵츄르</strong>
						</div>
						<div class="t2">닭고기&amp;참치 / 닭고기&amp;호박</div>
					</div> <img src="img/banner_visual_114.jpg" alt="">
				</a>
			</div>
			<div class="slider">
				<a href="#">
					<div class="main_txt">
						<span class="t0" style="background-color: #744A36;">신상품</span>
						<div class="t1">
							휴먼그레이드<br>
							<strong>펫후 TRUE 심쿵츄르</strong>
						</div>
						<div class="t2">닭고기&amp;참치 / 닭고기&amp;호박</div>
					</div> <img src="img/banner_visual_117.jpg" alt="">
				</a>
			</div>
			<div class="slider">
				<a href="#">
					<div class="main_txt">
						<span class="t0" style="background-color: #DA2E45;">신상품</span>
						<div class="t1">
							휴먼그레이드<br>
							<strong>펫후 TRUE 심쿵츄르</strong>
						</div>
						<div class="t2">닭고기&amp;참치 / 닭고기&amp;호박</div>
					</div> <img src="img/banner_visual_121.jpg" alt="">
				</a>
			</div>
		</div>
	</div>

	<!-- 슬라이드 END -->

	<div class="container">
		<div class="main_product_wrap">
			<h2>우리 아이는?</h2>
			<div class="tab_menu">
				<ul class="clearfix">
					<li class="tab_btn current" id="1">고양이예요</li>
					<li class="tab_btn" id="2">강아지예요</li>
				</ul>
			</div>
			<p class="tab_title">펫후's PICK</p>

			<!-- Cat(1) -->
			<div class="row" id="tab_box">
				<!-- 상품 페이지 -->
				<div class="col-sm-7"></div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>
	<script type="text/javascript" src="/resources/js/slick.min.js"></script>

	<script>
      // 슬라이드 부분
  $(document).ready(function(){
    $(".slide_box").slick({
      slide: 'div',		//슬라이드 되어야 할 태그 ex) div, li 
      infinite : true, 	//무한 반복 옵션	 
      slidesToShow : 2,		// 한 화면에 보여질 컨텐츠 개수
      slidesToScroll : 1,		//스크롤 한번에 움직일 컨텐츠 개수
      speed : 600,	 // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
      arrows : true, 		// 옆으로 이동하는 화살표 표시 여부
      dots : true, 		// 스크롤바 아래 점으로 페이지네이션 여부
      autoplay : true,			// 자동 스크롤 사용 여부
      autoplaySpeed : 5000, 		// 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
      pauseOnHover : true,		// 슬라이드 이동	시 마우스 호버하면 슬라이더 멈추게 설정
      vertical : false,		// 세로 방향 슬라이드 옵션
      prevArrow : "<button type='button' class='slick-prev'>Previous</button>",		// 이전 화살표 모양 설정
      nextArrow : "<button type='button' class='slick-next'>Next</button>",		// 다음 화살표 모양 설정
      dotsClass : "slick-pagenation clearfix", 	//아래 나오는 페이지네이션(점) css class 지정
      draggable : true, 	//드래그 가능 여부 
      
      responsive: [ // 반응형 웹 구현 옵션
        {  
          breakpoint: 960, //화면 사이즈 960px
          settings: {
            //위에 옵션이 디폴트 , 여기에 추가하면 그걸로 변경
            slidesToShow:3 
          } 
        },
        { 
          breakpoint: 768, //화면 사이즈 768px
          settings: {	
            //위에 옵션이 디폴트 , 여기에 추가하면 그걸로 변경
            slidesToShow:2 
          } 
        }
      ]

    });
      
    $(function(){
      getTabProduct(1);
    });
      
    let getTabProduct = function(tab_num) {
      //alert(tab_num);
          $("#tab_box").load("/product/tabProduct?cate_prtcode=" + tab_num);
      }
    
    // contents 탭버튼메뉴 클릭시
      $(".tab_btn").on("click", function(){
        console.log("클릭");
        let tab_num = $(this).attr("id");
        console.log(tab_num);
        $.ajax({
                url: "/product/tabProduct",
                type: 'post',
                dataType: 'text',
                data: {cate_prtcode : tab_num},
                success: function(data) {
                    console.log(data);
                    
                    getTabProduct(tab_num);
                  }
              })
            });    
  });
    
  </script>
	<script>
  //로그인 성공
  let result = '${result}';
  if(result == 'success') {
      alert("로그인 성공.");
  }
    
      let msg = '${msg}'; // EL구문.  'modifyFail'
      if(msg == 'modifyOk'){
        alert("회원정보가 수정되었습니다.");
      }
    
  </script>

	<script>
  //.topbnr_close 클릭시
    $(".tab_menu .tab_btn").on("click", function(){
      $(".tab_menu .tab_btn").removeClass('current');
      $(this).addClass('current');
    });
  </script>
</body>
</html>

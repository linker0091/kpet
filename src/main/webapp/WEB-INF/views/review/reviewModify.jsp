<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<link href="/css/review.css" rel="stylesheet" />
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js"></script>
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
  </head>
  <body>
    
<%@include file="/WEB-INF/views/user/include/header.jsp" %>

<div class="container">
  <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  <h1 class="product_reviews_keyword__title">펫후 상품 후기</h1>
</div>

<div class="reviews_index__head">
      
  <div class="widget_header_basic">
  <div class="widget_header_basic__title_container">
    
      <span class="widget_header_basic__title js-translate-text">
      	  상품후기
      </span>

  </div>
</div>

<div class="container-xl">
	<div class="row">
		<div class="my-4 col-md-8 mx-auto">
			<div id="rating" class="review_form contact-form">
				<form action="/review/reviewModify" id="reviewModify"  method="post" enctype="multipart/form-data">
					<div class="form-group">
						<div class="rating col-sm-6">
									<p id="star_grade" class="form-control">
										<a href="#">★</a>
										<a href="#">★</a>
										<a href="#">★</a>
										<a href="#">★</a>
										<a href="#">★</a>
									</p>
									<input type="hidden" id="rew_score" name="rew_score">
					</div>          
					
					
					
					<div class="product_review_inline-block">
								<input type="hidden" name="rew_score" value="${ReviewVO.rew_score }">
								<c:set var="star" />
								<c:choose>
									<c:when test="${ reviewVO.rew_score eq 1 }">
										<c:set var="star" value="★☆☆☆☆" />
									</c:when>
									<c:when test="${ reviewVO.rew_score eq 2 }">
										<c:set var="star" value="★★☆☆☆" />
									</c:when>
									<c:when test="${ reviewVO.rew_score eq 3 }">
										<c:set var="star" value="★★★☆☆" />
									</c:when>
									<c:when test="${ reviewVO.rew_score eq 4 }">
										<c:set var="star" value="★★★★☆" />
									</c:when>
									<c:when test="${ reviewVO.rew_score eq 5 }">
										<c:set var="star" value="★★★★★" />
									</c:when>
								</c:choose>
								
								<span class="review_star"> <c:out value="${star }" /></span>	
								</div>
					
					
					  
					<div class="form-group col-md-6">
						<label class="col-form-label">후기 작성</label>
						<textarea class="form-control" id="rew_content" name="rew_content" rows="5" required ><c:out value="${ReviewVO.rew_content}" /></textarea>
					</div>
					  <div class="form-group">
				    <div class="col-md-4">
				      <label for="upload">사진 첨부</label>
				      <input type="file" id="upload" name="upload">
				      <!-- 이미지 변경시 기존이미지정보를 이용하여 기존이미지 삭제, 이미지 변경 안하면, 기존이미지 정보를 수정데이타로 사용 -->
					  	<input type="hidden" name="rew_uploadpath" value="<c:out value='${ReviewVO.rew_uploadpath}' />">
      					<input type="hidden" name="rew_img" value="<c:out value='${ReviewVO.rew_img}'/>">
				    </div>
				    </div>
  					  <div class="form-group">
				    <div class="col-md-4">
				      <label for="upload">미리보기</label>
				      <img name="reviewImage" id="previewImage" src="/review/displayFile?fileName=s_<c:out value='${ReviewVO.rew_img}'/>&uploadPath=<c:out value='${ReviewVO.rew_uploadpath}'/>">
				    </div>
				    <div class="col-md-4">
				      <label for="upload"></label>
				      </div>
				    </div>
						</div>		
					<input type="hidden" id="rew_num" name="rew_num" value="${ReviewVO.rew_num }">
					<input type="hidden" id="ord_code" name="ord_code" value="${ReviewVO.ord_code }">
					<input type="hidden" id="pro_num" name="pro_num" value="${ReviewVO.pro_num }">
					<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" id="amount" name="amount" value="${cri.amount }">
					<div class="row">
				    <div class="col-md-6">
					<button type="submit" id="btnReviewAdd" class="btn btn-primary form-control">상품후기수정</button>
					</div>
					<div class="col-md-6">
					<button type="button" id="btnReviewDel" class="btn btn-danger form-control">상품후기삭제</button>
					</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</div>

<script>
$(function(){

<!-- 상품이미지 미리보기 --> 
function readImage(input) {
    if (input.files && input.files[0]) {
        
      //let imgPath = input.files[0].value;
      let imgPath = $("#upload").val();
      alert(imgPath);
      //return;
      let ext = imgPath.substring(imgPath.lastIndexOf(".")+1).toLowerCase();
      alert(ext);
      if(typeof(FileReader) == "undefined") {
        alert("브라우저가 작업을 지원안합니다.");
        return;
      }

      if(ext == "gif" || ext == "png" || ext == "jpg" || ext == "jpeg" ) {
        
        const reader = new FileReader();
        

        //이벤트 설정. reader객체가 이미지파일을 성공적으로 읽어들였을 때 발생하는 이벤트
        reader.onload = (e) => {
            //alert("onload");
            const previewImage = document.getElementById('previewImage');
            previewImage.src = e.target.result;
        }

        // reader객체가 파일을 읽어들이는 작업
        reader.readAsDataURL(input.files[0]);
      }else{
        $("#upload").val("");
        alert("이미지 파일을 선택하세요.");
      }
    }
  }
  // 이벤트 리스너
  document.getElementById('upload').addEventListener('change', (e) => {
      readImage(e.target);
  })
  
  

    
            //상품 별점 클릭
        $("#rating").on("click", "#star_grade a", function(e){
          e.preventDefault();
          console.log("별")
          $(this).parent().children("a").removeClass("on") // 기존선택되어 추가된 on선택자를 제거. 변경
          $(this).addClass("on").prevAll("a").addClass("on");
          
          scoreCount();
        });


        let scoreCount = function() {
          	let point = 0;

	        $("#star_grade a").each(function(){
	            if($(this).attr("class") == "on") {
	              point += 1
	            }
	          });  
	        console.log("별" + point)
	          $("#rew_score").val(point);
	        }
        
        
        
        
     	// 수정전 상품 별점 뿌리기 ---------------- 내가 추가 절대 없애지마.
     	$(document).ready(function(){
     		<%-- //let beforePoint = $("input[name='rew_score']").val();--%>
			let beforePoint = ${ReviewVO.rew_score } -1;
			console.log(beforePoint);
			
			let starNum = $("#star_grade a").eq(beforePoint);
			console.log("스타넘" + starNum);
			starNum.addClass("on").prevAll("a").addClass("on");
			
			$(".rating input[name='rew_score']").val("${ReviewVO.rew_score }");
			<%-- starNum.on("click");--%>
     		
     	});
     	
     	//상품수정 클릭시
     	/*
        $("#reviewModify").on("submit", function(){
            //console.log("클릭");
    		let rew_score = $("#rew_score").val();
    		let rew_content = $("#rew_content").val();
    	
    	    if(rew_content == "" || rew_content == null){
    	        alert("내용을 입력하세요.");
    	        return false;
    	      }
    	    
    	    // 이전 페이지 URL 가져오기
    	    let prevPage = document.referrer;

    	    if (prevPage !== undefined) {
    	    	this.submit();
    	        window.location.href = prevPage;
    	    } else {
    	        // 이전 페이지가 없는 경우, 기존 폼의 액션 주소
    	        this.submit();
    	        location.href = "/order/orderComplete";
    	    }
         	
            });*/
            
     	//상품수정 클릭시
     	$("#reviewModify").on("submit", function(){
            //console.log("클릭");
    		let rew_score = $("#rew_score").val();
    		let rew_content = $("#rew_content").val();
    	
    	    if(rew_content == "" || rew_content == null){
    	        alert("내용을 입력하세요.");
    	        return false;
    	      }
    	             	
            });
     	
     	// 삭제 버튼 클릭시 동작
        $("#btnReviewDel").on("click", function(){
        	let rew_num = $("#reviewModify").find("input[name='rew_num']").val();
        	
            if(confirm("게시물을 삭제하겠습니까?")){
            	$("#reviewModify").attr("action", "/review/reviewDel")
            	$("#reviewModify").submit();
            }
          });
			
});


</script>
</div>		


  </body>
</html>

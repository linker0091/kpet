<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/pro_detail.css" rel="stylesheet" />


<div class="review_media">
	<a href="#" class="closebtn"> <img src="/img/ico_close_white.png">
	</a>
	<div class="review_media_container">
		<div class="review_media_txt">
			<spen>전체 사진</spen>
		</div>
		<div class="viewbox">
			<div class="viewbox_inner viewbox_inner1">
				<div class="review_media_collage_left clearfix">
					<ul>
						<c:forEach items="${reviewAllVO }" var="reviewVO"
							varStatus="status">
							<li class="review_media_medium"><img height="120"
								name="reviewImage"
								class="${status.first ? 'click_img' : ''}, ${reviewVO.rew_num }"
								data-type="${reviewVO.rew_num }"
								src="/review/displayFile?fileName=s_<c:out value="${reviewVO.rew_img }"></c:out>&uploadPath=<c:out value="${reviewVO.rew_uploadpath }"></c:out>">
							</li>
							<c:if test="${status.first}">
								<input type="hidden" name="rew_num" id="last_rew_num"
									value="${reviewVO.rew_num}">
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="viewbox_inner viewbox_inner2" style="display: block;"></div>
			<div class="viewbox_inner viewbox_inner3" style="display: none;"></div>
			<div class="viewbox_inner viewbox_inner4" style="display: none;"></div>
		</div>

		<div class="review_media_collage_right">
			<div class="review_product_info clearfix">
				<div class="top_box clearfix">
					<img class="title_img" name="proImage" id="pro_img" width="20%"
						src="/product/displayFile?fileName=s_<c:out value="${ProductVO.pro_img }"></c:out>&uploadPath=<c:out value="${ProductVO.pro_uploadpath }"></c:out>">
					<input type="hidden" name="pro_num" id="pro_num"
						value="${ProductVO.pro_num }">
					<div class="rew_title">
						<span class="">${ProductVO.pro_name }</span>
					</div>
					<div class="rew_title">
						<span class="">평균 ★ ${ProductVO.pro_rewrating }</span> <span
							class="">리뷰 ${ProductVO.pro_rewcount }</span>
					</div>
				</div>
			</div>
			<div class="review_media_content" id="review"></div>
		</div>
	</div>
</div>

<script>
  $(function() {
  //이미지의 리뷰 정보 보기
        let rew_num = ${rew_num};
        getReview(rew_num);
      
  
      function getReview(rew_num) {
          $("#review").load("/review/oneReview?rew_num=" + rew_num);
          $(".review_media_medium img").removeClass("click_img");
          $("." + rew_num).addClass("click_img");			  
        }
      
      $('.review_media_medium img').click(function() {
        $('.review_media_medium img').removeClass("click_img");
        $(this).addClass("click_img");

        let rew_num = $(this).data('type');
            getReview(rew_num);
      });
      
    
    //상품 전체 이미지에서 창 닫기 클릭
      $('.closebtn').on('click', function(e) {
            e.preventDefault();
        let pro_num = $('#pro_num').val();
            window.history.back();
      });
  });  

  </script>
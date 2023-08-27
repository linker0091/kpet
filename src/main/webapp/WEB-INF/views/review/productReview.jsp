<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
#rew_paging {
	margin-bottom: 40px;
}
</style>

<div class="pro_review_header1 clearfix">
	<span> 리뷰 </span> <span>${ProductVO.pro_rewcount}</span><span> |</span>
	<span class="review_star"> ★ </span> <span>${ProductVO.pro_rewrating}</span>
</div>

<div class="product_review_media">
	<span class="product_review_title"> <b>포토</b></span>
	<c:if test="${not empty reviewListVO}">
		<span class="product_review_title" style="font-weight: bold;">
		</span>
		<div class="product_review_media_show_all">
			<span class="show_all"><a href="#"
				data-pronum="${ProductVO.pro_num}" class="all_img_btn"> 전체보기 </a></span>
		</div>
		<button class="scrollX_left"><</button>
		<button class="scrollX_right">></button>
		<div class="product_review_media_sm">
			<ul>
				<c:forEach items="${reviewImg }" var="review" varStatus="status">
					<li><img width="80" height="80" name="reviewImage"
						id="${review.rew_num}" data-pronum="${ProductVO.pro_num}"
						src="/review/displayFile?fileName=<c:out value="${review.rew_img }"></c:out>&uploadPath=<c:out value="${review.rew_uploadpath }"></c:out>">
					</li>
				</c:forEach>
			</ul>
		</div>

		<c:if test="${empty reviewImg}">
			<div
				style="text-align: center; margin-top: 30px; margin-bottom: 30px;">
				<p>등록된 이미지 리뷰가 없습니다.</p>
			</div>
		</c:if>
	</c:if>
</div>


<c:if test="${not empty reviewListVO}">
	<c:forEach items="${reviewListVO }" var="reviewVO" varStatus="status">
		<div class="product_review_padding-bottom">
			<div class="product_review_content">
				<div class="product_review_inline-block">
					<input type="hidden" name="rew_num" value="${reviewVO.rew_num }">
					<input type="hidden" name="rew_score"
						value="${reviewVO.rew_score }">
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

					<span class="review_star info_review_star"> <c:out
							value="${star }" /></span>
					<div class="product_review_content_right product_review_date">
						<fmt:formatDate value="${reviewVO.rew_regdate }"
							pattern="yyyy-MM-dd HH:mm" />
					</div>
				</div>
			</div>

			<div class="product_review_padding-top">
				<span class="product_review_content_text">${reviewVO.rew_content }</span>
				<br>
			</div>
			<div class="product_review_padding-top">
				<ul>
					<li><c:if test="${not empty reviewVO.rew_img}">
							<img width="150" height="150" name="reviewImage" id="${review.rew_num}"
								data-pronum="${ProductVO.pro_num}"
								src="/review/displayFile?fileName=<c:out value="${reviewVO.rew_img }"></c:out>&uploadPath=<c:out value="${reviewVO.rew_uploadpath }"></c:out>">
						</c:if></li>
				</ul>
			</div>
			<div class="product_review_content_user">
				${fn:substring(reviewVO.user_id, 0, 2)  }*** <span>님의 리뷰
					입니다</span>
			</div>
		</div>
	</c:forEach>

	<div id="rew_paging">
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<c:if test="${rewPageMaker.prev }">
					<li
						class='paginate_button previous ${rewPageMaker.prev ? "": "disabled" }'
						id="example2_previous"><a
						href="${rewPageMaker.startPage - 1}" aria-controls="example2"
						data-dt-idx="0" tabindex="0"><</a></li>
				</c:if>
				<c:forEach begin="${rewPageMaker.startPage }"
					end="${rewPageMaker.endPage }" var="num">
					<li
						class='paginate_button ${rewPageMaker.cri.pageNum == num ? "active":"" }'><a
						href="${num}" aria-controls="example2" data-dt-idx="1"
						tabindex="0">${num}</a></li>
				</c:forEach>
				<c:if test="${rewPageMaker.next }">
					<li class="paginate_button next" id="example2_next"><a
						href="${rewPageMaker.endPage + 1}" aria-controls="example2"
						data-dt-idx="7" tabindex="0">></a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</c:if>
<c:if test="${empty reviewListVO}">
	<div style="text-align: center; margin-top: 30px; margin-bottom: 30px;">
		<p>리뷰가 없습니다.</p>
		<b>리뷰를 작성해 보세요!</b>
	</div>
</c:if>

<!--prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
<form id="reviewForm" action="/review/productReview" method="get">
	<input type="hidden" id="rewPageNum" name="pageNum"
		value="${rewPageMaker.cri.pageNum}"> <input type="hidden"
		id="rewAmount" name="amount" value="${rewPageMaker.cri.amount}">
</form>

<script>
      
  $(function() {
      // 페이지 버튼 클릭시 이벤트
      $("#rew_paging").on("click", ".paginate_button a", function(e) {
        e.preventDefault();
        let rewPageNum = $(this).attr("href");
        let rewAmount = $('#rewAmount').val();
        $("#reviewForm").find("input[name='pageNum']").val(rewPageNum);
        $("#reviewForm").find("input[name='amount']").val(rewAmount);
        $(".product_review_tab").trigger("click");//리뷰 탭을 클릭한 효과
      });
    
    
      //리뷰사진 클릭시
          $("img[name='reviewImage']").on("click",  function(e){ 
            e.preventDefault();
            
            console.log("클릭");
        
            // pro_num 가져오기
            let pro_num = $(this).data("pronum");
            let rew_num = $(this).attr("id");
            
            // 새로운 링크 생성
            let newLink = '/review/productReviewImg?pro_num=' + pro_num + '&rew_num=' + rew_num;

            // 기존 링크 변경
            location.href = newLink;
          });
      
      // 리뷰이미지 가로스크롤 제어
        let moveScrollLeft = function() {
          let scrollX = $(".product_review_media_sm").scrollLeft();
            $('.product_review_media_sm').scrollLeft(scrollX - 82);
        };
        
        let moveScrollRight = function() {
            let scrollX = $(".product_review_media_sm").scrollLeft();
            $('.product_review_media_sm').scrollLeft(scrollX + 82);
        };
        
        $(".scrollX_left").on("click", function(){
          moveScrollLeft();
        });
        
        $(".scrollX_right").on("click", function(){
          moveScrollRight();
        });
      
      // 전체 보기 클릭
      $('.all_img_btn').attr('href', newLink);
          let newLink = '/review/productReviewImg?pro_num=' + pro_num; 
            location.href = newLink;
      });
      
      
  </script>

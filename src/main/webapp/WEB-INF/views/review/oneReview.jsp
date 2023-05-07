<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
	<style>
	#review { margin-top:100px; }
	.closebtn img { width:22px; height: 22px;  transition: none; 
    filter: opacity(0.6); }
	</style>

<img height="120" class="one_rew_img" name="reviewImage" src="/review/displayFile?fileName=<c:out value="${review.rew_img }"></c:out>&uploadPath=<c:out value="${review.rew_uploadpath }"></c:out>">
 <div class="product_review_inline-flex clearfix">
<input type="hidden" name="rew_num" value="${review.rew_num }">
								<c:set var="star" />
								<c:choose>
									<c:when test="${ review.rew_score eq 1 }">
										<c:set var="star" value="★☆☆☆☆ 별로예요" />
									</c:when>
									<c:when test="${ review.rew_score eq 2 }">
										<c:set var="star" value="★★☆☆☆ 그냥 그래요" />
									</c:when>
									<c:when test="${ review.rew_score eq 3 }">
										<c:set var="star" value="★★★☆☆ 보통이예요" />
									</c:when>
									<c:when test="${ review.rew_score eq 4 }">
										<c:set var="star" value="★★★★☆ 맘에 들어요" />
									</c:when>
									<c:when test="${ review.rew_score eq 5 }">
										<c:set var="star" value="★★★★★ 아주 좋아요"/>
									</c:when>
								</c:choose>

			                    <span class="review_list_v2__score"><c:out value="${star }" /></span>
 </div>
 <div class="product_review_date">
             <fmt:formatDate value="${review.rew_regdate }" pattern="yyyy-MM-dd" />
</div>
 <div class="product_review_margin-tb">
 <div class="review_media_user_content">
         <b> ${fn:substring(review.user_id, 0, 2)  }*** </b>님의 리뷰입니다.
 </div>
  <span>리뷰번호${review.rew_num }</span> 
 				  <span>${review.rew_content }</span> 
 </div>


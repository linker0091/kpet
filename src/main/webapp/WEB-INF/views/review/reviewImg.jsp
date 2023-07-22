<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div class="review_media">
	<div class="review_mediac_ontainer">
		<div class="review_media_txt"></div>
		<div class="review_media_collage_left">
			<div>
				<ul>
					<c:forEach items="${proReviewVO}" var="reviewVO" varStatus="status">
						<li class="review_media_medium"><c:if
								test="${reviewVO.rew_img != null }">
								<img height="120" name="reviewImage"
									src="/review/displayFile?fileName=s_<c:out value="${reviewVO.rew_img}"></c:out>&uploadPath=<c:out value="${reviewVO.rew_uploadpath}"></c:out>">
							</c:if></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="review_media_collage_right">
			<div class="review_product_info"></div>
			<div class="review_media_content">
				<div class="product_review_inline-flex">별점</div>
				<div class="product_review_date">날짜</div>
				<div class="product_review_margin-tb">
					<div class="review_media_user_content"></div>
				</div>
			</div>
		</div>
	</div>
</div>
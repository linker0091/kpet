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

    <!-- Custom styles for this template -->
    <link href="pricing.css" rel="stylesheet">
    <style>
    	.dropdown-item input { cursor: pointer; }
    	.dropdown-item label { cursor: pointer; }
    	.dropdown-item span {  cursor: pointer; }
    	.img_boxing { position: relative; padding-top: 100%; overflow: hidden; cursor: pointer;}
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
        REVIEW
      </span>

  </div>
</div>

<div class="filter_sort_basic menu">
  <ul class="filter_sort_basic__sort_search_list filter_sort_basic__sort_search_list--review_searchable">
    <li class="filter_sort_basic__sort">
 
<div class="filter_sort_basic menu">
	<ul class="orderby filter_sort_basic__sort_search_list filter_sort_basic__sort_search_list--review_searchable">
    <li class="orderbyItem filter_sort_basic__sort_list_item js-review-sort-list-item" >
    <a href="#" data-orderby="regdate">최신순</a>
    </li>
    <li class="orderbyItem filter_sort_basic__sort_list_item js-review-sort-list-item">
    <a href="#" data-orderby="score">별점순</a>
    </li> 
</ul>
<!-- orderby 인풋 추가 04/09 -->
<input type="hidden" id="orderby" name="orderby" value="${orderby }">
</div>
    </li>
      <li class="filter_sort_basic__search js-filter-search-component js-search-toggle">     
    <div class="filter_sort_basic__search_input_container">
		<div class="input-group mb-3">
	  <input type="text" class="form-control" id="rew_search" name="keyword" placeholder="리뷰 키워드 또는 상품 검색" value="<c:out value="${con.keyword}" />">
	  <div class="input-group-append">
		<button class="btn btn-light" type="button"><img height="10px" src="/img/search_close.png"></button>
	  </div>
	</div>
														
      </div>     
      </li>
  </ul>
  
  <div class="filter_sort_basic__filter_wrapper">
    <ul class="filter_sort_basic__filter_list js-filter-list">       
  <li class="filter_sort_basic__filter">
  <div class="dropdown form-control">
<select class="dropdown-toggle" id="category" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <option value="">전체 카테고리</option>
  <c:forEach items="${userCategory}" var="categoryVO">
    <option class="dropdown-item" value="${categoryVO.cate_code}" <c:if test="${categoryVO.cate_code eq con.cate_prtcode}">selected</c:if>>${categoryVO.cate_name}</option>
  </c:forEach>
</select>

</div>
  </li>

    <li class="filter_sort_basic__filter"> 
<div class="dropdown form-control">
  <button class="dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
   	<span id=ScoreTxt>별점</span>  </button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <div class="dropdown-header">별점 <button class="reset-btn">초기화</button></div>
    <div class="dropdown-divider"></div>

		<div class="dropdown-item">
		  <span>★★★★★ </span><label for="rating-5">아주 좋아요</label>
		  <input data-score="5" type="checkbox" id="rating-5">
		</div>
		<div class="dropdown-item">
		  <span>★★★★☆ </span><label for="rating-4">맘에 들어요</label>
		  <input data-score="4" type="checkbox" id="rating-4">
		</div>
		<div class="dropdown-item">
		  <span>★★★☆☆ </span><label for="rating-3">보통이예요</label>
		  <input data-score="3" type="checkbox" id="rating-3">
		</div>
		<div class="dropdown-item">
		  <span>★★☆☆☆ </span><label for="rating-2">그냥 그래요</label>
		  <input data-score="2" type="checkbox" id="rating-2">
		</div>
		<div class="dropdown-item">
		  <span>★☆☆☆☆</span><label for="rating-1">별로예요</label>
		  <input data-score="1" type="checkbox" id="rating-1">
		</div>	
	<c:set var="scoreStr" value="${empty con.scores ? '' : fn:join(con.scores, ',')}" />
	<input type="hidden" id="rew_scores" name="scores" value="${scoreStr}">	
    
    <div class="dropdown-divider"></div>
    <button class="dropdown-item complete-btn">완료</button>
</div>
</div> 
    </li>  
    </ul>
  </div>
</div>
    </div>
    <div>
    <ul>
    <c:forEach items="${reviewListVO }" var="reviewVO" varStatus="status">
    <li class="review_list_v2 review_list_v2--collapsed renewed_review renewed_review--comments_expanded js-review-container" data-message-initial-rows="3" data-review-content-height="54" data-nonmember-review-check-edit-url="/pethooh.com/nonmember_reviews/edit_popup?id=26111&amp;widget_env=100&amp;widget_id=1" data-nonmember-review-check-delete-url="/pethooh.com/nonmember_reviews/delete_popup?id=26111&amp;widget_env=100" id="review_26111">
  <div class="review_list_v2__review_lcontent">
    <div class="review_list_v2__review_container"> 
    <!-- 
        <div class="review_list_v2__tag_section">
  <span class="review_list_v2__tag review_badge__new">NEW</span>
  <span class="review_list_v2__tag review_badge__reorder">재구매</span>
        </div>
       -->
      <div class="src_section review_list_v2__score_section">
          <div class="review_list_v2__score_container">
            <div class="review_list_v2__score_star">
              <input type="hidden" name="rew_num" value="${reviewVO.rew_num }">
								별점.${reviewVO.rew_score } <input type="hidden" name="rew_score" value="${reviewVO.rew_score }">
								<c:set var="star" />
								<c:choose>
									<c:when test="${ reviewVO.rew_score eq 1 }">
										<c:set var="star" value="★☆☆☆☆ 별로예요" />
									</c:when>
									<c:when test="${ reviewVO.rew_score eq 2 }">
										<c:set var="star" value="★★☆☆☆ 그냥 그래요" />
									</c:when>
									<c:when test="${ reviewVO.rew_score eq 3 }">
										<c:set var="star" value="★★★☆☆ 보통이예요" />
									</c:when>
									<c:when test="${ reviewVO.rew_score eq 4 }">
										<c:set var="star" value="★★★★☆ 맘에 들어요" />
									</c:when>
									<c:when test="${ reviewVO.rew_score eq 5 }">
										<c:set var="star" value="★★★★★ 아주 좋아요"/>
									</c:when>
								</c:choose>
								
			                    <span class="review_list_v2__score"><c:out value="${star }" /></span>
            </div>

        <div class="review_list_v2__edit_container"> 
            <div class="review_list_v2__date">
            <fmt:formatDate value="${reviewVO.rew_regdate }" pattern="yyyy-MM-dd" />
            </div>
        </div>
      </div>

        <div class="review_list_v2__product_section ">
            <div class="review_list_v2__product_container">
              <div class="review_list_v2__product_image_container">
  				<img class="review_list_v2__product_image js-review-media smooth" name="proImage" id="pro_img" width="100%" height="225" src="/product/displayFile?fileName=s_<c:out value="${reviewVO.pro_img }"></c:out>&uploadPath=<c:out value="${reviewVO.pro_uploadpath }"></c:out>">
              </div>
              <div class="review_list_v2__info_container">
             	<input type="hidden" name="pro_num" id="pro_num" value="${reviewVO.pro_num }">
                <div class="review_list_v2__product_name"  >
                   <span class="review_list_v2__score">${reviewVO.pro_name }</span>
                 </div>
                <div class="review_list_v2__review_info">
                    <span class="review_list_v2__score_icon"></span>
                    <span class="review_list_v2__score" style="color:#ffd500cf">평균별점 ★ ${reviewVO.pro_rewrating }</span>
                    
                  <span class="review_list_v2__reviews_count"> 리뷰 ${reviewVO.pro_rewcount }</span>
<!--                     <span class="review_list_v2__score">${tot_rating}</span>
                  <span class="review_list_v2__reviews_count">${tot_count}개</span> -->
                </div>
              </div>
            </div>
        </div>

        <div class="review_list_v2__content_section">
          <div class="review_list_v2__content_container review_content  js-review-content-container">
            <div class="review_list_v2__content review_content__collapsed">
              <div class="review_list_v2__message_container">
                <div class="review_list_v2__expand_link js-renewal-review-message-link js-renewal-link-expand disabled">
                  <div class="review_list_v2__message js-collapsed-review-content js-translate-text" style="max-height: 54px">
				  <text>${reviewVO.rew_content }</text> 
                  </div>
                </div>
              </div>
            </div>


          </div>
        </div>
      
        <div class="review_list_v2__image_section">
          <div class="review_media_v2">
  <ul class="review_media_v2__media">
      <li class="review_media_v2__medium">
  <c:if test="${reviewVO.rew_img ne null}">      
          <div class="img_boxing">        
  
  	<img class="rew_img_src review_media_v2__medium_image js-review-media smooth" name="reviewImage" src="/review/displayFile?fileName=s_<c:out value="${reviewVO.rew_img }"></c:out>&uploadPath=<c:out value="${reviewVO.rew_uploadpath }"></c:out>">
  	</div>
  </c:if>
          

      </li>
  </ul>
</div>
        </div>
    </div>
  </div>
</div>
  <div class="review_list_v2__review_rcontent">
      <div class="review_list_v2__user_name_message">      
        <b> ${fn:substring(reviewVO.user_id, 0, 2)  }*** </b>님의 리뷰입니다.
      </div>
  </div>

  <div class="review_list_v2__review_separator"></div>
</li>
</c:forEach>
    </ul>
    </div>
  <div class="reviews_index__footer">
  		<div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
			<ul class="pagination">
			<c:if test="${pageMaker.prev }">
				<li class='paginate_button previous ${pageMaker.prev ? "": "disabled" }'
					id="example2_previous"><a href="${pageMaker.startPage - 1}"
					aria-controls="example2" data-dt-idx="0" tabindex="0"><</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">	
				<li class='paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }'><a href="${num}"
					aria-controls="example2" data-dt-idx="1" tabindex="0">${num}</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next }">	
				<li class="paginate_button next" id="example2_next"><a
					href="${pageMaker.endPage + 1}" aria-controls="example2" data-dt-idx="7"
					tabindex="0">></a></li>
			</c:if>
			</ul>
		</div>
	</div>
	
	
				<!--prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
		<form id="actionForm" action="/review/allReview" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">	
		</form>
			
  <%@include file="/WEB-INF/views/user/include/footer.jsp" %>
<script>

$(function() {
	updateScoreText();
	let actionForm = $("#actionForm");

	//별점별 조회 드롭다운
	  // 드롭다운 메뉴를 숨김
	  $(".dropdown-menu").hide();

	  // 별점 버튼 클릭시 드롭다운 메뉴를 보여주거나 숨김
	  $(".dropdown-toggle").click(function() {
	    let targetDropdown = $(this).next(".dropdown-menu");
	    // 다른 드롭다운이 열려있으면 닫음
	    $(".dropdown-menu").not(targetDropdown).hide();

	    targetDropdown.toggle();
	  });

	  // 초기화 버튼 클릭시 모든 체크박스 해제
	  $(".reset-btn").click(function() {
	    $(".dropdown-item input").prop("checked", false);
	    $('#ScoreTxt').text('별점');
	  });
	  <%--
	  // 체크박스를 체크 또는 체크 해제
	  $(".dropdown-item label, .dropdown-item span").click(function() {
	    let checkbox = $(this).prev();
	    checkbox.prop("checked", !checkbox.prop("checked"));
	  });
	  
	  $('div.dropdown-item').click(function() {
		    $(this).find('input[type="checkbox"]').prop('checked', true);
		  });
	  --%>
	// 체크박스 클릭
	
		$(".dropdown-item span").on("click", function() {
			let check_box = $(this).parent().find("input");
			
				if (check_box.is(":checked")) { // 체크박스 체크된 상태라면  false
					check_box.prop("checked", false);
				}else {
					check_box.prop("checked", true);
				}

		});
	  
	  
	  // 체크된 데이터에 대한 스코어 텍스트 업데이트
	function updateScoreText() {
	  let scoreStr = $('#rew_scores').val(); 
	  let scores = scoreStr.split(','); // 쉼표로 구분된 문자열을 배열로 변환
       console.log("scoreStr" + scoreStr);

	  // 스코어 텍스트 업데이트
	  if (scores.length > 0) {
	    let scoreText = '별점: ' + scores.map(function(score) {
	      let label = $("input[data-score='" + score + "']").siblings('label').text();
		    console.log("label" + label);

	      return label;
	    
	    }).join(', ');
	    console.log("scoreStrscoreText" + scoreText);
	    $('#ScoreTxt').text(scoreText);
	  } else {
	    $('#ScoreTxt').text('별점');
	  }
	}
	  
	  // 별점별 조회 완료 버튼 클릭시  수정 04/09*
	$(".complete-btn").click(function() {
	    $(".dropdown-menu").hide();
	    let rew_scores = [];
	    $('.dropdown-menu input[type=checkbox]:checked').each(function() {
	        rew_scores.push($(this).data('score'));
	    });
	   
	    $("#rew_scores").val(rew_scores.join(','));
	    actionForm.find("input[name='pageNum']").val(1);
	    // 검색어, 정렬 정보, 페이지 번호 등을 전달하는 search_submit 함수를 이곳에서 호출
	    search_submit();
	});
	  
	  
	//별점별 조회 체크 데이터 유지
	  // hidden input 태그로부터 scoreStr 값을 가져옴
	  let scoreStr = $("#rew_scores").val();
	  
	  // scoreStr을 쉼표(,)로 구분하여 배열로 변환
	  let scoreArr = scoreStr.split(",");
	  
	  // 각 체크박스에 대해 scoreArr에 있는 값을 가지고 있는지 검사하여 체크 상태로 만듦
	  $(".dropdown-menu input[type=checkbox]").each(function() {
	    let score = $(this).data("score").toString(); // data-score 속성 값 가져오기
	    if (scoreArr.includes(score)) { // scoreArr에 score 값이 있는 경우 체크
	          console.log("score: " + score);
	      $(this).prop("checked", true);
	    }
	  });
	  
	
	  // 검색 관련 수정 04/09*
	  //카테고리 변경시
    $("#category").on("change", function(){
    	actionForm.find("input[name='pageNum']").val(1);
		  search_submit();
        });


	//검색시
	$("#rew_search").keypress(function(e) {
		if (e.keyCode === 13) { // keyCode 13은 Enter를 의미
			  e.preventDefault(); 
			actionForm.find("input[name='pageNum']").val(1);
	  	    search_submit();
		}
	});

	//검색 값이 있으면 x버튼 보이기
	  if ($('#rew_search').val() != '') {
		    $('.input-group-append').show();
		  } else {
		    $('.input-group-append').hide();
		  }
	  
	  // x버튼 클릭시 검색 초기화 
	  $('.input-group-append').on('click', function() {
		    $('#rew_search').val('');
		    search_submit();
		  });

	// 최신순 별점순 클릭시 
	  $(".orderby").on("click", "a", function(e) {
	    e.preventDefault(); // 기본 이벤트 방지
	    $("#orderby").val($(this).data("orderby"));
	    actionForm.find("input[name='pageNum']").val(1);
	    search_submit();
	  });
	  
	  
		//페이지번호 클릭시 : 선택한 페이지번호, 페이징정보, 검색정보
		$(".pagination").on("click",".paginate_button a", function(e) {
		  e.preventDefault();
		  actionForm.find("input[name='pageNum']").val($(this).attr("href"));		  			
		    // actionForm 제출
		    search_submit();
		});
		  
	  
		//검색 정보 및 정렬, 페이징 정보 넘기기  	    
	    function search_submit() {
	    	
		    // 상품카테고리 가져오기
	    	let cate_prtcode = $("#category option:selected").val();

		    // 검색어 가져오기
		    let keyword = $("#rew_search").val();

		    let scores = $("#rew_scores").val(); 
		    
		    let orderby = $("#orderby").val();
		    
		    let pageNum = $('#actionForm input[name="pageNum"]').val();
		    			
		    // 빈 값이 아닌 경우에만 input 태그를 동적으로 생성하여 searchList에 추가
		    if(cate_prtcode !== "" && cate_prtcode !== null && cate_prtcode !== 0) {
		    	actionForm.append("<input type='hidden' name='cate_prtcode' value='" + cate_prtcode + "'>");
		    }
		    if(keyword !== "" && keyword !== null) {
		    	actionForm.append("<input type='hidden' name='keyword' value='" + keyword + "'>");
		    }
		    if(scores !== "" && scores !== null) {
		    	actionForm.append("<input type='hidden' name='scores' value='" + scores + "'>");
		    }
		    if(orderby !== "" && orderby !== null) {
		    	actionForm.append("<input type='hidden' name='orderby' value='" + orderby + "'>");
		    }
		    if(orderby == "" && orderby == null) {
		    	actionForm.append("<input type='hidden' name='orderby' value='basic'>");
			}
		   
		    // actionForm 제출
		    actionForm.submit();

	    	}
		
			// 리뷰사진 클릭시
			let img_src = $(".src_section").find(".rew_img_src");
			
			$(img_src).on("click", function(e){
				console.log("클릭");
				let pro_num = $(this).parents(".src_section").find("input[name='pro_num']").val();
				let rew_num = $(this).parents(".src_section").find("input[name='rew_num']").val();
				
				location.href= "/review/productReviewImg?pro_num=" + pro_num + "&rew_num=" + rew_num;
			});
		

	  
	});    
</script>

  </body>
</html>

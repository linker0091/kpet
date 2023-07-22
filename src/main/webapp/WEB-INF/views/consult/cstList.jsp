<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/consult.css">
</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>

	<div class="container">

		<div class="consult_wrap">
			<div class="page_title">
				<h2>1:1 맞춤상담</h2>
			</div>

			<div class="consult_box">
				<!-- 상담 페이지 -->
				<div class="consult_list">
					<ul class="clearfix">
						<li>번호</li>
						<li>카테고리</li>
						<li>제목</li>
						<li>작성자</li>
						<li>작성일</li>
						<li>답변</li>
					</ul>
					<c:if test="${empty conSultList}">
						<p>작성된 글이 없습니다.</p>
					</c:if>
					<c:if test="${not empty conSultList}">
						<c:forEach items="${conSultList}" var="conSultVO"
							varStatus="status">
							<a href="${conSultVO.cst_num }" class="sonsult">
								<ul>
									<li><c:out value="${conSultVO.rn}"></c:out></li>
									<li><c:out value="${conSultVO.cst_type }"></c:out></li>
									<li><c:out value="${conSultVO.cst_title }"></c:out></li>
									<li><c:out value="${conSultVO.user_id }"></c:out></li>
									<li><fmt:formatDate value="${conSultVO.cst_regdate }"
											pattern="yyyy-MM-dd" /></li>
									<li><c:out value="${conSultVO.cst_answer }"></c:out></li>
								</ul>
							</a>
						</c:forEach>
					</c:if>
				</div>
				<button type="button" id="write">글쓰기</button>
			</div>
		</div>

		<div class="dataTables_paginate paging_simple_numbers"
			id="example2_paginate">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li
						class='paginate_button previous ${pageMaker.prev ? "": "disabled" }'
						id="example2_previous"><a href="${pageMaker.startPage - 1}"
						aria-controls="example2" data-dt-idx="0" tabindex="0">Previous</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }" var="num">
					<li
						class='paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }'><a
						href="${num}" aria-controls="example2" data-dt-idx="1"
						tabindex="0"></a></li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button next" id="example2_next"><a
						href="${pageMaker.endPage + 1}" aria-controls="example2"
						data-dt-idx="7" tabindex="0">Next</a></li>
				</c:if>
			</ul>
		</div>

		<!--prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
		<form id="actionForm" action="/consult /cstList" method="get">
			<!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<!--글번호추가-->
		</form>

	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>
	<script>
    $("#write").on("click", function(){
      location.href = "/consult/cstWrite";		
    });
    
    // 글 클릭시
    $(".sonsult").on("click", function(e){
      e.preventDefault();
      let actionForm = $("#actionForm");
      let num = $(this).attr('href');
      
      actionForm.append("<input name='cst_num' value='" + num + "'>");
      actionForm.attr("action", "/consult/cstRead");
      actionForm.submit();
    });
    
    // 페이지 번호 클릭시 동작. previous, page number, next 에 해당하는 <a>태그 선택
    $(".paginate_button a").on("click", function(e){
      e.preventDefault();
      console.log("click");
      let actionForm = $("#actionForm");		
      actionForm.find("input[name='pageNum']").val($(this).attr("href"));

      actionForm.submit();
    });
    
  </script>

</body>
</html>
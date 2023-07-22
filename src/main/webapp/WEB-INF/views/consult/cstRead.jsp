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

		<div class="consult_wrap consult_inner">
			<div class="page_title">
				<h2>1:1 맞춤상담</h2>
			</div>

			<div class="consult_box">
				<!-- 상담 페이지 -->
				<div class="consult_list clearfix">
					<ul class="clearfix">
						<li>제목</li>
						<li>${cstInner.cst_title}</li>
						<li>카테고리</li>
						<li>${cstInner.cst_type}</li>
					</ul>
					<ul class="clearfix">
						<li>작성자</li>
						<li>${cstInner.user_id}</li>
						<li>답변여부</li>
						<li>${cstInner.cst_answer}</li>
					</ul>
					<ul class="clearfix">
						<li>문의일시</li>
						<li><fmt:formatDate value="${cstInner.cst_regdate}"
								pattern="yyyy-MM-dd" /></li>
					</ul>
					<ul class="clearfix">
						<li>내용</li>
						<li id="cont_txt">${cstInner.cst_content}</li>
					</ul>
					<ul class="clearfix">
						<li>첨부</li>
						<li id="cont_txt"><c:if test="${cstInner.cst_img != null}">
								<img name="proudctImage" id="previewImage"
									src="/consult/displayFile?fileName=<c:out value="${cstInner.cst_img }"></c:out>&uploadPath=<c:out value="${cstInner.cst_uploadpath }"></c:out>">
							</c:if> <c:if test="${cstInner.cst_img == null}">
								<li id="cont_txt" style="opacity: 0.5;">첨부된 이미지가 없습니다.</li>
							</c:if></li>
					</ul>
				</div>

				<!--  답변내용-->
				<c:if test="${cstInner.cst_answer eq 'N'}">
					<p>아직 답변이 안되었습니다.</p>
				</c:if>
				<c:if test="${cstInner.cst_answer eq 'Y'}">
					<div class="consult_list">
						<ul class="clearfix">
							<li>제목</li>
							<li><c:out value="${cstWrite.ans_title }"></c:out></li>
						</ul>
						<ul class="clearfix">
							<li>답변자</li>
							<li><c:out value="${cstWrite.ad_id }"></c:out></li>
						</ul>
						<ul class="clearfix">
							<li>답변일시</li>
							<li><fmt:formatDate value="${cstWrite.ans_regdate }"
									pattern="yyyy-MM-dd" /></li>
						</ul>
						<ul class="clearfix">
							<li>내용</li>
							<li id="cont_txt"><c:out value="${cstWrite.ans_content }"></c:out></li>
						</ul>
					</div>
				</c:if>
				<button type="button" class="btnstyle cst_listbtn">목록</button>
				<span class="right_btn cancle">
					<button type="button" class="btnstyle cst_btn cst_modify_btn"
						data-cst_modify="${cstInner.cst_num }">수정</button>
					<button type="button" class="btnstyle cst_remove_btn"
						data-cst_num="${cstInner.cst_num }">삭제</button>
				</span>
			</div>
		</div>
		<form id="actionForm" action="/consult/cstList" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}"> <input
				type="hidden" name="amount" value="${cri.amount}">
		</form>
	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>
	<script>
    //글작성
    $("#write").on("click", function(){
      location.href = "/consult/cstWrite";		
    });
    
    // 리스트버튼 클릭시.
    $(".cst_listbtn").on("click", function(e){
      e.preventDefault();
      let actionForm = $("#actionForm");
      actionForm.submit();
    });
    
    //수정버튼
    $(".cst_modify_btn").on("click", function(){
      let actionForm = $("#actionForm");
      let num = $(this).data("cst_modify");
      
      actionForm.append("<input name='cst_num' value='" + num + "'>");
      actionForm.attr("action", "/consult/cstModify");
      actionForm.submit();
    });

    //삭제버튼
    $(".cst_remove_btn").on("click", function(){
      let cst_num = $(this).data("cst_num");
      if (confirm("게시글을 삭제하시겠습니까?")) {
            // 확인 버튼을 눌렀을 경우
            location.href = "/consult/cstRemove?cst_num=" + cst_num;
        }
      });

  </script>

</body>
</html>
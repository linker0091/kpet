<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>- KPET</title>

    <!-- Bootstrap core CSS -->
    
    <!-- <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css"> -->
    <!-- <link rel="stylesheet" href="https://getbootstrap.com/docs/4.6/dist/css/bootstrap.min.css"> -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/slick.css">
    <link rel="stylesheet" href="/resources/css/reset.css">
    
    <style>
		.list_select {    
			height: 32px;
		    margin-left: 16px;
		    line-height: 20px;
		    padding: 2px 4px;
		    border: 1px solid #e5e5e5;
		    color: #353535;
		    font-size: 14px;
		    border-radius: 4px;
		    cursor: pointer; }

		#searchForm input {  
			height: 32px;
		    margin-left: 16px;
		    line-height: 20px;
		    padding: 2px 4px;
		    border: 1px solid #e5e5e5;
		    color: #353535;
		    font-size: 14px;
		    border-radius: 4px;
     	}
     	
     	#searchForm button { background-color: #333; margin: 0 20px; }
     	
     	#btnWrite { background-color: #333; float: right; margin-right: 17px;  }
     	
     	.commu_txt { cursor: pointer; }
     	
		.list_select {
		 	-webkit-appearance: none;
		    -moz-appearance: none;
		    appearance: none;
		    background-image: url(/img/select.png);
		    background-repeat: no-repeat;
		    background-size: 11px 6px;
		    background-position: center right 8px;
		    padding-right: 30px;
		    border: 1px solid #e5e5e5;
		    border-radius: 4px;
		    background-color: #fff;
		    min-width: 86px;
		    padding: 0 25px 0 8px;
		}
     	
    </style>
  
  </head>

  <body>
    
<%@include file="/WEB-INF/views/user/include/header.jsp" %>

<div class="container">
		<div class="page_title">
			<h2>펫후 커뮤니티</h2>
		</div>
						<div class="box-body">
															<div class="form-group row">
															    <div class="col-md-6">
										<div class="dataTables_info">
											<form id="searchForm" action="/board/list" method="get">
												<select name="type" class="list_select">
													<option value=""
														<c:out value="${pageMaker.cri.type == null? 'selected':'' }" />>--</option>
													<option value="T"
														<c:out value="${pageMaker.cri.type eq 'T'? 'selected':'' }" />>제목</option>
													<option value="C"
														<c:out value="${pageMaker.cri.type eq 'C'? 'selected':'' }" />>내용</option>
													<option value="W"
														<c:out value="${pageMaker.cri.type eq 'W'? 'selected':'' }" />>작성자</option>
													<option value="TC"
														<c:out value="${pageMaker.cri.type eq 'TC'? 'selected':'' }" />>제목 or 내용</option>
													<option value="TW"
														<c:out value="${pageMaker.cri.type eq 'TW'? 'selected':'' }" />>제목 or 작성자</option>
													<option value="TWC"
														<c:out value="${pageMaker.cri.type eq 'TWC'? 'selected':'' }" />>제목 or 작성자 or 내용</option>
												</select>
												<input type="text" name="keyword" value="<c:out value="${ pageMaker.cri.keyword}" />">
												<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
												<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
												<button class="btn btn-primary">Search</button>
											</form>
										</div>
										</div>
    <div class="col-md-6 clearfix">
<button type="button" id="btnWrite" class="btn btn-primary">
  <a href="/board/register" style="color: white;">글쓰기</a>
</button>
    </div>
										</div>
										
								<div id="example2_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap">
										<div class="col-sm-12">
											<table id="example2"
												class="table table-bordered table-hover dataTable"
												role="grid" aria-describedby="example2_info">
												<thead>
													<tr role="row">
														<th class="sorting_asc" tabindex="0"
															aria-controls="example2" rowspan="1" colspan="1"
															aria-sort="ascending"
															aria-label="Rendering engine: activate to sort column descending">번호</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Browser: activate to sort column ascending">제목</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Platform(s): activate to sort column ascending">작성자</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="Engine version: activate to sort column ascending">작성일</th>
														<th class="sorting" tabindex="0" aria-controls="example2"
															rowspan="1" colspan="1"
															aria-label="CSS grade: activate to sort column ascending">수정일</th>
													</tr>
												</thead>
												<tbody>

													<c:forEach items="${list }" var="board" varStatus="status">
														<tr id="<c:out value="${board.bno }"></c:out>" class="<c:if test="${status.count % 2 == 0 }">odd</c:if><c:if test="${status.count % 2 != 0 }">even</c:if> commu_txt">
															<td class="sorting_1"><c:out value="${board.bno }"></c:out></td>
															<td><a class="move" href="<c:out value="${board.bno }"></c:out>"><c:out	value="${board.title }"></c:out>
																<b>[<c:out	value="${board.replycnt }"></c:out>]</b>
																</a>
															</td>
															<td><c:out value="${board.user_id }"></c:out></td>
															<td><fmt:formatDate value="${board.regdate }"
																	pattern="yyyy-MM-dd" /></td>
															<td><fmt:formatDate value="${board.updatedDate }"
																	pattern="yyyy-MM-dd" /></td>
														</tr>
													</c:forEach>
												</tbody>

											</table>
										</div>
									</div>

											<div class="dataTables_paginate paging_simple_numbers"
												id="example2_paginate">
												<ul class="pagination">
												<c:if test="${pageMaker.prev }">
													<li class='paginate_button previous ${pageMaker.prev ? "": "disabled" }'
														id="example2_previous"><a href="${pageMaker.startPage - 1}"
														aria-controls="example2" data-dt-idx="0" tabindex="0">Previous</a></li>
												</c:if>
												<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">	
													<li class='paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }'><a href="${num}"
														aria-controls="example2" data-dt-idx="1" tabindex="0">${num}</a></li>
												</c:forEach>
												<c:if test="${pageMaker.next }">	
													<li class="paginate_button next" id="example2_next"><a
														href="${pageMaker.endPage + 1}" aria-controls="example2" data-dt-idx="7"
														tabindex="0">Next</a></li>
												</c:if>
												</ul>
											</div>
										</div>
										<!--prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
										<form id="actionForm" action="/board/list" method="get">
											<!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
											<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
											<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
											<input type="hidden" name="type" value="${pageMaker.cri.type}">
											<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
											<!--글번호추가-->
										</form>


									</div>
								

      <%@include file="/WEB-INF/views/user/include/footer.jsp" %>
	<script>
		$(document).ready(function() {

			let actionForm = $("#actionForm");
			
			// 리스트에서 제목 클릭시 동작
			$(".commu_txt").on("click", function(e) {

				e.preventDefault(); // <a>태그의 기본적인 이벤트기능을 취소. 즉 링크기능취소.  

				let bno = $(this).attr("id");
				console.log("글번호" + bno);

				//location.href = "/board/get?bno=" + bno; // /board/get?bno=1

				actionForm.append("<input type='hidden' name='bno' value='" + bno + "'>");
				actionForm.attr("action", "/board/get");

				actionForm.submit();


			});


			
			// 페이지 번호 클릭시 동작. previous, page number, next 에 해당하는 <a>태그 선택
			$(".paginate_button a").on("click", function(e){
				e.preventDefault();

				actionForm.find("input[name='pageNum']").val($(this).attr("href"));

				console.log("click");

				actionForm.submit();
			});
		});
	</script>	
	
  </body>
</html>

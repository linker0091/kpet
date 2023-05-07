<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/search.css">
</head>
<body>

<%@include file="/WEB-INF/views/user/include/header.jsp" %>

<div class="container">	
	<div class="page_title">
		<h2>상품 검색</h2>
	</div>
	<div class="ec-base-box searchbox">
	        <fieldset>
		        
				            
	            <div class="item clarfix">
	                <strong>검색조건</strong>
	                <select id="search_type" name="search_type">
					<option value="product_name">상품명</option>
					<option value="product_code">상품코드</option>
					<option value="prd_model">모델명</option>
					<option value="prd_brand">브랜드명</option>
					<option value="prd_trand">트랜드명</option>
					</select>                
					<input id="keyword" name="keyword" class="inputTypeText" placeholder="" size="15" type="text">            
					</div>
				            
				            
				<div class="item clarfix">
				<strong>판매가격대</strong> 
				<input id="product_price1" name="product_price1" class="input01" placeholder="" size="15" value="" type="text">
				 ~ <input id="product_price2" name="product_price2" class="input01" placeholder="" size="15" value="" type="text">
				</div>
	            
	            <button type="button" class="btnSubmitFix sizeM">검색</button>
	            
	        </fieldset>
	</div>
</div>
<%@include file="/WEB-INF/views/user/include/footer.jsp" %>


</body>
</html>
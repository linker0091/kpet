<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.88.1">
<title>Pricing example · Bootstrap v4.6</title>

<link rel="canonical"
	href="https://getbootstrap.com/docs/4.6/examples/pricing/">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
	.row .container {
		padding: 50px 0 72px;
	}
	.titleArea {
		min-height: 30px;
		border-bottom: 0;
		text-align: left;
		width: 1200px;
		padding: 8px 0 24px;
		margin: 10px 0 20px;
	}
	.row .container h3 {
		width: 80%;
	}
	.mypage-wrap {
		display: inline-block;
		width: 984px;
		float: right;
	}
	.info-box {
		width: 100%;
		background: #f5f5f5;
		padding: 35px 40px;
		border-radius: 20px;
		margin: 24px 0;
	}
	.info-box li {
		position: relative;
		text-align: center;
		width: 40%;
		padding: 18px 0;
		display: inline-block;
		font-size: x-large;
	}
	.user_info {
		font-size: 25px;
	}
	.span_title {
		font-size: 14px;
		line-height: 20px;
		text-align: center;
		display: block;
	}
	.span_txt {
		font-size: 25px;
		line-height: 37px;
		font-weight: bold;
		display: block;
	}
	.orderstate {
		box-sizing: border-box;
		margin: 0;
		padding: 24px 16px 0;
		border: 0;
		background-color: #f8f9fb;
		border-radius: 5px 5px 0 0;
	}
	.state {
		overflow: hidden;
		padding: 19px 0;
	}
	.title {
		font-size: 20px;
		color: #757575;
	}
	.order {
		width: 752px;
		height: 120px;
		float: left;
	}
	.state ul {
		background-color: #fff;
		border-radius: 5px;
	}
	.order li {
		float: left;
		width: 20%;
		padding: 0 0 4px;
		margin: 24px -1px 24px 0;
		border-right: 1px dotted #c9c7ca;
		text-align: center;
	}
	.order strong {
		font-size: 20px;
		color: #757575;
		display: block;
		margin: 2px 0 15px;
	}
	.order li span {
		font-size: 25px;
		color: #3e3e3e;
		font-weight: bold;
		display: block;
	}
	.orderstate .cs {
		box-sizing: border-box;
		float: right;
		padding: 16px 0;
		width: 183px;
		height: 120px;
		text-align: center;
	}
	.cs strong {
		font-size: 17px;
		color: #757575;
		line-height: 1.5;
	}
	.cs span {
		font-size: 15px;
		color: #757575;
		font-weight: bold;
	}
	.state_left {
		float: left;
	}
	.state_right {
		float: right;
	}
	.head-mypage {
		background: #F7F7F7;
	}
	.frame-left {
		float: left;
		width: 215px;
		padding: 0px 17px;
		margin: 24px 0;
	}
	.frame-left li {
		line-height: 32px;
		font-size: 16px;
		color: #757575;
	}
	.left-header {
		margin-bottom: 25px;
		font-size: 25px;
		line-height: 37px;
		color: #313133;
		font-weight: bold;
	}
}
</style>

<!-- Custom styles for this template -->
<link href="pricing.css" rel="stylesheet">
</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>

	<div class="row">
		<div class="container">
			<div class="titleArea">
				<strong class="left-header">마이페이지</strong>
			</div>
			<div class="frame-left">
				<ul>
					<li><span><a href="/order/orderComplete">주문조회</a></span></li>
					<li><span><a href="/user/modify">회원정보</a></span></li>
					<li><span><a href="/consult/cstList">1:1 맞춤 상담</a></span></li>
				</ul>
			</div>
			<div class="mypage-wrap">
				<div class="info-box user_info">
					<strong style="color: #07c6e8;">${user_name} 회원님</strong> <span>반갑습니다!</span>
				</div>
				<div class="orderstate">
					<div class="title">
						<strong>나의 주문 현황</strong> <span>(최근 3개월 기준)</span>
					</div>
					<div class="state">
						<ul class="order">
							<li><strong>입금전</strong> <span>${ordReceived}</span></li>
							<li><strong>결제완료</strong> <span>${ordPaid}</span></li>
							<li><strong>배송준비중</strong> <span>${ordPreparing}</span></li>
							<li><strong>배송중</strong> <span>${ordShipping}</span></li>
							<li><strong>배송완료</strong> <span>${ordDelivered}</span></li>
						</ul>
						<ul class="cs">
							<li><strong>취소 </strong> <span>${ordCancel}</span></li>
							<li><strong>교환 </strong> <span>${ordExchange}</span></li>
							<li><strong>반품 </strong> <span>${ordReturn}</span></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>
	<script>
		$(document).ready(
				function() {

					//비밀번호 변경
					$("#btnChangePw").on(
							"click",
							function() {

								let cur_user_pw = $("#cur_user_pw");
								let change_user_pw = $("#change_user_pw");

								if (cur_user_pw.val() == ""
										|| cur_user_pw.val() == null) {
									alert("현재비밀번호를 입력하세요.");
									cur_user_pw.focus();
									return;
								}

								if (change_user_pw.val() == ""
										|| change_user_pw.val() == null) {
									alert("변경비밀번호를 입력하세요.");
									change_user_pw.focus();
									return;
								}

								$.ajax({
									url : '/user/changePw',
									type : 'post',
									dataType : 'text',
									data : {
										cur_user_pw : cur_user_pw.val(),
										change_user_pw : change_user_pw.val()
									},
									success : function(data) {

										if (data == "success") {
											alert("비밀번호 변경이 되었습니다.");
										} else if (data == "noPw") {
											alert("현재 비밀번호가 다릅니다. 확인하세요.");
											cur_user_pw.val("");
											cur_user_pw.focus();
										}
									}
								});
							});

					//회원탈퇴
					$("#btnRegDelete").on("click", function() {

						let user_pw = $("#user_pw");

						if (user_pw.val() == "" || user_pw.val() == null) {
							alert("현재비밀번호를 입력하세요.");
							user_pw.focus();
							return;
						}

						$.ajax({
							url : '/user/regDelete',
							type : 'post',
							dataType : 'text',
							data : {
								user_pw : user_pw.val()
							},
							success : function(data) {

								if (data == "1") {
									alert("회원삭제가 되었습니다.");
									location.href = "/";
								} else if (data == "0") {
									alert("현재 비밀번호가 다릅니다. 확인하세요.");
									user_pw.val("");
									user_pw.focus();
								}
							}
						});
					});

				});
	</script>

</body>
</html>

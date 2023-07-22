<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
}

.row .container {
	padding: 128px 0 72px;
}

.row .container h3 {
	width: 80%;
	font-size: 30px;
	margin-bottom: 30px;
	margin: 0 auto 52px;
}

.searchPw_form {
	width: 80%;
	margin: 0 auto;
}
</style>


<!-- Custom styles for this template -->
<link href="pricing.css" rel="stylesheet">
</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>

	<div class="row">
		<div class="container">
			<h3>아이디/비밀번호 찾기 폼</h3>
			<form class=searchPw_form>
				<div class="form-group row">
					<label for="user_email" class="col-sm-10 col-form-label">전자우편
						주소입력</label>
					<div class="col-sm-12">
						<input type="text" class="form-control" id="user_email"
							name="user_email" placeholder="abc@docmall.com">
					</div>
				</div>

				<div class="form-group row">
					<div class="col-sm-12">
						<button type="button" id="btnSearchId" class="btn btn-primary">아이디
							찾기</button>
						<button type="button" id="btnSearchPw" class="btn btn-primary">비밀번호
							찾기</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>

	<script>

    $(document).ready(function(){
    	
        //아이디 찾기 메일발송
        $("#btnSearchId").on("click", function(){

          let user_email = $("#user_email");

          if(user_email.val() == "" || user_email.val() == null){
            alert("가입하신 메일주소를 입력하세요.");
            user_email.focus();
            return;
          }

          $.ajax({
            url: '/user/searchId',
            type: 'post',
            dataType: 'text',
            data: { user_email : user_email.val() },
            success: function(data){

            	if(data == "success"){
                alert("메일 주소로 아이디 정보가 발송 되었습니다.");
                location.href = "/user/login"; 
              }else if(data == "fail"){
                alert("메일발송시 문제가 발생했습니다. 다시 진행해주세요.\n 문제가 발생시 관리자에게 연락주세요.");
              }else if(data == "noMail"){
                alert("가입하신 메일주소가 다릅니다. 확인하여 주세요.");
              }
            } 
          });
        });
      
      //비밀번호 찾기 메일발송
      $("#btnSearchPw").on("click", function(){

        let user_email = $("#user_email");

        if(user_email.val() == "" || user_email.val() == null){
          alert("가입하신 메일주소를 입력하세요.");
          user_email.focus();
          return;
        }

        $.ajax({
          url: '/user/searchPw',
          type: 'post',
          dataType: 'text',
          data: { user_email : user_email.val() },
          success: function(data){
            
            if(data == "success"){
              alert("메일 주소로 임시비밀번호가 발송 되었습니다.\n로그인 후 비밀 번호 변경 바랍니다.");
              location.href = "/user/login"; 
            }else if(data == "fail"){
              alert("메일발송시 문제가 발생했습니다. 다시 진행해주세요.\n문제가 발생시 관리자에게 연락주세요.");
            }else if(data == "noMail"){
              alert("가입하신 메일주소가 다릅니다. 확인하여 주세요.");
            }
          } 
        });
      });
      
    });

  </script>
</body>
</html>

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

.login_form {
	width: 80%;
	margin: 0 auto;
}
</style>

</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>

	<div class="row">
		<div class="container">
			<h3>로그인 폼</h3>
			<form class="login_form" method="post" action="/user/login">
				<div class="form-group row">
					<label for="user_id" class="col-sm-2 col-form-label">ID</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="user_id"
							name="user_id" placeholder="ID">
					</div>
				</div>
				<div class="form-group row">
					<label for="user_pw" class="col-sm-2 col-form-label">Password</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="user_pw"
							name="user_pw" placeholder="Password">
					</div>
				</div>

				<div class="form-group row">
					<div class="offset-sm-2 col-sm-10">
						<button type="button" id="btnLogin" class="btn btn-primary">로그인</button>
						<button type="button" class="btn btn-link btn-sm" id="btnJoin">회원가입</button>
						<button type="button" class="btn btn-link btn-sm" id="btnSearchIdPw">아이디/비밀번호
							찾기</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>

	<script>

    $(document).ready(function(){
      
      //로그인2
      let result = '${result}';
      let user_id = $("#user_id");
      let user_pw = $("#user_pw");
      
      user_id.focus();
      
      $("#btnLogin").on("click", function(){
		let login_form = $(".login_form");
		
        if(user_id.val() == "" || user_id.val() == null){
          alert("아이디를 입력하세요.");
          user_id.focus();
          return;
        }

        if(user_pw.val() == "" || user_pw.val() == null){
          alert("비밀번호를 입력하세요.");
          user_pw.focus();
          return;
        }
        
        login_form.submit();
    
      });
      
      // user_id에서 엔터키를 누르면 user_pw 포커스 이동
      user_id.on("keydown", function(event) {
         if (event.keyCode === 13) { // 엔터키 코드는 13입니다.
           event.preventDefault();
           user_pw.focus();
         }
       });
      
      // user_pw에서 엔터키를 누르면 form이 자동으로 제출
     user_pw.on("keydown", function(event) {
       if (event.keyCode === 13) { // 엔터키 코드는 13입니다.
         event.preventDefault();
         $("form").submit();
       }
     });

      
      let userTxt = '${usertxt}';
    if(result == "idFail"){
    	user_id.val(userTxt);
        alert("아이디를 확인해주세요.");
        user_id.focus();
      }
	 if(result == "pwFail"){
		user_id.val(userTxt);
        alert("비밀번호를 확인해주세요.");
        user_pw.val("");
        user_pw.focus();
      };
    
  	  // 회원가입 폼
      $("#btnJoin").on("click", function(){
    	 location.href = "/user/join"; 
      });
      
  	  // 비밀번호 찾기폼
      $("#btnSearchIdPw").on("click", function(){
    	 location.href = "/user/searchIdPw"; 
      });
    });
	

  </script>
</body>
</html>

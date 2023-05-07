<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="/resources/css/consult.css">
<body>

<%@include file="/WEB-INF/views/user/include/header.jsp" %>
<script src="/bower_components/ckeditor/ckeditor.js"></script>


<div class="container">

	<div class="consult_wrap clearfix">
		<div class="page_title">
			<h2>1:1 맞춤상담</h2>
		</div>
		<form action="/user/cstModify" method="post" id="write_form" enctype="multipart/form-data">
		<div class="consult_writebox">
			<!-- 상담 글쓰기 페이지 -->
		     <div class="title_box">
		     	<ul class="clearfix">
		     		<li>제목</li>
		     		<li>
		     			<select class="consult_category" name="cst_type" >
							<option value="배송문의">배송문의</option>
							<option value="교환/반품">교환/반품</option>
						</select> 
						<input type="text" name="cst_title" class="inputTypeText" value="${cstInner.cst_title }">
						<input type="hidden" name="user_id" value="${cstInner.user_id }">
						<input type="hidden" name="cst_num" value="${cstInner.cst_num }">
		     		</li>
		     	</ul>
		     </div>
		     <div class="write_inner">
		     	<li>내용</li>
		     	<textarea id="cst_content" class="write_text" name="cst_content" rows="10" cols="80"><c:out value="${cstInner.cst_content }"></c:out></textarea>
		     </div>
		     <div class="title_box">
		     	<ul class="clearfix">
		     		<li>첨부파일</li>
		     		<li>
						<input type="file" name="cst_upload" id="cst_upload" class="file_input" value="${cstInner.cst_upload }">
						<!-- 이미지 변경시 기존이미지정보를 이용하여 기존이미지 삭제, 이미지 변경 안하면, 기존정보를 수정데이타로 사용  추가*-->
					  	<input type="hidden" name="cst_uploadpath" value="<c:out value='${cstInner.cst_uploadpath}' />">
      					<input type="hidden" name="cst_img" value="<c:out value='${cstInner.cst_img}'/>">
						<label for="cst_upload">미리보기</label>
      					<!-- 미리보기 코드 추가* -->
				      <img name="cstImage" id="previewImage" src="/user/displayFile?fileName=s_<c:out value='${cstInner.cst_img}'/>&uploadPath=<c:out value='${cstInner.cst_uploadpath}'/>">
		     		</li>
		     	</ul>
		     </div>
		</div>		
		<button type="button" class="btnstyle cst_listbtn">목록</button>
		<span class="right_btn">
			<button type="button" class="btnstyle cst_btn">등록</button>
			<button type="button" class="btnstyle cst_cancel_btn">취소</button>
		</span>
		</form>
	</div>
	<form id="actionForm" action="/user/consult" method="get">
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount}">
	</form>
</div>

<script>
	
	
	
	$(document).ready(function(){
	      // CKEditor 설정구문
	      let ckeditor_config = {
	         resize_enabled : false,
	         enterMode : CKEDITOR.ENTER_BR,
	         shiftEnterMode : CKEDITOR.ENTER_P,
	         toolbarCanCollapse : true,
	         removePlugins : "elementspath",
	         
	         filebrowserUploadUrl : "editor/imageUpload"  // /editor/imageUpload. 이미지 업로드시 업로드탭 보기
	            
	      };
	      
	      CKEDITOR.replace('cst_content', ckeditor_config);
	      
	      // 4.8.0 (Standard)
	      // alert(CKEDITOR.version);  
	      
	      $(".cst_cancel_btn").on("click", function(){
	  		location.href = "/user/consult";
		  });
		  
		  
	      
	   });
</script>
<script>
	//파일첨부
    function readImage(input) {
      if (input.files && input.files[0]) {
          
        //let imgPath = input.files[0].value;
        let imgPath = $("#cst_upload").val();
        alert(imgPath);
        //return;
        let ext = imgPath.substring(imgPath.lastIndexOf(".")+1).toLowerCase();
        alert(ext);
        if(typeof(FileReader) == "undefined") {
          alert("브라우저가 작업을 지원안합니다.");
          return;
        }

        if(ext == "gif" || ext == "png" || ext == "jpg" || ext == "jpeg" ) {
          
          const reader = new FileReader();
          

          //이벤트 설정. reader객체가 이미지파일을 성공적으로 읽어들였을 때 발생하는 이벤트
          reader.onload = (e) => {
              //alert("onload");
              const previewImage = document.getElementById('previewImage');
              previewImage.src = e.target.result;
          }

          // reader객체가 파일을 읽어들이는 작업
          reader.readAsDataURL(input.files[0]);
        }else{
          $("#cst_upload").val("");
          alert("이미지 파일을 선택하세요.");
        }
      }
    }
    // 이벤트 리스너
    document.getElementById('cst_upload').addEventListener('change', (e) => {
        readImage(e.target);
    })
    
    //글등록
    $(".cst_btn").on("click", function(){
    	let user_id = $("input[name='user_id']").val();
    	console.log(user_id);
    	
    	$("#write_form").submit();
    	
    });

    // 리스트버튼 클릭시.
	$(".cst_listbtn").on("click", function(e){
		e.preventDefault();
		let actionForm = $("#actionForm");
		actionForm.submit();
	});
    
    let procontent_txt = '${cstInner.cst_content }';
	$("body.cke_editable").text('procontent_txt');
</script>


<%@include file="/WEB-INF/views/user/include/footer.jsp" %>

</body>
</html>
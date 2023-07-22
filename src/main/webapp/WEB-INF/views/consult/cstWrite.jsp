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

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>
	<script src="/bower_components/ckeditor/ckeditor.js"></script>

	<div class="container">

		<div class="consult_wrap clearfix">
			<div class="page_title">
				<h2>1:1 맞춤상담</h2>
			</div>
			<form action="/consult/writeInsert" method="post" id="write_form"
				enctype="multipart/form-data">
				<div class="consult_writebox">
					<!-- 상담 글쓰기 페이지 -->
					<div class="title_box">
						<ul class="clearfix">
							<li>제목</li>
							<li><select class="consult_category" name="cst_type">
									<option value="상품문의">상품문의</option>
									<option value="배송문의">배송문의</option>
									<option value="교환/반품">교환/반품</option>
							</select> <input type="text" name="cst_title" class="inputTypeText">
								<input type="hidden" name="user_id" value=${user_id }></li>
						</ul>
					</div>
					<div class="write_inner">
						<li>내용</li>
						<textarea id="cst_content" class="write_text" name="cst_content"
							rows="10" cols="80"></textarea>
					</div>
					<div class="title_box">
						<ul class="clearfix">
							<li>사진첨부</li>
							<li><input type="file" name="cst_upload" id="cst_upload"
								class="file_input"> <label for="cst_upload">미리보기</label>
								<img alt="" src="" id="previewImage"></li>
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
          
          //button click
          $(".cst_cancel_btn").on("click", function(){
          location.href = "/consult/cstList";
        });
        $(".cst_listbtn").on("click", function(){
          location.href = "/consult/cstList";
        });
          
      });
  </script>
	<script>	

    //파일첨부 
      function readImage(input) {
    if (input.files && input.files[0]) {
      let imgPath = input.files[0].name; // 파일을 선택한 경우에만 파일 이름을 가져옴
      alert(imgPath);
      let ext = imgPath.substring(imgPath.lastIndexOf(".")+1).toLowerCase();
      alert(ext);
      if(typeof(FileReader) == "undefined") {
        alert("브라우저가 작업을 지원하지 않습니다.");
        return;
      }

      if(ext == "gif" || ext == "png" || ext == "jpg" || ext == "jpeg" ) {
        const reader = new FileReader();
        reader.onload = (e) => {
          const previewImage = document.getElementById('previewImage');
          previewImage.src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
      }else{
        $("#cst_upload").val("");
        alert("이미지 파일을 선택하세요.");
      }
    }else {
      let imgPath = "";
      alert(imgPath);
    }
  }

      // 이벤트 리스너
      document.getElementById('cst_upload').addEventListener('change', (e) => {
          readImage(e.target);
      })
    
      //글등록 및 수정
      $(".cst_btn").on("click", function(){
        let cst_title = $('input[name="cst_title"]').val();
        let editor = CKEDITOR.instances.cst_content;
        let cst_content = editor.getData();
        
          if(cst_title == "" || cst_title == null){
              alert("제목을 입력하세요.");
              return;
            }

            if(cst_content.trim() === ''){
              alert("내용을 입력하세요.");
              return;
            }
            
        $("#write_form").submit();
      });
      
  </script>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>

</body>
</html>
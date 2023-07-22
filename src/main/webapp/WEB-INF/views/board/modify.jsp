<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>- KPET</title>

<!-- Bootstrap core CSS -->

<!-- <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://getbootstrap.com/docs/4.6/dist/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">

<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>
	<div class="container">
		<div class="page_title">
			<h2>펫후 커뮤니티 글수정</h2>
		</div>

		<form role="form" id="modifyForm" method="post" action="/board/modify">
			<input type="hidden" name="pageNum"
				value='<c:out value="${cri.pageNum }" />'> <input
				type="hidden" name="amount" value='<c:out value="${cri.amount }" />'>
			<input type="hidden" name="type"
				value='<c:out value="${cri.type }" />'> <input type="hidden"
				name="keyword" value='<c:out value="${cri.keyword }" />'>

			<div class="box-body">
				<div class="form-group">
					<label for="bno">글번호</label> <input type="text"
						class="form-control" id="bno" name="bno" value="${board.bno }"
						readonly="readonly">
				</div>
				<div class="form-group">
					<label for="title">제목</label> <input type="text"
						class="form-control" id="title" name="title"
						value="${board.title }">
				</div>
				<div class="form-group">
					<label for="content">내용</label>
					<textarea class="form-control" rows="3" id="content" name="content">${board.content }</textarea>
				</div>
				<div class="form-group">
					<label for="regdate">작성일</label>
					<!-- pattern="yyyy-MM-dd"  날짜포맷이 에러가 발생된다.-->
					<input type="text" class="form-control" id="regdate" name="regdate"
						value="<fmt:formatDate value="${board.regdate }" pattern="yyyy/MM/dd"/>"
						readonly="readonly">
				</div>
				<div class="form-group">
					<label for="updatedDate">수정일</label> <input type="text"
						class="form-control" id="updatedDate" name="updatedDate"
						value="<fmt:formatDate value="${board.updatedDate }" pattern="yyyy/MM/dd"/>"
						readonly="readonly">
				</div>
			</div>

			<!-- /.box-body -->
			<div class="form-group box-footer">
				<button id="btnModify" type="submit" class="btn btn-primary">수정등록</button>
				<button id="btnRemove" type="button" class="btn btn-danger">삭제</button>
				<button id="btnList" type="button" class="btn btn-info">리스트</button>
			</div>
		</form>

		<!-- 파일업로드및 파일목록 출력위치-->
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="form-group box-header with-border">
						<b>첨부파일</b>
					</div>
					<div class="box-body">
						<div class="form-group uploadDiv">
							<input type="file" name="uploadFile" multiple>
						</div>
						<div class="uploadResult row">
							<ul></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>
	<!-- REQUIRED JS SCRIPTS(with jquery) -->
	<script src="/bower_components/ckeditor/ckeditor.js"></script>

	<script>
      // CKEditor 작업구문.
    $(document).ready(function(){
      
      let ckeditor_config = {
        resize_enabled : false,
        enterMode : CKEDITOR.ENTER_BR,
        shiftEnterMode : CKEDITOR.ENTER_P,
        toolbarCanCollapse : true,
        removePlugins : "elementspath",
        
        filebrowserUploadUrl : "/editor/imageUpload"  // /editor/imageUpload. 이미지 업로드시 업로드탭 보기
          
      };
      
      CKEDITOR.replace('content', ckeditor_config);
      
      // 4.8.0 (Standard)
      // alert(CKEDITOR.version);  
      
    });
  </script>

	<script>

    $(document).ready(function(){

      let formObj = $("#modifyForm");

      //목록버튼 클릭시 동작
      $("#btnList").on("click", function(){

        formObj.attr("action", "/board/list");
        formObj.attr("method", "get");

        /* 리스트로 보내는 정보
        <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }" />'>
        <input type="hidden" name="amount" value='<c:out value="${cri.amount }" />'>
        <input type="hidden" name="type" value='<c:out value="${cri.type }" />'>
        <input type="hidden" name="keyword" value='<c:out value="${cri.keyword }" />'>

        */

        let pageNumTag = $("input[name='pageNum']").clone();
        let amountTag = $("input[name='amount']").clone();
        let keywordTag = $("input[name='type']").clone();
        let typeTag = $("input[name='keyword']").clone();

        console.log(pageNumTag);
        console.log(amountTag);
        console.log(keywordTag);
        console.log(typeTag);

        formObj.empty(); // 폼의 모든 내용을 제거.

        formObj.append(pageNumTag);
        formObj.append(amountTag);
        formObj.append(keywordTag);
        formObj.append(typeTag);


        formObj.submit();
      });

      $("#btnRemove").on("click", function(){

        if(confirm("게시물을 삭제하겠습니까?")){
          formObj.attr("action", "/board/remove");
          formObj.submit();
        }
      });

    });

  </script>

	<script>

    $(document).ready(function(){
    
    // get.jsp와 동일하게 첨부된 파일정보를 가져오는 작업  
    let bno = '${ board.bno}'; //현재 게시물 번호
    // 1)처음 페이지 로딩시 호출하는 구문
    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){

    //1) 
    console.log(arr);  // BoardAttachVO클래스(fileType필드)
        
    let uploadUL = $(".uploadResult ul");

      let str = "";

      $(arr).each(function(i, obj) {

        if(obj.fileType){
          //이미지파일출력
          let fileCalPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
          str += "<li data-path='" + obj.uploadPath + "'";
          str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName +"' data-type='" + obj.fileType + "'>";
          str += "<div>";
          str += "<span>" + obj.fileName + "</span>";
          str += "<button type='button' data-file='" + fileCalPath + "' ";
          str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
          str += "<img src='/board/display?fileName=" + fileCalPath + "'>";
          str += "</div>";
          str += "</li>";



        }else{
          //일반파일출력
          let fileCalPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
          let fileLink = fileCalPath.replace(new RegExp(/\\/g), "/");
          
          str += "<li data-path='" + obj.uploadPath + "'";
          str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName +"' data-type='" + obj.fileType + "'>";
          str += "<div>";
          str += "<span>" + obj.fileName + "</span>";
          str += "<button type='button' data-file='" + fileCalPath + "' ";
          str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
          str += "<img src='/resources/img/attach.png'>";
          str += "</div>";
          str += "</li>";
        }
      });

      console.log(str);

      uploadUL.append(str);  
    });  
      
      
    // 업로드 파일을 선택시 change이벤트가 발생
      $("input[type='file']").change(function(e){

        // <input type="file" name="uploadFile" multiple>

        let formData = new FormData(); // <form>태그 수준에 해당하는 객체
        let inputFile = $("input[name='uploadFile']"); // 컬렉션(배열)

        let files = inputFile[0].files;

        for(let i=0; i<files.length; i++){

          if(!checkExtension(files[i].name, files[i].size)){
            return false;
          }

          formData.append("uploadFile", files[i]);
        }

        $.ajax({
          url: "/board/uploadAjaxAction", // 파일업로드 처리주소
          processData: false,
          contentType: false,
          data:formData,
          type:'POST',
          dataType:"json",
          success: function(result){ // result: 업로드된 파일첨부정보가 List컬렉션으로 스프링으로부터 받아옴.
            console.log(result);  // AttachFileDTO클래스(image필드)

              // 첨부된 파일정보를 출력(파일 첨부작업시 호출)
            showUploadResult(result);
          }
        });


      });


      let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
      let maxSize = 5 * 1024 * 1024; // 5mb

      function checkExtension(fileName, fileSize){

        if(fileSize >= maxSize){
          alert("파일 크기초과");
          return false;
        }

        if(regex.test(fileName)){
          alert("해당 종류의 파일은 업로드 할 수 없습니다.");
          return false;
        }

        return true;
      }

      // 첨부된 파일정보를 이용하여, 화면에 파일목록을 출력하는 작업
      function showUploadResult(uploadResultArr){

        if(!uploadResultArr || uploadResultArr.length == 0){return;}

        let uploadUL = $(".uploadResult ul");

        let str = "";

        $(uploadResultArr).each(function(i, obj) {

          if(obj.image){
            //이미지파일출력
            let fileCalPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
            str += "<li data-path='" + obj.uploadPath + "'";
            str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName +"' data-type='" + obj.image + "'>";
            str += "<div>";
            str += "<span>" + obj.fileName + "</span>";
            str += "<button type='button' data-file='" + fileCalPath + "' ";
            str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
            str += "<img src='/board/display?fileName=" + fileCalPath + "'>";
            str += "</div>";
            str += "</li>";



          }else{
            //일반파일출력
            let fileCalPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
            let fileLink = fileCalPath.replace(new RegExp(/\\/g), "/");
            
            str += "<li data-path='" + obj.uploadPath + "'";
            str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName +"' data-type='" + obj.image + "'>";
            str += "<div>";
            str += "<span>" + obj.fileName + "</span>";
            str += "<button type='button' data-file='" + fileCalPath + "' ";
            str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
            str += "<img src='/resources/img/attach.png'>";
            str += "</div>";
            str += "</li>";
          }
        });

        console.log(str);

        uploadUL.append(str);

      }



      // <form role="form"
      let formObj = $("form[role='form']");

      // 수정버튼 클릭시 동작
      $("#btnModify").on("click", function(e){
        e.preventDefault(); // 전송기능 취소

        console.log("modify click");

        // <input type="hidden" name="" value="파일정보">

        let str = "";

        // 첨부된 파일목록의 태그를 통하여 정보를 참조. 파일첨부가 존재하지 않으면, 아래 선택자가 존재하지 않아서 밑에구문은 동작되지 않는다.
        $(".uploadResult ul li").each(function(i, obj){
          let jobj = $(obj);

          console.dir(jobj); // jobj객체의 속성정보를 출력. 요소를 JSON형태의 트리구조로 보여준다.
          console.log("------------------");
          console.log(jobj.data("filename"));

          // 첨부파일 테이블에 저장하기위한 파일정보를 <input>태그로 동적작업을 한다.
          str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
          str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
          str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
          str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>";
        });

        console.log(str);

        formObj.append(str);
        formObj.submit();

      });

      // 삭제(X)  버튼 클릭시 동작
      $(".uploadResult").on("click", "button", function(){

        console.log("delete file");

        let targetFile = $(this).data("file");
        let type = $(this).data("type");

        // 현재 선택자 기준에서 조상요소의 탐색. .parent() : 부모(단일), .parents(): 조상들(여러개), .parentsUntil(선택자) : 선택자 이전까지의 요소들, .closet(선택자) : 상위요소중 선택자에 해당하는 첫번째 요소(단일)
        let targetli = $(this).closest("li");


        $.ajax({
          url: '/board/deleteFile',
          data: {fileName: targetFile, type:type},  // 서버에 데이타 보내는 형태.1)javascript object문법 2) object-> json변환
          dataType: 'text',
          type: 'POST',
          success: function(result){
            alert(result);

            targetli.remove(); // 파일정보를 나타내는 li태그 화면에서 제거됨
          }
        });
      });
    });

  </script>

</body>
</html>

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

.reply_modal {
	position: fixed;
	top: 0;
	left: 0;
	z-index: 1050;
	display: none;
	width: 100%;
	height: 100%;
	overflow: hidden;
	outline: 0;
	opacity: 100 !important;
	margin-top: 100px;
}
</style>

</head>
<body>

	<%@include file="/WEB-INF/views/user/include/header.jsp"%>
	<div class="container">
		<div class="page_title">
			<h2>펫후 커뮤니티</h2>
		</div>

		<div class="box-body">
			<div class="form-group">
				<label for="bno">글번호</label> <input type="text" class="form-control"
					id="bno" name="bno" value="${board.bno }" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="title">제목</label> <input type="text"
					class="form-control" id="title" name="title"
					value="${board.title }" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<%--<textarea class="form-control" rows="3" id="content" name="content" readonly="readonly">${board.content }</textarea> --%>
				<div>${ board.content}</div>
			</div>
		</div>
		<!-- /.box-body -->

		<!--원본이미지 출력-->
		<div class='bigPictureWrapper'>
			<div class='bigPicture'></div>
		</div>
		<!-- 첨부파일목록 출력부분-->
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-header with-border">
						<br>
						<b>첨부파일</b>
					</div>
					<div class="box-body">
						<div class="uploadResult">
							<ul></ul>
						</div>
					</div>
				</div>
			</div>
		</div>


		<div class="form-group box-footer">
			<button id="btnModify" type="button" data-bno="${board.bno }"
				class="btn btn-primary">수정</button>
			<button type="button" id="btnReplyAdd" class="btn btn-primary">댓글
				작성</button>
			<button id="btnList" type="button" class="btn btn-info">리스트</button>

			<form id="operForm" action="/board/modify" method="get">
				<input type="hidden" id="bno" name="bno"
					value='<c:out value="${ board.bno}" />'> <input
					type="hidden" name="pageNum"
					value='<c:out value="${cri.pageNum }" />'> <input
					type="hidden" name="amount"
					value='<c:out value="${cri.amount }" />'> <input
					type="hidden" name="type" value='<c:out value="${cri.type }" />'>
				<input type="hidden" name="keyword"
					value='<c:out value="${cri.keyword }" />'>
			</form>
		</div>

		<!-- 댓글목록 출력부분 -->
		<span>댓글목록</span>
		<div class="row">
			<div class="col-md-12">
				<div id="replyList"></div>
			</div>
		</div>
		<!--댓글 페이징 출력-->
		<div class="row" id="replyPaging"></div>

	</div>

	<%@include file="/WEB-INF/views/user/include/footer.jsp"%>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script id="replyTemplate" type="text/x-handlebars-template">
  {{#each .}}
  <div class="modal-body">
    <div class="form-group">
      <label for="replyer" class="col-form-label rno"><b>No. <span class="reply-rno" id="rno" >{{rno}}</span></b></label>
      <input type="text" class="form-control" name="user_id" readonly value="{{user_id}}">
    </div>
    <div class="form-group">
      <label for="reply" class="col-form-label regdate">{{prettifyDate replydate}}</label>
      <textarea class="form-control" name="reply" readonly>{{reply}}</textarea>
    </div>
    <div class="form-group">
      <button type="button" class="btn btn-link btn-reply-modify">수정</button>
      <button type="button" class="btn btn-link btn-reply-delete">삭제</button>
    </div>
  </div>
  
  {{/each}}
</script>

	<script>
  // Handlebars 사용자정의 Helper : 댓글 작성일 밀리세컨드 데이타를 날짜포맷으로 변환하는 작업(2022/01/11)
  Handlebars.registerHelper("prettifyDate", function(timeValue){
    const date = new Date(timeValue);

    return date.getFullYear() + "/" + date.getMonth() + 1 + "/" + date.getDate();

  });



  //1)댓글목록출력함수
  // replyArr : 댓글데이타를 받을 파라미터 target : 댓글목록이 표시될 위치, templateObj : 템플릿을 참조하는 변수
  let printData = function (replyArr, target, templateObj) {

    let template = Handlebars.compile(templateObj.html());
    let html = template(replyArr); // 댓글 템플릿소스와 데이터가 바인딩되어 결합된 소스
    target.empty();
    target.append(html);
  }


  //2)댓글페이징기능함수
  // pageMaker : 페이징정보, target : 페이징이 출력될 위치.
  let printPaging = function(pageMaker, target){

    let pageInfoStr = "<div class='col-md-12'><div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'><ul class='pagination'>";

    if(pageMaker.prev){
      pageInfoStr += "<li class='paginate_button previous ";
			pageInfoStr += "id='example2_previous'><a href='" + (pageMaker.startPage - 1) + "'";
			pageInfoStr += " aria-controls='example2' data-dt-idx='0' tabindex='0'>Previous</a></li>";
    }

    for(let i=pageMaker.startPage; i<= pageMaker.endPage; i++){
      
      let strClass = (pageMaker.cri.pageNum == i) ? 'active' : '';
      pageInfoStr += "<li class='paginate_button " + strClass + "'><a href='" + i + "'>" + i + "</a></li>";
    }

    if(pageMaker.next){
      pageInfoStr += "<li class='paginate_button next ";
			pageInfoStr += "id='example2_next'><a href='" + (pageMaker.endPage + 1) + "'";
			pageInfoStr += " aria-controls='example2' data-dt-idx='0' tabindex='0'>Next</a></li>";
    }

    pageInfoStr += "</ul></div></div>";

    target.html(pageInfoStr);
  }


  //현재 게시물 번호
  let bno = <c:out value="${ board.bno}" />;
  let replyPage = 1;
    
  //현재 게시물번호에 해당하는 댓글목록 요청주소
  let url = "/reply/pages/" + bno + "/" + replyPage + ".json";
  getPage(url);

  function getPage(url){
    // 스프링에서 json포맷의 댓글목록과 페이징정보를 받아오는 구문
    $.getJSON(url, function(data){

        // data -> data.list, data.pageMaker

        // 댓글목록 출력
        printData(data.list, $("#replyList"), $("#replyTemplate"));
        // 댓글페이징출력
        printPaging(data.pageMaker, $("#replyPaging"));
    });
  }


</script>



	<script>

  $(document).ready(function(){

    let operForm = $("#operForm");

    //수정 버튼 클릭시 동작
    $("#btnModify").on("click", function(){
      operForm.submit();
    });

    //목록 버튼 클릭시 동작
    $("#btnList").on("click", function(){
      operForm.find("#bno").remove();
      operForm.attr("action", "/board/list");
      operForm.submit();
    });
   
  //페이지 번호 클릭시.
  $("#replyPaging").on("click", "li.paginate_button a", function(e){
    e.preventDefault();
    console.log("댓글 페이지번호 클릭");

    replyPage = $(this).attr("href");
    let url = "/reply/pages/" + bno + "/" + replyPage + ".json";
    getPage(url);
  });
  
  //댓글쓰기 대화상자
  $("#btnReplyAdd").on("click", function(){
    
    // 댓글 대화상자 필드 초기화
    $("#replyer").val("");
    $("#reply").val("");

    $("button#btnReplyWrite").show();
    $("button#btnReplyModify").hide();


    $("h5#exampleModalLabel").html("Reply Add");
    $("#exampleModal").modal('show');
  });
  
  
  
  //댓글저장버튼
  $("#btnReplyWrite").on("click", function(){

    $("h5#exampleModalLabel").html("Reply Add");

    // 선택자 ID속성이 중복되지 않게 사용한다.
    
    let reply = $("#reply").val();
    let rno = $("#rno").text();
    console.log("reply: " + reply);

	//추가
    if(reply == "" || reply == null){
        alert("내용을 입력하세요.");
        return;
      }    

    $.ajax({
      type: 'post',
      url : '/reply/new',
      headers: {
                "Content-Type" : "application/json","X-HTTP-Method-Override" : "POST"
              },
      dataType: 'text',
      data: JSON.stringify({bno:${board.bno},reply:reply}),
      success: function(result){
        if(result == "success"){
          alert("댓글 데이타 삽입성공");

           // 댓글 대화상자 필드 초기화
        $("#reply").val("");


          $("#exampleModal").modal('hide');

          replyPage = 1;
    
          //현재 게시물번호에 해당하는 댓글목록 요청주소
          url = "/reply/pages/" + bno + "/" + replyPage + ".json";
          getPage(url);

        }
      }
    });

  });

  // 댓글목록에서 수정버튼 클릭시

  $("#replyList").on("click", "button.btn-reply-modify", function(){
    //console.log("댓글수정버튼");
    
	let reply = $(this).parents("div.modal-body").find("textarea[name='reply']").val().replace("{{reply}}", "reply");
    let rno = $(this).parents("div.modal-body").find("span.reply-rno").text();
    let replydate = $(this).parents("div.modal-body").find("label.regdate").text();

    console.log("rno: " + rno);
    console.log("replydate: " + replydate);
    console.log("reply: " + reply);

    // 수정 모달대화상자에 댓글내용을 화면에 보여준다.
    $("h5#exampleModalLabel").html("댓글 수정 - ");
    $("h5#exampleModalLabel").append("&nbsp;&nbsp;No. " + rno);
    
    $("#reply").val(reply);
    $("#replybno").val(rno);

    $("button#btnReplyWrite").hide();
    $("button#btnReplyModify").show();

    
    $("#exampleModal").modal('show');
  });

  //댓글 수정대화상자에서 수정버튼 클릭시
  $("button#btnReplyModify").on("click", function(){
    //console.log("댓글 수정대화상자에서 수정버튼 클릭시");
    // ajax -> spring

    let reply = $("#reply").val();
    let rno = $("#rno").text();
    console.log("rno: " + rno);
    $.ajax({
      type: 'put',
      url: '/reply/modify/' + rno,
      headers: {
        "Content-Type" : "application/json", "X-HTTP-Method-Override" : "PUT"
      },
      dataType: 'text',
      data: JSON.stringify({reply:reply}),
      success: function(result){
        if(result == "success"){
          alert("댓글 수정됨");

        $("#replyer").val("");
        $("#reply").val("");


        $("#exampleModal").modal('hide');

        //현재 게시물번호에 해당하는 댓글목록 요청주소
        url = "/reply/pages/" + bno + "/" + replyPage + ".json";
        getPage(url);
        }
      }
    });
    

  });

  //댓글목록에서 삭제버튼 클릭
  $("#replyList").on("click", "button.btn-reply-delete", function(){

    let rno = $(this).parents("div.modal-body").find("span.reply-rno").text();

    if(!confirm("댓글 " + rno + "번을 삭제하겠습니까?")) { return;}

    $.ajax({
      type: 'delete',
      url: '/reply/delete/' + ${ board.bno} + '/' + rno,
      headers: {
        "Content-Type" : "application/json", "X-HTTP-Method-Override" : "DELETE"
      },
      dataType:'text',
      success: function(result){
        if(result == "success"){
          alert("댓글삭제됨");

          $("#exampleModal").modal('hide');

          //현재 게시물번호에 해당하는 댓글목록 요청주소
          url = "/reply/pages/" + bno + "/" + replyPage + ".json";
          getPage(url);
        }
      }
    });
  });


});



//첨부파일 목록 가져오기
$(document).ready(function(){

  let bno = '${ board.bno}'; //현재 게시물 번호

  $.getJSON("/board/getAttachList", {bno: bno}, function(arr){

	//1) 
	console.log(arr); // BoardAttachVO클래스
    
    showUploadResult(arr);
  });
  
  
//첨부된 파일정보를 이용하여, 화면에 파일목록을 출력하는 작업
  function showUploadResult(uploadResultArr){

    if(!uploadResultArr || uploadResultArr.length == 0){return;}

    let uploadUL = $(".uploadResult ul");

    let str = "";

    $(uploadResultArr).each(function(i, obj) {

      if(obj.fileType){
        //이미지파일출력
        let fileCalPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
        str += "<li data-path='" + obj.uploadPath + "'";
        str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName +"' data-type='" + obj.fileType + "'>";
        str += "<div>";
        str += "<span>" + obj.fileName + "</span>";
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
        str += "<img src='/resources/img/attach.png'>";
        str += "</div>";
        str += "</li>";
      }
    });
	//2)
    console.log(str);

    uploadUL.append(str);

  }
  

  // 게시물조회페이지(get.jsp)에서 첨부파일목록의 클릭시 1)이미지 : 원본이미지 출력 2)일반파일 : 다운로드
  $(".uploadResult").on("click", "li", function(e){

    console.log("veiw image");

    let liObj = $(this);

    let path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));

    if(liObj.data("type")){
      //원본이미지 보여주기
      showImage(path.replace(new RegExp(/\\/g), "/"));
    }else{
      //일반파일 : 다운로드
      self.location = "/board/download?fileName="+path;
    }

  });

  function showImage(fileCalPath){
    //alert(fileCalPath);

    $(".bigPictureWrapper").css("display", "flex").show();
    $(".bigPicture")
      .html("<img src='/board/display?fileName=" + fileCalPath + "'>")
      .animate({width: '100%', height: '100%'}, 1000);

  }

  $(".bigPictureWrapper").on("click", function(){
    $(".bigPicture").animate({width: '0%', height: '0%'}, 1000);

    setTimeout(function(){
      $(".bigPictureWrapper").hide();
    }, 1000);
  });

});

</script>
	<!-- Modal Dialog-->
	<div class="reply_modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">댓글 작성</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="reply" class="col-form-label">댓글내용</label>
							<textarea class="form-control" id="reply" name="reply"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="btnReplyWrite">작성</button>
					<button type="button" class="btn btn-primary" id="btnReplyModify">수정</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Dialog-->

</body>
</html>

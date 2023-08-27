<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<!-- css, js 파일포함 -->
<!-- 절대경로  /WEB-INF/views/include/header_info.jsp -->
<%@include file="/WEB-INF/views/admin/include/header_info.jsp"%>
<script src="/bower_components/ckeditor/ckeditor.js"></script>

<style>
#previewImage { /*width: 406px;*/
	width: 260px;
	margin: 20px 0;
}

#cke_1_contents {
	height: 363px !important;
}

.form-row {
	display: flex;
	flex-wrap: wrap;
	padding-top: 25px;
	padding-bottom: 30px;
	border-top: 2px dotted #c6cbdc;
}
</style>

<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">

	<div class="wrapper">

		<!-- Main Header -->
		<%@include file="/WEB-INF/views/admin/include/header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/admin/include/left_menu.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>상품수정</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
          | Your Page Content Here |
          -------------------------->

				<form action="productModify" method="post" id="productForm"
					enctype="multipart/form-data">
					<div class="form-row">
						<div class="col-md-6">
							<label for="pro_num">상품코드</label> <input type="text"
								class="form-control" id="pro_num" name="pro_num"
								value='<c:out value="${productVO.pro_num}" />'> <input
								type="hidden" name="pageNum" value="${cri.pageNum}"> <input
								type="hidden" name="amount" value="${cri.amount}"> <input
								type="hidden" name="type" value="${cri.type}"> <input
								type="hidden" name="keyword" value="${cri.keyword}">
						</div>
						<div class="col-md-6">
							<label for="pro_name">상품명</label> <input type="text"
								class="form-control" id="pro_name" name="pro_name"
								value='<c:out value="${productVO.pro_name}" />'>
						</div>
					</div>
					<div class="form-row">
						<div class="col-md-4">
							<label for="cate_prtcode">1차카테고리</label> <select
								class="form-control" id="mainCategory">
								<option value="">1차 카테고리선택</option>
								<c:forEach items="${mainCategory}" var="categoryVO">
									<c:if test="${not empty categoryVO.cate_code}">
										<option value="${categoryVO.cate_code }"
											${categoryVO.cate_code==productVO.cate_prtcode ? 'selected':''}>
											${categoryVO.cate_name }</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-4">
							<label for="cate_code">2차카테고리</label> <select
								class="form-control" id="subCategory">
								<option value="">2차카테고리 선택</option>
								<c:forEach items="${subCategory}" var="categoryVO">
									<option value="${categoryVO.cate_code}"
										${categoryVO.cate_code==productVO.cate_subprtcode ? 'selected':''}
										${categoryVO.cate_code==0 ? 'disabled':''}>
										${categoryVO.cate_name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-4">
							<label for="cate_code">3차카테고리</label> <select
								class="form-control" id="lastsubCategory">
								<option value="">3차카테고리 선택</option>
								<c:forEach items="${lastsubCategory}" var="categoryVO">
									<option value="${categoryVO.cate_code }"
										${categoryVO.cate_code==productVO.cate_code ? 'selected':''}>
										${categoryVO.cate_name }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-row">
						<div class="col-md-4">
							<label for="pro_price">상품가격</label> <input type="text"
								class="form-control" id="pro_price" name="pro_price"
								value='<c:out value="${productVO.pro_price}" />'>
						</div>
						<div class="col-md-4">
							<label for="pro_discount">할인가격</label><span
								id="discount_percentage" style="color: #d23473;"></span> <input
								type="text" class="form-control" id="pro_discount"
								name="pro_discount"
								value='<c:out value="${productVO.pro_discount}" />'>
						</div>
						<div class="col-md-4">
							<label for="pro_amount">재고수량</label> <input type="text"
								class="form-control" id="pro_amount" name="pro_amount"
								value='<c:out value="${productVO.pro_amount}" />'>
						</div>
					</div>
					<div class="form-row">
						<div class="col-md-4">
							<label id="pro_promo">상품의 프로모션</label> <input type="text"
								class="form-control" id="pro_promo" name="pro_promo"
								value='<c:out value="${productVO.pro_promo}" />'>
						</div>
						<div class="col-md-4">
							<label id="pro_tag">상품 태그</label> <input type="text"
								class="form-control" id="pro_tag" name="pro_tag"
								value='<c:out value="${productVO.pro_tag}" />'>
						</div>
						<div class="col-md-4">
							<label for="pro_purchase">판매여부</label> <select
								class="form-control" id="pro_purchase" name="pro_purchase">
								<option>판매여부를 선택하세요</option>
								<option value="Y"
									<c:out value="${productVO.pro_purchase == 'Y' ? 'selected' : ''}" />>판매함</option>
								<option value="N"
									<c:out value="${productVO.pro_purchase == 'N' ? 'selected' : ''}" />>판매하지
									않음</option>
							</select>
						</div>
					</div>
					<!-- 상품설명 : CKeditor -->
					<div class="form-row">
						<div class="col-md-12">
							<label for="pro_content">상품설명</label>
							<textarea id="pro_content" name="pro_content" rows="10" cols="80"><c:out
									value="${productVO.pro_content}" /></textarea>
						</div>
					</div>
					<div class="form-row" style="min-height: 250px;">
						<div class="col-md-4">
							<label for="upload">상품이미지</label> <input type="file" id="upload"
								name="upload">
							<!-- 이미지 변경시 기존이미지정보를 이용하여 기존이미지 삭제, 이미지 변경 안하면, 기존이미지 정보를 수정데이타로 사용 -->
							<input type="hidden" name="pro_uploadpath"
								value="<c:out value="${productVO.pro_uploadpath}" />"> <input
								type="hidden" name="pro_img"
								value="<c:out value="${productVO.pro_img}" />">
						</div>
						<div class="col-md-8">
							<label for="upload">미리보기</label><br> <img
								name="proudctImage" id="previewImage"
								src="/admin/product/displayFile?fileName=<c:out value="${productVO.pro_img }"></c:out>&uploadPath=<c:out value="${productVO.pro_uploadpath }"></c:out>">
						</div>
					</div>
					<div class="form-row">
						<div class="col-md-5">
							<label for=""></label> <input type="hidden" class="form-control"
								id="" name="">
						</div>
						<div class="col-md-2">
							<button type="submit" id="btnProductInsert" class="form-control">상품수정</button>
						</div>
						<div class="col-md-5">
							<label for=""></label> <input type="hidden" class="form-control"
								id="" name="">
						</div>
					</div>
				</form>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer (기타 footer태그밑에 소스포함)-->
		<%@include file="/WEB-INF/views/admin/include/footer.jsp"%>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->
	<%@include file="/WEB-INF/views/admin/include/plugin_js.jsp"%>

	<!-- 상품이미지 미리보기 -->
	<script>
    
      function readImage(input) {
        if (input.files && input.files[0]) {
            
          //let imgPath = input.files[0].value;
          let imgPath = $("#upload").val();
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
            $("#upload").val("");
            alert("이미지 파일을 선택하세요.");
          }
        }
      }
      // 이벤트 리스너
      document.getElementById('upload').addEventListener('change', (e) => {
          readImage(e.target);
      })

  </script>

	<script>
    $(document).ready(function(){
        
        let ckeditor_config = {
          resize_enabled : false,
          enterMode : CKEDITOR.ENTER_BR,
          shiftEnterMode : CKEDITOR.ENTER_P,
          toolbarCanCollapse : true,
          removePlugins : "elementspath",
          
          filebrowserUploadUrl : "editor/imageUpload"  // /editor/imageUpload. 이미지 업로드시 업로드탭 보기
              
        };
        
        CKEDITOR.replace('pro_content', ckeditor_config);
        
        // 4.8.0 (Standard)
        // alert(CKEDITOR.version);  
        
    });
  </script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script id="subCategoryTemplate" type="text/x-handlebars-template">
    
    <option value="">2차카테고리 선택</option>
    {{#each .}}
    
    <option value="{{cate_code}}">{{cate_name}}</option>
    
    {{/each}}
  </script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script id="lastsubCategoryTemplate" type="text/x-handlebars-template">
    
    <option value="">3차카테고리 선택</option>
    {{#each .}}
    
    <option value="{{cate_code}}">{{cate_name}}</option>
    
    {{/each}}
  </script>


	<script>
    $(document).ready(function(){
		//1차 카테고리 선택시 2차 카테고리 변경
    	$("#mainCategory").on("change", function(){

        if($(this).val() == "") {alert("카테고리 선택하세요."); return;}

        let url = "/admin/product/subCategory/" + $(this).val()
      
        $.getJSON(url, function(data){

          subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate"));
          console.log("2차 url: "+url);
        });

      });

      
      //2차 카테고리 선택기
      $("#subCategory").on("change", function(){
        
          let url = "/admin/product/lastsubCategory/" +$("#mainCategory option:selected").val()+"/"+ $(this).val()
          console.log("2차 url: "+url);

          $.getJSON(url, function(data){

            lastsubCategoryBindingView(data, $("#lastsubCategory"), $("#lastsubCategoryTemplate"));
            $("#mainCategory option:selected").val()
            console.log("2차 url: "+url);

          });

        });

      // subCategory: 2차카테고리 데이타
      // target : 2차카테고리 바인딩 결과가 출력될 위치
      // template : 2차카테고리 핸들바템플릿
      let subCategoryBindingView = function(subCategory, target, template) {

        let templateObj = Handlebars.compile(template.html());
        let subCateOptionsResult = templateObj(subCategory);


        //누적되는 증상발생. 처리..
        $("#subCategory option").remove();
        target.append(subCateOptionsResult);

      }
      //3차 카테고리
      let lastsubCategoryBindingView = function(lastsubCategory, target, template) {

          let templateObj = Handlebars.compile(template.html());
          let lastsubCateOptionsResult = templateObj(lastsubCategory);

          //누적되는 증상발생. 처리..
          $("#lastsubCategory option").remove();
          target.append(lastsubCateOptionsResult);

        }
      
    });
    
    //폼에서 전송버튼<input type="submit">을 클릭하면 호출되는 이벤트설정
    $("#productForm").on("submit", function(){
        let cate_prtcode = $("#mainCategory").val();
        let cate_subprtcode = $("#subCategory").val();
        let cate_code = $("#lastsubCategory").val();
        
        if(cate_prtcode !== "" && cate_prtcode !== null) {

          $("#productForm").append("<input type='hidden' name='cate_prtcode' value='" + cate_prtcode + "'>");
          $("#productForm").append("<input type='hidden' name='cate_subprtcode' value='0'>");
          $("#productForm").append("<input type='hidden' name='cate_code' value='" + cate_prtcode + "'>");
        }

        if(cate_subprtcode !== "" && cate_subprtcode !== null) {
          $("#productForm").find("input[name='cate_subprtcode']").val(cate_subprtcode);		  			
        }
        
        if(cate_code !== "" && cate_code !== null) {
          $("#productForm").find("input[name='cate_code']").val(cate_code);		  			
        }
      
        if($('#pro_name').val() == "" ||$('#pro_name').val() == null){
            alert("상품명을 입력하세요.");
            $("#pro_name").focus();
            return false;
          }
        
          if($('#mainCategory').val() == "" ||  $('#mainCategory').val() == null){
                alert("1차 카테고리를 선택해주세요");
                $('#mainCategory').focus();pro_price
                return false;
              }
      
          if($('#pro_price').val() == "" ||  $('#pro_price').val() == null){
            alert("상품 가격을 입력하세요.");
            $('#pro_price').focus();pro_price
            return false;
          }
          
          if($('#pro_discount').val() == "" ||  $('#pro_discount').val() == null){
              alert("할인 가격을 입력하세요.");
              $('#pro_discount').focus();
              return false;
          }           
          
          if($('#pro_amount').val() == "" || $('#pro_amount').val() == null){
              alert("재고수량을 입력하세요.");
              $('#pro_amount').focus();
              return false;
            }
        
          if ($('#pro_purchase').val() == '') {
              alert('판매여부를 선택해주세요.');
              return false;
            }
          
          if ($('#pro_content').val().trim() == '') {
              alert('상품설명을 입력해주세요.');
              return false;
            }

          if ($('#previewImage').attr('src') === "") {
              alert('파일을 선택해주세요.');
              return false;
            }

          //컴마 삭제
          	let value = parseInt(removeComma($("#pro_price").val()));
            let value2 = parseInt(removeComma($("#pro_discount").val()));
            $("#pro_price").val(value);
            $("#pro_discount").val(value2);

    });


    </script>
</body>
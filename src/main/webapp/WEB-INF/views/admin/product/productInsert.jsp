<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<!-- css, js 파일포함 -->
<!-- 절대경로  /WEB-INF/views/include/header_info.jsp -->
<%@include file="/WEB-INF/views/admin/include/header_info.jsp" %>
<script src="/bower_components/ckeditor/ckeditor.js"></script>
<style>
#previewImage { /*width: 406px;*/ width: 260px; margin: 20px 0; }
#cke_1_contents { height: 363px !important; }
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
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/left_menu.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
   <h3>상품등록</h3>
  <form action="productInsert" method="post" id="productForm" enctype="multipart/form-data">
  <div class="form-row">
    <div class="col-md-6">
       <label for="pro_num">상품코드</label>
       <input type="text" <%-- value="${seq_product_num.nextval}" --%>class="form-control" id="pro_num" name="pro_num" readonly>
   </div>
   <div class="col-md-6">
       <label for="pro_name">상품명</label>
       <input type="text" class="form-control" id="pro_name" name="pro_name">
   </div>
  </div>
  <div class="form-row">
    <div class="col-md-4">
       <label for="cate_prtcode">1차카테고리</label>
       <select class="form-control" id="mainCategory" name="cate_prtcode">
         <option value="">1차 카테고리선택</option>
         
         <c:forEach items="${mainCategory}" var="categoryVO" varStatus="status">
         	<option value="${categoryVO.cate_code }">${categoryVO.cate_name }</option>	
         </c:forEach>
         
       </select>
   </div>
   <div class="col-md-4">
      <label for="cate_code">2차카테고리</label>
       <select class="form-control" id="subCategory" name="cate_subprtcode">
         
       </select>
    </div>
    <div class="col-md-4">
      <label for="cate_code">3차카테고리</label>
       <select class="form-control" id="lastsubCategory" name="cate_code">
         
       </select>
    </div>
  </div>
  <div class="form-row">
    <div class="col-md-3">
      <label for="pro_price">상품가격</label>
       <input type="text" class="form-control" id="pro_price" name="pro_price">
    </div>
    <div class="col-md-3">
       <label for="pro_discount">할인율</label>
       <input type="text" class="form-control" id="pro_discount" name="pro_discount">
   </div>
   <div class="col-md-3">
      <label id="pro_promo">상품의 프로모션</label>
       <input type="text" class="form-control" id="pro_promo" name="pro_promo">
    </div>
    <div class="col-md-3">
      <label id="pro_tag">상품 태그</label>
       <input type="text" class="form-control" id="pro_tag" name="pro_tag">
    </div>
  </div>
   <!-- 상품설명 : CKeditor -->
   <div class="form-row">
    <div class="col-md-12">
      <label for="pro_content">상품설명</label>
      <textarea id="pro_content" name="pro_content" rows="10" cols="80"></textarea>
    </div>
  </div>
  <div class="form-row">
    <div class="col-md-4">
      <label for="upload">상품이미지</label>
      <input type="file" id="upload" name="upload">
    </div>
    <div class="col-md-4">
      <label for="upload">미리보기</label>
      <img alt="" src="" id="previewImage">
      <!--<div id="preview_image"></div>-->
    </div>
    <div class="col-md-4">
      <label for="upload"></label>
      
    </div>
  </div>
  
   <div class="form-row">
    <div class="col-md-4">
      <label for="pro_amount">재고수량</label>
      <input type="text" class="form-control" id="pro_amount" name="pro_amount">
    </div>
    <div class="col-md-4">
      <label for="pro_purchase">판매여부</label>
      <select class="form-control" id="pro_purchase" name="pro_purchase">
         <option>판매여부를 선택하세요</option>
         <option value="Y">판매함</option>
         <option value="N">판매하지 않음</option>
     </select>
      
    </div>
    <div class="col-md-4">
      <label for=""></label>
      <input type="hidden" class="form-control" id="" name="">
      
    </div>
    
   </div>
   <div class="form-row">
   <div class="col-md-5">
      <label for=""></label>
      <input type="hidden" class="form-control" id="" name="">
      
    </div>
    <div class="col-md-2">
      <button type="submit" id="btnProductInsert" class="form-control">상품등록</button>
    </div>
    <div class="col-md-5">
      <label for=""></label>
      <input type="hidden" class="form-control" id="" name="">
      
    </div>
   </div>
  
</form>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer (기타 footer태그밑에 소스포함)-->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/admin/include/plugin_js.jsp" %>

<!-- 상품이미지 미리보기 -->
<script>
  /*
   $(document).ready(function() {

    
    
    $("#upload").on("change", function() {
      let countFiles = $(this)[0].files.length;
      let imgPath = $(this)[0].value;
      let ext = imgPath.substring(imgPath.lastIndexOf(".")+1).toLowerCase();
      let preview_image = $("#preview_image");
      preview_image.empty();      

      if(ext == "gif" || ext == "png" || ext == "jpg" || "jpeg" ) {
        if(typeof(FileReader) != "undefined") {
          for(let i=0; i<countFiles; i++) {
            let reader = new FileReader();
            reader.onload = function(e) {
              $("<img />"), {
                "src": e.target.resut,
                "class": "thumb-image"
              }.appendTo(preview_image);
            }

            preview_image.show();
            reader.readAsDataURL($(this)[0].files[i]);
              }
          }else {
            alert("브라우저가 FileReader객체를 지원하지 않음");
          }
        } else {
            alert("이미지 파일을 선택하세요");
        }
      });
      
    });
    */
    //파일첨부
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
      // CKEditor 설정구문
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="subCategoryTemplate" type="text/x-handlebars-template">
  
  <option>2차카테고리 선택</option>
  {{#each .}}
  
   <option value="{{cate_code}}">{{cate_name}}</option>
  
  {{/each}}
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="lastsubCategoryTemplate" type="text/x-handlebars-template">
  
  <option>3차카테고리 선택</option>
  {{#each .}}
  
   <option value="{{cate_code}}">{{cate_name}}</option>
  
  {{/each}}
</script>


<script>
  $(document).ready(function(){

    $("#mainCategory").on("change", function(){

      if($(this).val() == "") {alert("카테고리 선택하세요."); return;}

      let url = "/admin/product/subCategory/" + $(this).val()

      $.getJSON(url, function(data){

        subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate"));
        console.log("2차 url: "+url);
      });

    });

    // 상품가격 입력시 이벤트
    $("#pro_price").on("keyup", function(){
      console.log("콤마표시");
      $(this).val(addComma($(this).val().replace(/[^0-9]/g,"")));
    });

    function addComma(value) {
      value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");

      return value;
    }
    
    // type="submit" 전송버튼이 클릭시
    $("#productForm").on("submit", function(){

      let value = $("#pro_price").val().replace(/[^\d]+/g, ""); // 콤마제거
      $("#pro_price").val(value);

      //return false;
    });
    
    //2차 카테고리 선태기
    $("#subCategory").on("change", function(){
      
        let url = "/admin/product/lastsubCategory/" +$("#mainCategory option:selected").val()+"/"+ $(this).val()
        console.log("2차 url: "+url);

        $.getJSON(url, function(data){

          lastsubCategoryBindingView(data, $("#lastsubCategory"), $("#lastsubCategoryTemplate"));
          $("#mainCategory option:selected").val()
          console.log("2차 url: "+url);

        });

      });

      // 상품가격 입력시 이벤트
      $("#pro_price").on("keyup", function(){
        console.log("콤마표시");
        $(this).val(addComma($(this).val().replace(/[^0-9]/g,"")));
      });

      function addComma(value) {
        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");

        return value;
      }
      
      // type="submit" 전송버튼이 클릭시
      $("#productForm").on("submit", function(){

        let value = $("#pro_price").val().replace(/[^\d]+/g, ""); // 콤마제거
        $("#pro_price").val(value);

        //return false;
      });



  });


</script>
<script>
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
  
  let lastsubCategoryBindingView = function(lastsubCategory, target, template) {

       let templateObj = Handlebars.compile(template.html());
       let lastsubCateOptionsResult = templateObj(lastsubCategory);


       //누적되는 증상발생. 처리..
       $("#lastsubCategory option").remove();
       target.append(lastsubCateOptionsResult);

     }
  

</script>
</body>
</html>
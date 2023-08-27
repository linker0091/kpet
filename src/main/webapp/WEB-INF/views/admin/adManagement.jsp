<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<!-- css, js 파일포함 -->
<!-- 절대경로  /WEB-INF/views/include/header_info.jsp -->
<%@include file="/WEB-INF/views/admin/include/header_info.jsp"%>
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
				<h1>Admin 관리</h1>
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

				<div id="example2_wrapper"
					class="dataTables_wrapper form-inline dt-bootstrap">
					<div class="row">
						<div class="col-sm-6">
							총 관리자 :
							<c:out value="${admin_total}" />
							명
						</div>
						<div class="col-sm-6"></div>
					</div>
					<div class="row">
						<div class="col-sm-10" id="adminbox">
							<table id="adminlist"
								class="table table-bordered table-hover dataTable" role="grid"
								aria-describedby="example2_info">
								<thead>
									<tr role="row">
										<th><input type="checkbox" id="checkAll" name="checkAll"></th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Browser: activate to sort column ascending">번호</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Platform(s): activate to sort column ascending">아이디</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Engine version: activate to sort column ascending">이름</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Engine version: activate to sort column ascending">직책</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Engine version: activate to sort column ascending">마지막로그인</th>
										<th class="sorting" tabindex="0" aria-controls="example2"
											rowspan="1" colspan="1"
											aria-label="Engine version: activate to sort column ascending">기능</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${AdminList }" var="AdminVO"
										varStatus="status">
										<tr role="row"
											class="<c:if test="${status.count % 2 == 0 }">odd</c:if>
                        <c:if test="${status.count % 2 != 0 }">even</c:if>">
											<td><input type="checkbox" class="check"
												value='<c:out value="${AdminVO.ad_id }"></c:out>'></td>
											<td class="sorting_1"><c:out value="${status.count}" /></td>
											<td><c:out value="${AdminVO.ad_id }" /></td>
											<td><c:out value="${AdminVO.ad_name }" /></td>

											<td><select name="ad_position">
													<option value=""
														<c:out value="${AdminVO.ad_position == null? 'selected':'' }" />>관리자
														직책 선택</option>
													<option value="총관리자"
														<c:out value="${AdminVO.ad_position eq '총관리자'? 'selected':'' }" />>총
														관리자</option>
													<option value="중간관리자"
														<c:out value="${AdminVO.ad_position eq '중간관리자'? 'selected':'' }" />>중간
														관리자</option>
													<option value="하위관리자"
														<c:out value="${AdminVO.ad_position eq '하위관리자'? 'selected':'' }" />>하위
														관리자</option>
											</select></td>
											<td><fmt:formatDate value="${AdminVO.ad_lastlogin }"
													pattern="yyyy-MM-dd hh:mm" /></td>
											<td><input type="button" name="btnAdPositionChange"
												value="적용" data-ad_id="${AdminVO.ad_id }">
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-5 dataTables_info"></div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<input type="button" name="btnAdPositionAll"
								id="btnAdPositionAll" value="직책일괄변경"> <input
								type="button" id="btnCheckDelete" value="선택삭제">
						</div>
					</div>
				</div>
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

	<script>
    $(document).ready(function() {

    let isCheck = true;
    /*전체선택 체크박스 클릭*/
    $("#checkAll").on("click", function() {
      $(".check").prop("checked", this.checked);

      isCheck = this.checked;
    });

    // 데이터행 체크박스 클릭
    $(".check").on("click", function() {

      $("#checkAll").prop("checked", this.checked);

      $(".check").each(function() {
        if (!$(this).is(":checked")) { // 체크박스중 하나라도 해제된 상태라면  false
          $("#checkAll").prop("checked", false);
        }
      });
    });

    // 셀렉트 변경시
    $("select[name='ad_position']").on("change", function() {
    // 셀렉트 박스가 변경되면 체크박스 선택 여부 변경
    let checkbox = $(this).closest("tr").find("input[type='checkbox']");
    checkbox.prop("checked", $(this).val() !== "");
    });

    

    //선택 관리자삭제
    $("#btnCheckDelete").on("click",function() {
      if ($(".check:checked").length == 0) {
        alert("삭제할 관리자를 선택하세요.");
        return;
      }

      let isDel = confirm("선택한 관리자를 삭제하겠습까?");

      if (!isDel)
        return;

      // 데이터행에서 체크된 상품코드, 상품이미지

      //자바스크립트 배열
      let ad_idArr = []; //아이디 배열

      //선택된 체크박스 일 경우
      $(".check:checked").each(function() {
        let ad_id = $(this).val();
        ad_idArr.push(ad_id);
      })

      //console.log("상품코드: " + pro_numArr);
      //console.log("상품이미지: " + pro_imgArr);
      $.ajax({
        url : '/admin/checkDelete',
        type : 'post',
        dataType : 'text',
        data : {
          ad_idArr : ad_idArr
        },
        success : function(
            data) {
          if (data == "success") {
            alert("선택된 관리자가 삭제됨");

            console.log($(".check:checked").length);
            location.href = "/admin/adManagement";
          }
        }
      });

    });

    //관리자 직책 변경 - 적용버튼 클릭시
    $("input[name='btnAdPositionChange']").on("click", function() {

      if ($(".check:checked").length == 0) {
        alert("직책변경 할 관리자를 선택하세요.");
        return;
      }

      let ad_id = $(this).data("ad_id");
      let ad_position = $(this).parent().parent().find("select[name='ad_position']").val();

      console.log(ad_id + "," + ad_position);

      //자바스크립트 배열
      let ad_idArr = []; //관리자 아이디 배열
      ad_idArr.push(ad_id);
      let ad_positionArr = []; //관리자 직책 배열
      ad_positionArr.push(ad_position);

      $.ajax({
        url : '/admin/AdPositionModify',
        type : 'post',
        dataType : 'text',
        data : {
          ad_idArr : ad_idArr,
          ad_positionArr : ad_positionArr
        },
        success : function(
            data) {
          if (data == "success") {
            alert("관리자 직책이 변경됨");
            location.reload();
          }
        }
      });
    });
    
    // 선택일괄변경 
    $("#btnAdPositionAll").on("click", function() {
      if ($(".check:checked").length == 0) {
        alert("직책을 변경할 관리자들을 선택하세요.");
        return;
      }

      //자바스크립트 배열
      let ad_idArr = []; //주문번호 배열
      let ad_positionArr = []; //주문상태 배열

      //선택된 체크박스 일 경우
      $(".check:checked").each( function() {
        let ad_id = $(this).val();
        let ad_position = $(this).parent().parent().find("select[name='ad_position']").val();

        ad_idArr.push(ad_id);
        ad_positionArr.push(ad_position);

      })

      console.log(ad_idArr);
      console.log(ad_positionArr);

      $.ajax({
        url : '/admin/AdPositionModify',
        type : 'post',
        dataType : 'text',
        data : {
          ad_idArr : ad_idArr,
          ad_positionArr : ad_positionArr
        },
        success : function(data) {
          if (data == "success") {
            alert("선택된 관리자들의 직책이 변경됨");
            location.reload();
          }
        }
      });
    });
    
    

  });
    </script>

</body>
</html>

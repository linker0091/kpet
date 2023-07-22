<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- css, js 파일포함 -->
<%@include file="/WEB-INF/views/admin/include/header_info.jsp"%>
<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/admin/include/plugin_js.jsp"%>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

    function primeChart() {
      let data = google.visualization.arrayToDataTable(${prime_month_chart});

      let options = {
        title: '1차 카테고리 월 주문통계'
      };

      let chart = new google.visualization.PieChart(document.getElementById('primeMonthPiechart'));
      console.log("1차 : " + data)
      chart.draw(data, options);
    }
    
    function secondChart() {
      let data = google.visualization.arrayToDataTable(${second_month_chart});

      let options = {
          title: '2차 카테고리 월 주문통계'
      };

      let chart = new google.visualization.PieChart(document.getElementById('secondMonthPiechart'));
      console.log("2차 : " + data)
      chart.draw(data, options);
    }
    
    function thirdChart() {
      let data = google.visualization.arrayToDataTable(${third_month_chart});

      let options = {
          title: '3차 카테고리 월 주문통계'
      };

      let chart = new google.visualization.PieChart(document.getElementById('thirdMonthPiechart'));
      console.log("3차 : " + data)
      chart.draw(data, options);
    }

    $(function(){   
      $("#btnYearMonthlyChart").on("click", function(){

        let year = $("#year").val();
        let month = $("#month").val();
        let para = year + "/" + month;

        location.href = "/admin/chart/monthlyOrder?ord_date="+para;
      });   
    });
    
    google.charts.load('current', {'packages':['corechart']});
      
    // 1차카테고리 월별주문통계차트
    google.charts.setOnLoadCallback(primeChart);
    google.charts.setOnLoadCallback(secondChart);
    google.charts.setOnLoadCallback(thirdChart);
    
  </script>

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
				<h1>월별 통계</h1>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
				<div class="row">
					<div class="container">
						<select id="year">
							<option>년도를 선택하세요</option>
							<c:forEach var="year" items="${years}">
								<option value="${year}"
									<c:if test="${year eq ord_year}">selected</c:if>>${year}</option>
							</c:forEach>
						</select> <select id="month">
							<option>월을 선택하세요.</option>
							<c:forEach var="month" items="${months}">
								<option value="${month}"
									<c:if test="${month eq ord_month}">selected</c:if>>${month}</option>
							</c:forEach>
						</select> <input type="button" id="btnYearMonthlyChart" value="검색">
						<div class="row">
							<div class="col-md-4">
								<div id="primeMonthPiechart"
									style="width: 300px; height: 300px;"></div>
							</div>
							<div class="col-md-4">
								<div id="secondMonthPiechart"
									style="width: 300px; height: 300px;"></div>
							</div>
							<div class="col-md-4">
								<div id="thirdMonthPiechart"
									style="width: 300px; height: 300px;"></div>
							</div>
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
</body>
</html>

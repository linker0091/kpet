<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar Menu -->
		<ul class="sidebar-menu" data-widget="tree">
			<li class="header">HEADER</li>
			<!-- Optionally, you can add icons to the links >-->
			<li class="active"><a href="/product/productMain"><i
					class="fa fa-link"></i> <span>KPET쇼핑몰</span></a></li>
			<li class="treeview"><a href="#"><i class="fa fa-link"></i>
					<span>관리자기능</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="/admin/adRegister">admin 추가</a></li>
					<li><a href="/admin/adManagement">admin 관리</a></li>
				</ul></li>
			<li class="treeview"><a href="#"><i class="fa fa-link"></i>
					<span>상품관리</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="/admin/product/productInsert">상품등록</a></li>
					<li><a href="/admin/product/productList">상품리스트</a></li>
				</ul></li>
			<li class="treeview"><a href="#"><i class="fa fa-link"></i>
					<span>주문관리</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="/admin/order/orderList">주문리스트</a></li>
				</ul></li>
			<li class="treeview"><a href="#"><i class="fa fa-link"></i>
					<span>회원관리</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="/admin/consult/cstList">1:1 맞춤상담</a></li>
				</ul></li>
			<li class="treeview"><a href="#"><i class="fa fa-link"></i>
					<span>통계관리</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="/admin/chart/overall">차트</a></li>
					<li><a href="/admin/chart/monthlyOrder">차트2(월별차트)</a></li>
				</ul></li>
		</ul>
		<!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
</aside>
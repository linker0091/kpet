<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<header class="main-header">

	<!-- Logo -->
	<a href="/admin/main" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
		<span class="logo-mini"><b>KPET</b></span> <!-- logo for regular state and mobile devices -->
		<span class="logo-lg"><b>KPET</b></span>
	</a>

	<!-- Header Navbar -->
	<nav class="navbar navbar-static-top" role="navigation">
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="push-menu"
			role="button"> <span class="sr-only">Toggle navigation</span>
		</a>
		<!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- Messages: style can be found in dropdown.less-->
				<li class="dropdown messages-menu">
					<!-- Menu toggle button --> <a href="/admin/consult/cstList"> <i
						class="fa fa-envelope-o"></i> <span class="label label-success">${cst_requestCount}</span>
				</a>
				</li>
				<!-- /.messages-menu -->

				<!-- Notifications Menu -->
				<li class="dropdown notifications-menu">
					<!-- Menu toggle button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-bell-o"></i> <span
						class="label label-warning">${ord_requestCount}</span>
				</a>
					<ul class="dropdown-menu">
						<li>
							<!-- Inner Menu: contains the notifications -->
							<ul class="menu">
								<li>
									<!-- start notification --> <a
									href="/admin/order/orderStateList?ord_state=결제완료"> <span>결제완료
											: ${ordPaid}건</span>
								</a>
								</li>
								<li>
									<!-- start notification --> <a
									href="/admin/order/orderStateList?ord_state=취소요청"> <span>취소요청
											: ${ordCancel}건</span>
								</a>
								</li>
								<li>
									<!-- start notification --> <a
									href="/admin/order/orderStateList?ord_state=교환요청"> <span>교환요청
											: ${ordExchange}건</span>
								</a>
								</li>
								<li>
									<!-- start notification --> <a
									href="/admin/order/orderStateList?ord_state=반품요청"> <span>반품요청
											: ${ordReturn}건</span>
								</a>
								</li>
								<!-- end notification -->
							</ul>
						</li>
					</ul>
				</li>
				<!-- User Account Menu -->
				<li class="dropdown user user-menu">
					<!-- Menu Toggle Button --> <!-- 로그인 이후상태 표시 --> <a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <span
						class="hidden-xs"><c:out
								value="[${sessionScope.adminStatus.ad_name}]" />님 로그인중입니다.</span>
				</a>
					<ul class="dropdown-menu">
						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-right">
								<a href="/admin/logout" class="btn btn-default btn-flat">로그아웃</a>
							</div>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
</header>
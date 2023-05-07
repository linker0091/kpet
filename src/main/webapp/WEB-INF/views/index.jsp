<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
 <title>Document</title>
 
    <body>
     <!-- Header-->
	    <%@include file="/WEB-INF/views/user/include/header.jsp" %>
	    
     <!-- Header-->
         <section id="contents">
			<div class="container">
			<!-- contents -->
			<style>
			
/* Custom style to prevent carousel from being distorted 
   if for some reason image doesn't load */
.carousel-item{
    min-height: 280px;
    background-color: #000;
}
</style>

</head>
<body>
<div class="container-lg my-3">
    <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
        <!-- Carousel indicators -->
        <ol class="carousel-indicators">
            <li data-bs-target="#myCarousel" data-bs-slide-to="0" class="active"></li>
            <li data-bs-target="#myCarousel" data-bs-slide-to="1"></li>
            <li data-bs-target="#myCarousel" data-bs-slide-to="2"></li>
        </ol>
        
        <!-- Wrapper for carousel items -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="/examples/images/slide1.png" class="d-block w-100" alt="Slide 1">
            </div>
            <div class="carousel-item">
                <img src="/examples/images/slide2.png" class="d-block w-100" alt="Slide 2">
                <h1>안</h1>
            </div>
            <div class="carousel-item">
                <img src="/examples/images/slide3.png" class="d-block w-100" alt="Slide 3">
                <h1>안</h1>
            </div>
        </div>

        <!-- Carousel controls -->
        <a class="carousel-control-prev" href="#myCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
    </div>
</div>
			<!-- contents END -->
			</div>
        </section>
         
        <!-- Footer-->
        <%@include file="/WEB-INF/views/user/include/footer.jsp" %>
         
         
         <script>
         
         $(document).ready(function(){
        	let msg = '${msg}';
         	if(msg == 'modifyOk') {
        			alert("회원정보가 수정됨");
        		}
         });
         </script>
    </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/user/include/plugin_js.jsp" %>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/main_style.css" rel="stylesheet" /> 
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

       <div class="wrap_gnb">
            <div class="container">
                
            </div>
        </div>
 <!-- Header-->
         <header id="header">
            <div class="header_top">
                <div class="container">
                    <h1>
                        <a href="/">KPET</a>
                    </h1>
                    <div class="side_menu clearfix">
                        <ul class="clearfix">
                           
                           <!-- 로그인 이전상태 표시 -->
                      <c:if test="${sessionScope.loginStatus == null }">
                          <li><a href="/user/login">로그인</a></li>
                               <li><a href="/user/join">회원가입</a></li>
                      </c:if>
                      <!-- 로그인 이후상태 표시 -->
                      <c:if test="${sessionScope.loginStatus != null }">
                         <li><a href="/user/logout">로그아웃</a></li>
                               <li><a href="/user/modify">회원정보 수정</a></li>
                               <li><a href="/user/mypage">마이페이지</a></li>
                      </c:if>
                            <li><a href="#">고객센터</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="header_bottom">
                <div class="container">
                    <div class="header_gnb">
                        <ul class="clearfix">
                            <c:forEach items="${userCategory}" var="categoryVO">
                              <li class="nav-item">
                                <a class="nav-link" data-toggle="dropdown" href="${categoryVO.cate_code }" role="button">${categoryVO.cate_name }</a>
                               <div class="clearfix">
                                    <div class="depth2 drop clearfix">
                                        <ul class="subCategory depth2_subbox" id="subCategory_${categoryVO.cate_code }">
                                           <li>
                                                <a class="depth3" id="lastsubCategory_${categoryVO.cate_code }"></a>
                                           </li>
                                        </ul>
                                    </div>
                               
                                    <div class="depth3 ">
                                        <ul class="lastsubCategory depth3_subbox" id="lastsubCategory_${categoryVO.cate_code }">
                                           <li>
                                           </li>
                                        </ul>
                                    </div>
                                </div>
                                  </li>
                       </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </header>
 <script>
   $(function(){
     
     //1차 카테고리메뉴 클릭시
     $(".nav-item a.nav-link").on("click", function(){
      console.log("1차 카테고리메뉴");
      
      //let urlacpt = $(this).attr("href") + 44444;
      let url = "/product/subCategory/" + $(this).attr("href");
        console.log("2차 :"+url);
      let curAnchor = $(this); // ajax메서드 호출전에 선택자 this를 전역변수로 받아야 한다.

        

         $.getJSON(url, function(data){
         
         // 2차카테고리 정보를 모두 삭제해라.(기존제거)
         $(".depth2_subbox").each(function(){
            
           $(this).empty();
         });
         $(".depth3_subbox").each(function(){
             
             $(this).empty();
           });


           //subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate"));
         let subCategoryStr = "";
         for(let i=0; i<data.length; i++) {
            //data[i].cate_code;
            //data[i].cate_name;
            let selector = "#subCategory_" + data[i].cate_prtcode;
            console.log(data[i].cate_prtcode);
                console.log(selector);
            //selector.css("display", "inline");
            //console.log("선택자: " + selector)
            //$(selector).empty();
                plusUrl = "/";
                subCategoryStr = "<a class='sub_cate' href=" + data[i].cate_prtcode + plusUrl + data[i].cate_code +">" + data[i].cate_name + "</a>";
                console.log(subCategoryStr);
                console.log("데이타개수"+data.length);
            $(selector).append(subCategoryStr);
                //let subCate_href = new Array();
                //subCate_href[i] = data[i].cate_prtcode + plusUrl + data[i].cate_code;
          }
         
            //let subCate = $(this).children(".sub_cate");
            
            
                // $(subCate).on("click", function(){
                // let url = $(this).attr("href");
                // console.log(url);
                //         return false;
                // });
            
            

            //console.log(data);
        });
      
    });
         /*
         curAnchor.next().empty();
         curAnchor.next().append(subCategoryStr);
         */
         
         
//-------------------------------------------------------------------------------------------------------------------------
        
//2차 카테고리메뉴 클릭시
$(document).on("click", ".sub_cate", function(e){
   e.preventDefault();
    
    //let rew_score = $(this).parent().parent().find("[name='rew_score']").val();
    //let pro_price = $(this).parent().parent().find("td span.pro_price").text();
    console.log(this);
    
  console.log("2차 카테고리메뉴");
    console.log($(this).length);
  
   let urlacpt = $(this).attr("href");
    console.log(urlacpt);
 let url = "/product/lastsubCategory/" + urlacpt;
    console.log(url);
 let curAnchor = $(this); // ajax메서드 호출전에 선택자 this를 전역변수로 받아야 한다.

 
    $.getJSON(url, function(data){

        console.log("after : " + "/product/lastsubCategory/" + urlacpt);
       
       //console.log(data);
    //$(this).parent().parent().find("[name='rew_score']").val()
        //let curAnchorUnder = curAnchor.parent().parent().parent().find('ul.depth3');
    // 3차카테고리 정보를 모두 삭제해라.(기존제거)
    $(".depth3_subbox").each(function(){
       
      $(this).empty();
    });


      //subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate"));
    
    let lastsubCategoryStr = "";
       for(let i=0; i<data.length; i++) {
          //data[i].cate_code;
          //data[i].cate_name;
          let selector = "#lastsubCategory_" + data[i].cate_prtcode;
          //selector.css("display", "inline");
          console.log("선택자: " + selector)
          //$(selector).empty();
              plusUrl = "/";
          lastsubCategoryStr = "<a class='lastsub_cate' href='" + data[i].cate_prtcode + plusUrl + data[i].cate_code + plusUrl + data[i].cate_subprtcode +"'>" + data[i].cate_name + "</a>";
          $(selector).append(lastsubCategoryStr);
          console.log("선택자:2 " + lastsubCategoryStr)
        }

    });
    
    /*
    curAnchor.next().empty();
    curAnchor.next().append(subCategoryStr);
    */

  
   //-------------------------------------------------------------------------------------------------------------------------
   //마지막 카테고리 클릭시
            //$(".depth3 ul").on("click", "a.lastsub_cate", function(e){
              //  e.preventDefault();

                //console.log("2차카테고리 클릭");
                //location.href = "/product/productList?cate_prtcode=" + $(this).attr("href");
               //});
    //-------------------------------------------------------------------------------------------------------------------------

});
         
  


});



</script>
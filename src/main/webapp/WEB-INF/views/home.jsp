<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>COOING</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" type="image/png" href="resources/assets/images/cooing_logo.png"/>
<link rel="stylesheet" href="resources/css/jquery-ui.min.css">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/css/icomoon.css">
<link rel="stylesheet" href="resources/css/animate.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/chat.css">
<link rel="stylesheet" href="resources/css/green.css">  
<link rel="stylesheet" href="resources/css/home.css">
<!-- 탭메뉴 -->
<link rel="stylesheet" href="resources/css/tab.css">
<link rel="stylesheet" href="resources/css/push.css">

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/home.js"></script>
<script src="resources/js/search.js"></script>
<script src="resources/js/chat.js"></script>
<script src="resources/js/icheck.js"></script> 
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>
<script src="resources/js/popper.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/owl.carousel.min.js"></script>
<script src="resources/js/jquery.waypoints.min.js"></script>
<script src="resources/js/imagesloaded.pkgd.min.js"></script>
<script src="resources/js/main.js"></script>
<script src="resources/js/popup.js"></script>

<!-- 탭나누는 사이드바 -->
<link rel="stylesheet" type="text/css" href="resources/album_create/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/album_create/css/main.css">
<link rel="stylesheet" href="resources/css/albumEdit.css">
<script type="text/javascript" src="resources/js/albumEdit.js"></script>

<script type="text/javascript" src="resources/js_js/html2canvas.min.js"></script>
<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Gothic+A1" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">

<!-- 채팅목록 -->
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
<script src="https://use.fontawesome.com/1c6f725ec5.js"></script>

<script>
var page = 0;
var pagingcheck = false;
var total = true;
//이게 0번이면 검색어 1번이면 카테고리 2번이면 그냥 메인 으로 나눠서 페이징 가지고 오게 된다.
var searchcheck = 99;
$(window).scroll(function() {
    if (pagingcheck == false && ($(window).scrollTop() + 100) >= $(document).height() - $(window).height()) {
    	//메인으로 그냥 들어왔을 때 와 검색해서 들어왔을 때 = 0 / 카테고리 눌러서 들어왔을 때  = 1 
    	if(searchcheck == 0){
    		if(total){	
    			get_album_list('writer' , 'total', 'date', ++pagenum , 0);
        		pagingcheck = true;
        	}
    	}else if(searchcheck == 1){
    		if(total){	
    			get_album_list('category','total','date',++pagenum , 1);
        		pagingcheck = true;
        	}
    	}   	
    }
});

$(document).ready(function () {
	
	initialize();	
	
	if(${search != null}){
		$('#searchtx').val('${search}');
		$('#searchtx').css('width' , '200px');
		$('#searchtx').css('paddingLeft' , '3px');
		$('#searchtx').focus();
	}
	
	//1번이면 카테고리 눌러서 넘어온 경우 , 엘스는 그냥 홈에 온 경우 혹은 검색으로 온 경우 
	if('${search_other}' == 1){
		searchcheck = 99;
		pagenum = 0;
		pagingcheck = false;
		get_album_list('category','total','date',++pagenum , 1);
	}else{
		searchcheck = 99;
		pagenum = 0;
		pagingcheck = false;
		// 전체 앨범, 검색 키워드 없음, 최신 순
		get_album_list('writer' ,'total', 'date', ++pagenum , 0);
	}
	
	//경고!! 아래 코드를 절대 별도의 js파일로  마시오!!
	if ('${sessionScope.Member}' != null) {
		readyChat('${sessionScope.Member.member_id}', '');
	}
});
</script>

<!-- 정렬순 라디오버튼 -->
<script>
$(document).ready(function(){
  $('.input').iCheck({
    checkboxClass: 'icheckbox_square-green',
    radioClass: 'iradio_square-green',
    increaseArea: '20%' // optional
  });
});
</script>

 <script>
  window.console = window.console || function(t) {};
</script>  
  
  <script>
  if (document.location.search.match(/type=embed/gi)) {
    window.parent.postMessage("resize", "*");
  }
</script>
</head>
<body style ="font-family: 'Nanum Gothic Coding', monospace;">

	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">

			<a href="/www" class="mb-2 d-block probootstrap-logo" style = "font-size: 30px;">COOING</a>

			<!-- 로그인되어있을 때 -->
			<c:if test="${Member ne null}">
				<p>
					<img src="<c:url value="/img_member" />" class="img1">${Member.getMember_id()}
				</p>
			</c:if>
			<!-- 로그인 안되어있을 때 -->
			<c:if test="${Member eq null}">
				<p>
					<img src="http://1.bp.blogspot.com/-t9dmAueNbW0/VQYvJX7kVrI/AAAAAAAAGYY/Ou05G2Vi2kw/s1600/1%2B(3).jpg">ID
				</p>
			</c:if>

		</div>
		<div class="probootstrap-overflow">
			<nav class="probootstrap-nav">				
				<ul>					
					<li><a href="<c:url value ="/"/>">HOME</a></li>
					<li><a href="<c:url value ="/myPage"/>">MYPAGE</a></li>	
					<li><a href="<c:url value ="/LankingPage"/>">TODAY'S RANKING</a></li>			
				</ul>
				<p class ="c">CATEGORY</p>
				<ul>					
					<li><a href="<c:url value ="/logout_get"/>">LOGOUT</a></li>
				</ul>
			</nav>					
		</div>
	</aside>


	<main role="main" class="probootstrap-main js-probootstrap-main">
	<div class="probootstrap-bar">
		<a href="#" class="probootstrap-toggle js-probootstrap-toggle">
			<span class="oi oi-menu"></span>
		</a>
		<div class="probootstrap-main-site-logo">
			<a href="/www">COOING</a>
		</div>
		<a href="#" class="probootstrap-toggle2 js-probootstrap-toggle2">
			<span class="oi oi-menu"></span>
		</a>	
	</div>
	
	<div class ="search-bar">
		<br><br>
		<div align="margin-left: 20px; "style = "font-size: 20px;">
				 <!-- src="resources/img/ico/seo-1970475_960_720.png" -->
       			 SEARCH &nbsp<img id="image_search" src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png" style="width: 24px;
       			 height: 24px;margin-right: 5px;" onclick="inputbox_focus()">
     			 <input id="searchtx" type="text" onblur="search_bar(this)" style="  border: none;
              	 background-color: rgba(0,0,0,0);
              	 color: #666666;
               	 border-bottom: solid 2px #333;
               	 outline: none;
              	  width: 0px;
               	 transition: all 0.5s;
               	 padding-right:0px;
               	 padding-left:0px;"               	 
               	 >  		
			
			<!-- 정렬순서 -->		
			<form style = "float:right; padding-left : 10px; font-size: 20px;">
				<input type="radio" id="newcheck" name="iCheck" class = "input" value="1" checked>NEW
				<input type="radio" name="iCheck" class = "input" value="2" >POPULAR				
				<input type="radio" name="iCheck" class = "input" value="3" >MYLIKE
			</form>
			<input type="hidden" id="categorynum" value="${categorynum}">
		</div>
	</div>
	<br>
	
	<!-- 앨범 리스트 -->
	<div class="card-columns" id="card-columns">
			
<!-- 		<div class="card">
			<a href="single.html" id="test1">
				<img class="card-img-top probootstrap-animate" 
				src="resources/aside_images/img_1.jpg" alt="Card image cap">
			</a>
		</div>
		<div class="card">
			<a href="single.html" id="test2">
				<img class="card-img-top probootstrap-animate" 
				src="resources/image_mj/a1.jpg" alt="Card image cap">
			</a>
		</div> -->
	</div>
	
	<div class="container-fluid d-md-none">
		<div class="row">
			<div class="col-md-12">
				<p>&copy; 2018 <a href="https://uicookies.com/" target="_blank">uiCookies:Aside</a>.
					<br> All Rights Reserved. Designed by 
					<a href="https://uicookies.com/" target="_blank">uicookies.com</a>
				</p>
			</div>
		</div>
	</div>
	</main>

	
	<aside class="probootstrap-aside2 js-probootstrap-aside2">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
		
			<span class="oi oi-arrow-right"></span> Close
		</a>
		
		<div class="probootstrap-overflow">
		<div id="main">
		<input class = "input1" id="tab1" type="radio" name="tabs" checked> <!--디폴트 메뉴-->
		<label for="tab1" style = "font-size: 13px;">FRIEND</label>

  		<input class = "input1" id="tab2" type="radio" name="tabs">
    	<label for="tab2" style = "font-size: 13px;">GROUP</label>   
    	
    	<input class = "input1" id="tab3" type="radio" name="tabs">
    	<label for="tab3" style = "font-size: 13px;">NEWS</label>   

    	<section id="content1"> 
    	<!-- 페이지 저장 -->		
			<form class="contact100-form validate-form" id="entry">
				<span class="contact100-form-title">
					&nbsp<input type="text" placeholder="친구검색" id="friendsearch" class = "search1" style ="font-size: 14px; width:100%;" >					
				</span>
			</form>		
				
				<div class = "friendList" style = "width: 200px;">
					<div name="friend" id="friend"></div>
					<div name="user" id="user"></div>
				</div>			

	<div id="dropDownSelect1"></div>    	    
    <form id="testimg">
		<input type="hidden" name="imgSrc" id="imgSrc" />
	</form>	   
    </section>	
   	
   	<section id ="content2">       					
		<div class="button_container">		
			<button class="btn"onclick="window.open('./groupcreate_get?','','width=500 height=1000 left=50% top=50% fullscreen=no,scrollbars=no,location=no,resizeable=no,toolbar=no')"><span>GROUP CREATE</span></button>
		</div>				
		
		<div class = "groupList" id="group" style= "margin-top: 70px; width: 200px;"></div>
	</section>   	
	
	<!-- 영준이 알림공간 -->
	<section id ="content3" class="content3">       					
		<div class = "div_news" id="div_news">
			<div class="msg_box" id="msg_box">
				<div class="msg_title">메세지</div>
				<div class="msg_list" id="msg_list"></div>
			</div>
			<div class="invite_box" id="invite_box">
				<div class="invite_title">초대</div>
				<div class="invite_list" id="invite_list"></div>
			</div>
		</div>
	</section>   
  
	</aside>
	
</body>
</html>
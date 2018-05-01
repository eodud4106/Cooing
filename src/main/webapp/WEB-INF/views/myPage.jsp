<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>My Page</title>
<meta charset="utf-8" />
<link rel="icon" type="image/png" href="resources/assets/images/cooing_logo.png"/>
<script src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
<!-- 폰트 -->
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
<!-- 버튼 -->
<link rel="stylesheet" href="resources/button_css/style.css">
<!-- 탭메뉴 -->
<link rel="stylesheet" href="resources/css/tab.css">
<!-- 탭나누는 사이드바 -->
<link rel="stylesheet" type="text/css" href="resources/album_create/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/album_create/css/main.css">

<link rel="stylesheet" href="<c:url value="/resources/css/myPage.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/open-iconic-bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.carousel.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.theme.default.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/icomoon.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/animate.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/style.css"/>">
<link rel="stylesheet" href="resources/css/chat.css">
<link rel="stylesheet" href="resources/css/push.css">

<script src="<c:url value="/resources/aside_js/popper.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/owl.carousel.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/jquery.waypoints.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/imagesloaded.pkgd.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/main.js"/>"></script>
<script src="resources/js/popup.js"></script>
<script src="resources/js/chat.js"></script>
<script src="resources/js/push.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="<c:url value="/resources/js/search.js"/>"></script>
<script src="<c:url value="/resources/js/mypage.js"/>"></script>
<!-- 라디오버튼 -->
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>


<!-- 아마 드래그앤 드롭 css인듯 31일에도 별다른 에러 없으면 보는 사람이 지워주세요 -->  
<!--<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">-->
<style>
#image_search {
	cursor: pointer;
}
.dropbtn {
    background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropdown {
    position: relative;
    display: inline-block;    
}

.dropdown-content {
    display: none;
    position: absolute;    
    background-color: #f9f9f9;
    min-width: 160px;
    height : 200px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    overflow-y: scroll;
    padding-bottom: 1px;
}

.dropdown-content li {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content li:hover {
	background: -webkit-linear-gradient(right, #00dbde, #499ce8);
	color : white;
}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown:hover .dropbtn {
    background-color: #3e8e41;
}
</style>




<script>

var pagenum = 0;
var pagingcheck = false;
//0번이면 검색 1번 이면 카테고리 
var searchcheck = 99; 
var total = true;
$(window).scroll(function() {
    if (pagingcheck == false && ($(window).scrollTop() + 100) >= $(document).height() - $(window).height()) {
    	if(searchcheck == 0){
	    	if(total){
	    		get_album_list('writer','personal', 'date', ++pagenum , 0);
		    	pagingcheck = true;
	    	}
    	}else if(searchcheck == 1){
    		if(total){	
    			get_album_list('category','personal', 'date', ++pagenum , 1);
    			pagingcheck = true;
    		}
    	}
    }
});

$(document).ready(function () {
	//경고!! 아래 코드를 절대 별도의 js파일로  마시오!!
	if ('${sessionScope.Member}' != null) {
		readyChat('${sessionScope.Member.member_id}', '');
		readyPush('${sessionScope.Member.member_id}', '');
	}
	initialize();
});
</script>

</head >
<body style ="font-family: 'Nanum Gothic Coding', monospace;">

	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">

			<a href="/www" class="mb-2 d-block probootstrap-logo">COOING</a>

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
					<li><a href="<c:url value ="/bookmark"/>">BOOKMARK</a></li>					
				</ul>
				<div class = "dropdown">
						<p class ="c" class = "dropbtn">CATEGORY</p>
						 <div class="dropdown-content">
						 <ul>
						  	<li class="category" data="0">여행</li>
						    <li class="category" data="1">스포츠/레저</li>
						    <li class="category" data="2">동물</li>
						    <li class="category" data="3">음악</li>
						    <li class="category" data="4">요리/음식</li>
						    <li class="category" data="5">패션/뷰티</li>
						    <li class="category" data="6">연예/TV</li>
						    <li class="category" data="7">게임</li>
						    <li class="category" data="8">영화</li>
						    <li class="category" data="9">도서</li>
						    <li class="category" data="10">공연/전시</li>
						    <li class="category" data="11">외국어</li>
						    <li class="category" data="12">전문지식</li>
						    <li class="category" data="13">수집/제작</li>
						    <li class="category" data="14">자기계발</li>
						    <li class="category" data="15">육아</li>
						    <li class="category" data="16">일상생활</li>
						    <li class="category" data="17">자동차</li>
						    <li class="category" data="18">낚시</li>
						    <li class="category" data="19">건강</li>
						    <li class="category" data="20">기타</li>
						    </ul>
					    </div>
					</div>
				<ul>
					<li><a href="<c:url value =""/>">MY ACCOUNT</a></li>
					<li><a href="<c:url value ="/logout_get"/>">LOGOUT</a></li>
				</ul>
			</nav>
		</div>
		<!-- <li><a href="javascript:create_personal_album()">앨범 만들기</a></li> -->
		<button class = "button" style = "margin :auto;"onclick="javascript:create_personal_album()">
			Album Create
			<div class="button__horizontal"></div>
			<div class="button__vertical"></div>
		</button>			
	</aside>


	<main role="main" class="probootstrap-main js-probootstrap-main">
	<div class="probootstrap-bar">
		<a href="#" class="probootstrap-toggle js-probootstrap-toggle">
			<span class="oi oi-menu"></span>
		</a>
		<div class="probootstrap-main-site-logo">
			<a href="index.html">COOING</a>
		</div>
		<a href="#" class="probootstrap-toggle2 js-probootstrap-toggle2">
			<span class="oi oi-menu"></span>
		</a>	
	
	</div>	
	
	<div class ="search-bar">
		<br><br>
		<div style = "margin-left: 20px; font-size: 20px;">
       			 SEARCH &nbsp<img id='image_search' src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png" style="width: 24px;
       			 height: 24px;margin-right: 5px;" onclick="inputbox_focus()">
     			 <input id="searchtx" type="text" onblur="search_bar(this)" style="  border: none;
              	 background-color: rgba(0,0,0,0);
              	 color: #666666;
               	 border-bottom: solid 2px #333;
               	 outline: none;
              	  width: 0px;
               	 transition: all 0.5s;
               	 padding-right:0px;
               	 padding-left:0px;">		
				
		</div>
		<input type="hidden" id="categorynum">
		<br>	
	</div>
			
	
	
	
	<!-- 앨범 리스트 -->
	<!-- <div class="card-columns" id="card-columns">
	
		<div class="card">
			<a href="single.html" >			
				<img class="card-img-top probootstrap-animate" 
				src="resources/aside_images/img_1.jpg" alt="Card image cap">
			</a>
			
		</div>
		<div class="card">
			<a href="single.html">
				<img class="card-img-top probootstrap-animate" 
				src="resources/image_mj/a1.jpg" alt="Card image cap">
				
			</a>
		</div>
	</div> -->
	
	<div class="card-columns" id="card-columns">				
	</div>	

	<div class="container-fluid d-md-none">
		<div class="row">
			<div class="col-md-12">
				
				<p>
					&copy; 2018 <a href="https://uicookies.com/" target="_blank">uiCookies:Aside</a>.
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
       
    	</section>
	<form id="testimg">
		<input type="hidden" name="imgSrc" id="imgSrc" />
	</form>	
   	
   	<section id ="content2">       					
		<div class="button_container">		
			<button class="btn"onclick="window.open('./groupcreate_get?','','width=500 height=1000 left=50% top=50% fullscreen=no,scrollbars=no,location=no,resizeable=no,toolbar=no')"><span>GROUP CREATE</span></button></div>
		
		<div class = "groupList" id="group" style= "margin-top: 70px; width: 200px;">
		</div>
	</section>   
	<!-- 영준이 알림공간 -->
	<section id ="content3" class="content3">       					
		<div class = "div_news" id="div_news" style = "text-align :center;  font-size: 14px;">
			<div class="msg_box" id="msg_box">
				<div class="msg_title">MESSAGE</div>
				<div class="msg_list" id="msg_list"></div>
			</div>
			<div class="invite_box" id="invite_box">
				<div class="invite_title">INVITE</div>
				<div class="invite_list" id="invite_list"></div>
			</div>
		</div>
	</section> 
   
</aside>

<script src="<c:url value="/resources/aside_js/popper.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/owl.carousel.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/jquery.waypoints.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/imagesloaded.pkgd.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/main.js"/>"></script>


</body>
</html>
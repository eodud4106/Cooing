<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>friendPage</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" type="image/png" href="resources/assets/images/cooing_logo.png"/>
<!-- 탭메뉴 -->
<link rel="stylesheet" href="resources/css/tab.css">
<link rel="stylesheet" href="resources/aside_css/bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/aside_css/icomoon.css">
<link rel="stylesheet" href="resources/aside_css/animate.css">
<link rel="stylesheet" href="resources/aside_css/style.css">
<link rel="stylesheet" href="resources/css/chat.css">
<link rel="stylesheet" href="resources/css/push.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- 앨범 정보 띄우는 부분  -->
<link rel="stylesheet" href="resources/css/search.css">

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>

<script src="<c:url value="/resources/js/friend.js"/>"></script>
<script src="<c:url value="/resources/js/search.js"/>"></script>
<script src="resources/js/popup.js"></script>
<script src="resources/js/chat.js"></script>
<script src="resources/js/push.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>
<script>

var pagenum = 0;
var pagingcheck = false;
var total = true;
//0번이면 검색 1번 이면 카테고리 
var searchcheck = 99; 
$(window).scroll(function() {
    if (pagingcheck == false && ($(window).scrollTop() + 100) >= $(document).height() - $(window).height()) {
    	if(searchcheck == 0){
	    	if(total){
	    		get_friend_album_list('writer','friend','date', pagenum++ , 0);
	    		pagingcheck = true;
	    	}
    	}else if(searchcheck == 1){
    		if(total){
    			get_friend_album_list('category','friend','date', pagenum++ , 1);
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
	get_friend_album_list('writer','friend','date', pagenum++ , 0);
});
</script>

<style>
#image_search {
	cursor: pointer;
}
.img1 {
	width: 50px;
	height: 50px;
}

@media screen and (max-width: 768px) {
	.probootstrap-main .search-bar {
		width: 100%;
		padding: 30px 15px;
		padding-top: 30px;
		padding-bottom: 30px;
	}
}

select {
	width: 100px;
	font-family: inherit;
	background:
		url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg)
		no-repeat 95% 50%;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #999;
	border-radius: 0px;
}

select::-ms-expand { /* for IE 11 */
	display: none;
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

</head>
<body style ="font-family: 'Nanum Gothic Coding', monospace;">

	<aside class="probootstrap-aside js-probootstrap-aside" style = "background-color: aliceblue;">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate"
			data-animate-effect="fadeInLeft">
			<a href="./" class="mb-2 d-block probootstrap-logo">COOING</a>
			
			<p id="friendid">
				<img class ="img1"
					src="<c:url value="/memberimg?strurl=${friend_id.getMember_picture()}"/>"> ${friend_id.getMember_id()}
			</p>
			
			<p>
				<c:if test="${check ne true }">
					<div style="z-index: 99; float: right; margin-top: -40px; cursor: pointer;"
						id="friendbt" data="0">
						<i class="fas fa-user-plus"></i>
					</div>					
				</c:if>
				<c:if test="${check eq true }">					
					<div style="z-index: 99; float: right; margin-top: -40px; cursor: pointer;"
						id="friendbt" data="1">
						<i class="fas fa-user-times"></i>
					</div>
				</c:if>
				<input type="hidden" value="${friend_id.getMember_id()}"
					id="friendidval">
			</p>
		</div>

			<div class="probootstrap-overflow">
				<nav class="probootstrap-nav">
					<ul>
						<li><a href="<c:url value ="/"/>">HOME</a></li>
						<li><a href="<c:url value ="/myPage"/>">MY PAGE</a></li>
						<li><a href="<c:url value ="/LankingPage"/>">TODAY'S RANKING</a></li>						
					</ul>
					<div class = "dropdown">
						<p class ="c" class = "dropbtn" style="cursor: pointer;">CATEGORY</p>
						 <div class="dropdown-content" style = "font-family: Poppins-Regular; font-size: 15px; padding-left: 10px;">
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
						<li><a href="<c:url value ="/logout_get"/>">LOGOUT</a></li>						
					</ul>					
				</nav>
				<footer class="probootstrap-aside-footer probootstrap-animate" data-animate-effect="fadeInLeft" 
				style = "font-family: Poppins-Regular;">          
         		 <p>&copy; 2018 <a href="cooing.site/www" target="_blank">COOING</a>. <br> All Rights Reserved.</p>
       			 </footer>	
			</div>			
	</aside>


	<main role="main" class="probootstrap-main js-probootstrap-main">
	<div class="probootstrap-bar">
		<a href="#" class="probootstrap-toggle js-probootstrap-toggle"> <span
			class="oi oi-menu"></span>
		</a>
		<div class="probootstrap-main-site-logo">
			<a href="index.html">COOING</a>
		</div>
		<a href="#" class="probootstrap-toggle2 js-probootstrap-toggle2">
			<span class="oi oi-menu"></span>
		</a>

	</div>

	<div class="search-bar">
		<br>
		<br>
		<div style = "margin-left: 20px; font-size: 20px;">
			SEARCH &nbsp<img id='image_search'
				src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png"
				style="width: 24px; height: 24px; margin-right: 5px;"
				onclick="inputbox_focus()">
			<input id='searchtx' type="text"
				onblur="search_bar(this)"			
                style="border: none; background-color: rgba(0, 0, 0, 0); color: #666666; border-bottom: solid 2px #333; outline: none; width: 0px; transition: all 0.5s;padding-right:0px;padding-left:0px;">

		</div>
		<input type="hidden" id="totalpage" value="${totalpage }"> <br>
		<input type="hidden" id="categorynum">
	</div>



	<!-- 앨범 리스트 -->
	<div class="card-columns" id="card-columns" style="cursor: pointer;">

		<!--  -->
		<div class="card">
			<a href="single.html"> <img
				class="card-img-top probootstrap-animate"
				src="resources/aside_images/img_1.jpg" alt="Card image cap">
			</a>

		</div>
		<div class="card">
			<a href="single.html"> <img
				class="card-img-top probootstrap-animate"
				src="resources/image_mj/a1.jpg" alt="Card image cap">

			</a>
		</div>
	</div>


	<div class="container-fluid d-md-none">
		<div class="row">
			<div class="col-md-12">

				<p>
					&copy; 2018 <a href="https://uicookies.com/" target="_blank">COOING</a>.
					<br> All Rights Reserved. Designed by <a
						href="https://uicookies.com/" target="_blank">COOING</a>
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
					&nbsp<input type="text" placeholder="친구 찾기" id="friendsearch" class = "search1" style ="font-size: 14px; width:100%;" >					
				</span>
			</form>						
				<div class = "friendList" style = "width: 200px; margin-top: 20px;">
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
	<input style="display: none" id="user_id" value="${sessionScope.Member.member_id }">

	<script src="resources/aside_js/popper.min.js"></script>
	<script src="resources/aside_js/bootstrap.min.js"></script>
	<script src="resources/aside_js/owl.carousel.min.js"></script>
	<script src="resources/aside_js/jquery.waypoints.min.js"></script>
	<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>
	<script src="resources/aside_js/main.js"></script>
</body>
</html>
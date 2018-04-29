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


<script src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
<!-- 폰트 -->
<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<!-- <link href="https://fonts.googleapis.com/css?family=McLaren" rel="stylesheet"> -->
<!-- 친구 그룹목록 출력-->
<link rel="stylesheet" href="resources/css/friend_list.css">

 <link rel="stylesheet" href="<c:url value="/resources/css/myPage.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/open-iconic-bootstrap.min.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.carousel.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.theme.default.min.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/icomoon.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/animate.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/style.css"/>">


<script src="<c:url value="/resources/aside_js/popper.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/owl.carousel.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/jquery.waypoints.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/imagesloaded.pkgd.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/main.js"/>"></script>

<link rel="stylesheet" href="resources/skin_radio/green.css">
<script src="resources/skin_radio/icheck.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- 라디오버튼 -->
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>

<script src="resources/js/jquery-ui.min.js"></script>
<script src="<c:url value="/resources/js/search.js"/>"></script>
<script src="<c:url value="/resources/js/mypage.js"/>"></script>

<script>

var pagenum = 0;
var pagingcheck = false;
$(window).scroll(function() {
    if (pagingcheck == false && ($(window).scrollTop() + 100) >= $(document).height() - $(window).height()) {
    	if($('#totalpage').val() >= pagenum){
    		getMyAlbumList();
	    	pagingcheck = true;
    	}
    }
});

$(document).ready(function () {
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
				<p>MYPAGE</p>
				<p>오늘의 랭킹</p>
				<p></p>
				<p>CATEGORY</p>
				<ul>

					<li class="category" data="0">여행</li>
					<li class="category" data="1">음식</li>
					<li><a href="<c:url value ="/"/>">MainPage</a></li>
					<li><a href="<c:url value ="/myPage"/>">myPage</a></li>
					<li><a href="<c:url value ="/bookmark"/>">bookmark</a></li>
					<li><a href="<c:url value ="/logout_get"/>">로그아웃</a></li>
					<li><a href="javascript:create_personal_album()">앨범 만들기</a></li>
					
				</ul>
			
			</nav>
			<br><br><br>

		</div>
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
		<div style = "margin-left: 20px;">
       			 SEARCH &nbsp<img id='image_search' src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png" style="width: 24px;
       			 height: 24px;margin-right: 5px;" onclick="inputbox_focus()">
     			 <input id="searchtx" type="text" onblur="search_bar(this)" style="  border: none;
              	 background-color: rgba(0,0,0,0);
              	 color: #666666;
               	 border-bottom: solid 2px #333;
               	 outline: none;
              	  width: 0px;
               	 transition: all 0.5s;">		
				
		</div>
		<input type="hidden" id="totalpage" value="${totalpage }">
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
			<div class="card">
			<ul>
				<li><div class="inner"><a href="single.html" ><p><strong>출력고고?</strong>ㅇㅁㄹㄴㅇㄹㅇㄴ</p></a>	
				<img class="card-img-top probootstrap-animate" 
				src="resources/aside_images/img_1.jpg" alt="Card image cap"/>						
				</div></li>		
			</ul></div>
			
			<div class="card">
				<ul><li><div class="inner"><a href="single.html"><p><strong>출력고고?dsf2</strong>ㅇㅁㄹㄴㅇㄹㅇㄴ</p></a>	
				<img class="card-img-top probootstrap-animate" 
				src="resources/image_mj/a1.jpg" alt="Card image cap"/>
				</div></li>
			</ul></div>
			
			<div class="card">
				<ul><li><div class="inner"><a href="single.html"><p><strong>출력고고?dsf2</strong>ㅇㅁㄹㄴㅇㄹㅇㄴ</p></a>	
				<img class="card-img-top probootstrap-animate" 
				src="resources/image_mj/a2.jpg" alt="Card image cap"/>
				</div></li>
			</ul></div>		
			
			<div class="card">
				<ul><li><div class="inner"><a href="single.html"><p><strong>출력고고?dsf2</strong>ㅇㅁㄹㄴㅇㄹㅇㄴ</p></a>	
				<img class="card-img-top probootstrap-animate" 
				src="resources/image_mj/a3.jpg" alt="Card image cap"/>
				</div></li>
			</ul></div>	
			
			<div class="card">
				<ul><li><div class="inner"><a href="single.html"><p><strong>출력고고?dsf2</strong>ㅇㅁㄹㄴㅇㄹㅇㄴ</p></a>	
				<img class="card-img-top probootstrap-animate" 
				src="resources/image_mj/a4.jpg" alt="Card image cap"/>
				</div></li>
			</ul></div>					
	</div>
	
	
	
	
	

	<div class="container-fluid d-md-none">
		<div class="row">
			<div class="col-md-12">
				
				<p>
					&copy; 2018 <a href="https://uicookies.com/" target="_blank">uiCookies:Aside</a>.
					<br> All Rights Reserved. Designed by <a
						href="https://uicookies.com/" target="_blank">uicookies.com</a>
				</p>
			</div>
		</div>
	</div>

	</main>


	
	<aside class="probootstrap-aside2 js-probootstrap-aside2">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-right"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="" class="mb-2 d-block probootstrap-logo" style = "text-align: center;">MY FRIEND</a>			
		</div>				
				 <form>
					&nbsp<input type="text" placeholder="친구검색" id="friendsearch" >
					<div>
       			  <img id="image_search" src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png" style="width: 24px;
       			 height: 24px;margin-left: 215px; margin-top: -50px;">
				</form>
			<div class = "friendList">
				<div name="friend" id="friend">
				</div>
				<div name="user" id="user">
				</div>
			</div>
		
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="" class="mb-2 d-block probootstrap-logo" style = "text-align: center;">MY GROUP</a>				
						
		<!-- <div class="probootstrap-overflow"> -->
		
		<!-- 그룹생성 -->
		<div class="button_container">		
		<button class="btn"onclick="window.open('./groupcreate_get?','','width=500 height=1000 left=50% top=50% fullscreen=no,scrollbars=no,location=no,resizeable=no,toolbar=no')"><span>GROUP CREATE</span></button></div>
		</div>
			<div class = "groupList">
				<c:if test="${Member ne null}">
					<c:if test="${fn:length(group) ne 0}">
						<c:forEach var="party" items="${group}">
							<div name="group">
								<p class="arr_party" partynum="${party.party_num}">${party.party_name}</p>
							</div>
						</c:forEach>
					</c:if>
				</c:if>				
			<!-- </div> -->
		</div>

	</aside>

	<script src="resources/aside_js/popper.min.js"></script>
	<script src="resources/aside_js/bootstrap.min.js"></script>
	<script src="resources/aside_js/owl.carousel.min.js"></script>
	<script src="resources/aside_js/jquery.waypoints.min.js"></script>
	<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>

	<script src="resources/aside_js/main.js"></script>
</body>
</html>
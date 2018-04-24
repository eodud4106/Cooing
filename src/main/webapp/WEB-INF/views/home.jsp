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
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Work+Sans">

<link rel="stylesheet" href="resources/aside_css/bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/open-iconic-bootstrap.min.css">

<link rel="stylesheet" href="resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.theme.default.min.css">

<link rel="stylesheet" href="resources/aside_css/icomoon.css">
<link rel="stylesheet" href="resources/aside_css/animate.css">
<link rel="stylesheet" href="resources/aside_css/style.css">
<link rel="stylesheet" href="resources/css/chat.css">
<!-- 레이어 툴팁 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="<c:url value="/resources/js/home.js"/>"></script>
<script src="<c:url value="/resources/js/search.js"/>"></script>
<script src="resources/js/chat.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>
<link rel="stylesheet" href="resources/skin_radio/green.css">
<script src="resources/skin_radio/icheck.js"></script>
<script>
var pagenum = 0;
var pagingcheck = false;
//이게 0번이면 검색어 1번이면 카테고리 2번이면 그냥 메인 으로 나눠서 페이징 가지고 오게 된다.
var searchcheck = 0;
var categorynum = 0;
$(window).scroll(function() {
    if (pagingcheck == false && ($(window).scrollTop() + 100) >= $(document).height() - $(window).height()) {
    	//메인으로 그냥 들어왔을 때 = 2 / 카테고리 눌러서 들어왔을 때  = 1 / 검색해서 들어왔을 때  = 0 
    	if(searchcheck == 2){
    		if($('#totalpage').val() >= pagenum){	
       			getTotalAlbumList();
        		pagingcheck = true;
        	}
    	}else if(searchcheck == 1){
    		if($('#totalpage').val() >= pagenum){	
    			searchCategory(categorynum);
        		pagingcheck = true;
        	}
    	}else if(searchcheck == 0){
    		if($('#totalpage').val() >= pagenum){	
       			search();
        		pagingcheck = true;
        	}
    	}    	
    }
});


$(document).ready(function () {
	
	initialize();	
	
	$('window').click(function(event) {
		if (event.target == $('#myModal')) {
			$('#myModal').css('display', 'none');
	    }
	});
	
	$(document).mouseup(function(e){
		var container=$('.popuplayer');
		if(container.has(e.target).length == 0)
			container.hide();
	});
	
	$('#myBtn').click(function() {
		$('#myModal').css('display', 'block');
	});
	
	$('#myBtn_close').click(function() {
		$('#myModal').css('display', 'none');
	});
	
	searchword();
	
	if (${sessionScope.Member != null}) {
		readyChat('${sessionScope.Member.member_id}', '');
	}	
	//0번이면 검색으로 넘어온 경우 ,  1번이면 카테고리 눌러서 넘어온 경우 , 엘스는 그냥 홈에 온 경우 
	if(${search_other == 0}){
		searchcheck = 0;
		pagenum = 0;
		pagecheck = false;
		$('#searchtx').val('${search}');
		search();
	}else if(${search_other == 1}){
		searchcheck = 1;
		pagenum = 0;
		pagecheck = false;
		searchCategory(${categorynum});
	}else{
		searchcheck = 2;
		pagenum = 0;
		pagecheck = false;
		getTotalAlbumList();		
	}
});


</script>

<!-- 정렬순 라디오버튼 -->
<script>
$(document).ready(function(){
  $('input').iCheck({
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
<style>
.button_container {
  position: absolute;
  left: 0;
  right: 0;
  top: 30%;
}



.btn {
  border: none;
  display: block; 
  text-align: center;
  cursor: pointer;
  text-transform: uppercase;
  outline: none;
  overflow: hidden;
  position: relative;
  color: #fff;
  font-weight: 700;
  font-size: 15px;
  background-color: #bae5e1;
  /* padding: 17px 60px; */
  margin: 0 auto;
  box-shadow: 0 5px 15px rgba(0,0,0,0.20);
}

.btn span {
  position: relative; 
  z-index: 1;
}

.btn:after {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  height: 490%;
  width: 140%;
  background: #78c7d2;
  -webkit-transition: all .5s ease-in-out;
  transition: all .5s ease-in-out;
  -webkit-transform: translateX(-98%) translateY(-25%) rotate(45deg);
  transform: translateX(-98%) translateY(-25%) rotate(45deg);
}

.btn:hover:after {
  -webkit-transform: translateX(-9%) translateY(-25%) rotate(45deg);
  transform: translateX(-9%) translateY(-25%) rotate(45deg);
}

.link {
  font-size: 20px;
  margin-top: 30px;
}

.link a {
  color: #000;
  font-size: 25px; 
}
.img1 {
	width: 50px;
	height: 50px;
}

.modal {
	display: none;
	position: absolute;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: none;
	background-color: rgba(0, 0, 0, 0.7);
}

.close {
	color: #aaa;
	float: left;
	font-size: 30px;
	font-weight: bold;
	position: fixed;
	right: 16;
	top: 0;
	background-color: #f0f0f0;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
.friendList{
	height: 250px;		
	/* overflow-y:hidden; */
}
.groupList{
	height: 250px;	
	/* overflow-y:hidden; */
}
/* 포인터로 마우스 모양 바꿔주는곳 */
.friendclick{
	cursor:pointer;
}
/* 팝업창 꾸미는 곳 */
.popuplayer{
	position:absoulute;
	display:none;
	background-color:#e0e0e0;
	border:solid 2px #d0d0d0.;
	width:120px;
	height:70px;
	padding:10px;
	
}

</style>
</head>
<body>

	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">

			<a href="/www" class="mb-2 d-block probootstrap-logo">COOING</a>

			<!-- 로그인되어있을 때 -->
			<c:if test="${Member ne null}">
				<p>
					<img src="<c:url value="/jinsu/img" />" class="img1">${Member.getMember_id()}
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
					
					<li><a href="<c:url value ="/"/>">MainPage</a></li>
					<li><a href="<c:url value ="/myPage"/>">myPage</a></li>	
					<li><a href="<c:url value ="/LankingPage"/>">LankingPage</a></li>				 		
					<li><a href="<c:url value ="/jinsu/member_get"/>">회원가입...</a></li>
					<li><a href="<c:url value ="/jinsu/login_get"/>">로그인...</a></li>
					<li><a href="<c:url value ="/jinsu/logout_get"/>">로그아웃</a></li>

				</ul>
			</nav>

		</div>
<!-- 
		<form>
			<div class="search">
				 테스트<br /> <input
					type="button" id="myBtn" value="모달 열기">
				<div id="myModal" class="modal">
					<span id="myBtn_close" class="close">&times;</span>
					<iframe src="albumView" allowTransparency='true' frameborder="0"
						width=100% height="100%"></iframe>
				</div>
			</div>
		</form> -->
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
		<div align="margin-left: 20px;">
       			 SEARCH &nbsp<img id="image_search" src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png" style="width: 24px;
       			 height: 24px;margin-right: 5px;" onclick="var inputBox = document.getElementById('searchtx');
       			 inputBox.style.width = '200px';
        		 inputBox.style.paddingLeft='3px';
       			 inputBox.value='';
       			 inputBox.focus();">
     			 <input id="searchtx" type="text" onblur="this.style.width='0px';
             	  this.style.paddingLeft='0px';" style="  border: none;
              	 background-color: rgba(0,0,0,0);
              	 color: #666666;
               	 border-bottom: solid 2px #333;
               	 outline: none;
              	  width: 0px;
               	 transition: all 0.5s;">
  		
			
		<!-- 정렬순서 -->		
		<form style = "float:right; padding-left : 10px;">
			<input type="radio" name="iCheck" class = "input"value="1" checked>최신순
			<input type="radio" name="iCheck" class = "input"value="2" >인기순			
			<div style= "z-index:99; float:right; " onClick="checkRadioButton('iCheck')"><i class="far fa-check-circle"></i></div>
		</form>
	</div>
		<br>	
	
	
	
	
	<!-- 앨범 리스트 -->
	<div class="card-columns" id="card-columns">
	
		<!--  -->
		<div class="card">
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
		</div>
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
			<a href="" class="mb-2 d-block probootstrap-logo">MY FRIEND</a>			
		</div>				
				 <form>
					&nbsp<input type="text" placeholder="친구검색" id="friendsearch" class="search1" >
					<div>
       			  <img id="image_search" src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png" style="width: 24px;
       			 height: 24px;margin-left: 205px; margin-top: -50px;">
				</form>
			<div class = "friendList">
				<div name="friend" id="friend">
				</div>
				<div name="user" id="user">
				</div>
			</div>
		
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="" class="mb-2 d-block probootstrap-logo" style = "margin-top: 100px;">MY GROUP</a>				
						
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
								<p onclick="openGUpdate('${party.party_name}')"
									partynum="${party.party_num}">${party.party_name}</p>
								<input type="button" value="채팅"
									onclick="openChat('0', '${party.party_num}', '${party.party_name}')" />
							</div>
						</c:forEach>
					</c:if>
				</c:if>				
			<!-- </div> -->
		</div>

	</aside>
	
	<div class="popuplayer">
		<p onClick="friendpage()" style="font-size:8pt;color:#26afa1;">친구페이지</p>
		<p onClick="chatpage()" style="font-size:8pt;color:#26afa1;">채팅</p>
	</div>

	<script src="resources/aside_js/popper.min.js"></script>
	<script src="resources/aside_js/bootstrap.min.js"></script>
	<script src="resources/aside_js/owl.carousel.min.js"></script>
	<script src="resources/aside_js/jquery.waypoints.min.js"></script>
	<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>

	<script src="resources/aside_js/main.js"></script>
</body>
</html>
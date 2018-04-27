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
<style>
.button_container {
  position: absolute;
  left: 0;
  right: 0;
 /*  top: 50%; */
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
.friendList{
	height: 250px;		
	overflow-y : scroll;
	padding-left: 30px;
	background-color : aliceblue;
	font-family: 'Gaegu', cursive;
    font-size: 18px;
    cursor: pointer;
}
.groupList{
	height: 250px;	
	overflow-y : scroll;
	padding-left: 30px;
	/* overflow-y:hidden; */
	background-color : aliceblue;
	font-family: 'Gaegu', cursive;
    font-size: 18px;
    cursor: pointer;
    margin-top: 50px;
}
</style>

<script src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Gaegu" rel="stylesheet">
 <link rel="stylesheet" href="<c:url value="/resources/css/myPage.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/open-iconic-bootstrap.min.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.carousel.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.theme.default.min.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/icomoon.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/animate.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/style.css"/>">

<!-- 앨범리스트 출력할 때 앨범사진위에 앨범 정보 출력하기 -->
<link rel="stylesheet" href="<c:url value="/resources/photoview_css/style.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/photoview_css/base.css"/>">

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
	
	$('#friendsearchbt').on('click', function() {
		searchfriend();
	});
	//초기 친구 찾을 때만 사용했었음
	$('#friendsearch').keyup(function() {
		searchword();
	});
	
	$('#searchbt').on('click' , function(){
		location.href = './search_other?search=' + $('#searchtx').val() + '';
	});
	
	$('.category').on('click' , function(){
		searchCategory($(this).attr('data'));
		location.href = './category_other?categorynum=' + $(this).attr('data') + '';
	});

	getMyAlbumList();
	
	$(document).mouseup(function(e){
		var container=$('.popuplayer');
		if(container.has(e.target).length == 0)
			container.hide();
	});
});

//앨범 리스트 Ajax로 받는 코드
function getMyAlbumList() {
	var check  = false;
	if(pagenum == 0)
		check  = true;
	$.ajax({
		url: 'getMyAlbumList',
		type: 'post',
		data:{pagenum:++pagenum},
		dataType: 'json',
		success: function(result) {
				AlbumListPaging(check , result);
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

/**
 * 앨범 생성
 */
function create_personal_album() {
	$.ajax({
		url: 'create_album',
		type: 'post',
		data: {
			isPersonal: 1
		},
		dataType: 'json',
		success: function(result) {
			if(result == 'user null') {
				alert('로그인 정보 없음!');
			} else if(result == 'fail') {
				alert('오류 발생!!');
			} else {
				 //TODO 앨범 편집창으로 이동
				 location.href="edit_album?album_num=" + result;
			}
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}
</script>
<!-- 정렬순 라디오 버튼 -->
<script>
$(document).ready(function(){
  $('input').iCheck({
    checkboxClass: 'icheckbox_square-green',
    radioClass: 'iradio_square-green',
    increaseArea: '20%' // optional
  });
});
</script>

<style>
.img1{
	width: 50px;
	height: 50px;
}
.friendList{
	height: 250px;	
	overflow : scroll;
	overflow-x:hidden;
	/* overflow-y:hidden; */
}
.groupList{
	height: 250px;
	overflow : scroll;
	overflow-x:hidden;
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
	height:50px;
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
					<li><a href="<c:url value ="/logout_get"/>">로그아웃</a></li>
					<li><a href="javascript:create_personal_album()">앨범 만들기</a></li>
					
				</ul>
			
			</nav>
			<br><br><br>

		</div>

		<!-- <form>
			<div class="search">
				 테스트<br /> 
				 <input	type="button" id="myBtn" value="모달 열기">
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
       			 height: 24px;margin-right: 5px;" onclick="var inputBox = document.getElementById('searchtx');
       			 inputBox.style.width = '200px';
        		 inputBox.style.paddingLeft='3px';
       			 inputBox.value='';
       			 inputBox.focus();">
     			 <input id='searchtx' type="text" onblur="this.style.width='0px';
             	  this.style.paddingLeft='0px';" style="  border: none;
              	 background-color: rgba(0,0,0,0);
              	 color: #666666;
               	 border-bottom: solid 2px #333;
               	 outline: none;
              	  width: 0px;
               	 transition: all 0.5s;" onkeydown="if(event.keyCode==13){searchfriend();}">		
				
		</div>
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
					&copy; 2017 <a href="https://uicookies.com/" target="_blank">uiCookies:Aside</a>.
					<br> All Rights Reserved. Designed by <a
						href="https://uicookies.com/" target="_blank">uicookies.com</a>
				</p>
			</div>
		</div>
	</div>

	</main>

	<%-- <aside class="probootstrap-aside2 js-probootstrap-aside2">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-right"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="" class="mb-2 d-block probootstrap-logo">MY FRIEND</a>			
		</div>				
				 <form>
					<input type="text" placeholder="친구검색" id="friendsearch" class="search1" >
					<input type="button" id="friendsearchbt" value="s">
				</form>
			<div class = "friendList">
				<c:if test="${Member ne null}">
					<c:if test="${fn:length(friend) ne 0}">
						<c:forEach var="arrf" items="${friend }">
							<div name="friend" id="friend">
								<p onclick="openChat('1', '${arrf.member_id}')"><img src="./memberimg?strurl=${arrf.member_picture}" style="width:40px;height:40px;">${arrf.member_id}</p>
							</div>
						</c:forEach>
						<div name="user" id="user">
						</div>												
					</c:if>
				</c:if>
			</div>
		
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="" class="mb-2 d-block probootstrap-logo">MY GROUP</a>				
		</div>				
		<!-- <div class="probootstrap-overflow"> -->
		<input type="button" value="그룹생성"
					onclick="window.open('./groupcreate_get?','','width=500 height=1000 left=50% top=50% fullscreen=no,scrollbars=no,location=no,resizeable=no,toolbar=no')">
			<div class = "groupList">
				<c:if test="${Member ne null}">
					<c:if test="${fn:length(group) ne 0}">
						<c:forEach var="party" items="${group}">
							<div name="group">
								<p onclick="openGUpdate('${party.party_name}')"
									partynum="${party.party_num}">${party.party_name}</p>
								<input type="button" value="채팅"
									onclick="openChat('0', '${party.party_num}', '')" />
							</div>
						</c:forEach>
					</c:if>
				</c:if>				
			<!-- </div> -->
		</div>

	</aside>

	<div id="div_chat" 
		style="width: 500px; height: 500px; position: absolute; padding: 0px; opacity: 1; background-color: rgb(240, 240, 240); display: none;">
		<p>
			<button id="button_close" onclick="closePChat()">닫기</button>
		</p>
		<div id="data" 
			style="height: 350px; width: 100%; overflow-y: scroll; margin: auto; display: block; padding: 0px"></div>

		<div id="div_send">
			<input type="text" id="message" autocomplete="off" />
			<input type="button" id="sendBtn" value="전송" />
			<input type="hidden" id="totalpage" value="${totalpage}">
		</div>
	</div> --%>
	
	<aside class="probootstrap-aside2 js-probootstrap-aside2">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-right"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="" class="mb-2 d-block probootstrap-logo" style = "text-align: center;">MY FRIEND</a>			
		</div>				
				 <form>
					&nbsp<input type="text" placeholder="친구검색" id="friendsearch" class="search1" >
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
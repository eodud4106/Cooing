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

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="<c:url value="/resources/js/home.js"/>"></script>
<script src="resources/js/chat.js"></script>
<script>
$(document).ready(function () {
	
	initialize();
	
	
	$('window').click(function(event) {
		if (event.target == $('#myModal')) {
			$('#myModal').css('display', 'none');
	    }
	});
	
	$('#myBtn').click(function() {
		$('#myModal').css('display', 'block');
	});
	
	$('#myBtn_close').click(function() {
		$('#myModal').css('display', 'none');
	});
	
	$('#createBtn').click(function() {
		$('#album_create_modal').css({
			'display': 'block',
			'z-index': '10000'
		});
	});
	
	$('#createBtn_close').click(function() {
		$('#album_create_frame').attr('src', 'albumEdit/AlbumNameCreate');
		$('#album_create_modal').css({
			'display': 'none',
			'z-index': '0'
		});
	});
	
	if (${sessionScope.Member != null}) {
		readyChat();
		sessionStorage.setItem('id', '${sessionScope.Member.member_id}');
	}
	
	getTotalAlbumList();
	
});

//앨범 리스트 Ajax로 받는 코드
function getTotalAlbumList() {
	$.ajax({
		url: 'getTotalAlbumList',
		type: 'post',
		dataType: 'json',
		success: function(result) {
			totalAlbumList(result);
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

//앨범 리스트 출력
function totalAlbumList(result) {
	
	var album_num;
	var album_html;
	var sw = 0;
	
$(result).each(function(i, album) {
		
		album_num = album.album_num;
		
		for(var i=0; i<album.page_html.length; i++) {
			
			if(album.page_html[i] == '<' && sw == 0){
				sw = 1;
				album_html = album.page_html.substring(i, album.page_html.length);
				
				var div_card = document.createElement('div'); //카드 클래스 div
				var div_page = document.createElement('div'); //a태그에 들어갈 div
				var a_read_album = document.createElement('a'); //a태그
				
				$(div_page).addClass('page1').html(album_html);
				a_read_album.append(div_page);
				$(div_card).addClass('card img-loaded').append(a_read_album);
				
				//a태그 링크 걸어주기
				$('.card-columns').append(div_card);
				
			}
			
		}
		
		sw = 0;
		
	});
	
}
</script>

<style>
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


</style>
</head>
<body>

	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">

			<a href="index.html" class="mb-2 d-block probootstrap-logo">COOING</a>

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

					<li>여행</li>
					<li>음식</li>
					<li><a href="<c:url value ="/"/>">MainPage</a></li>
					<li><a href="<c:url value ="/albumView"/>">albumView</a></li>
					<li><a href="<c:url value ="/myPage"/>">myPage</a></li>
					<li><a href="<c:url value ="/friendPage"/>">friendPage</a></li>
					<li><a href="<c:url value ="/albumEdit/edit"/>">albumEdit</a></li>
					<li><a href="<c:url value ="/jinsu/member_get"/>">회원가입...</a></li>
					<li><a href="<c:url value ="/jinsu/login_get"/>">로그인...</a></li>
					<li><a href="<c:url value ="/jinsu/logout_get"/>">로그아웃</a></li>

				</ul>
			</nav>

		</div>

		<form>
			<div class="search">
				<input type="text" id="searchtx" placeholder="검색어를 입력해주세요" value="${searchWord}">
				<input type="button" value="검색" id="searchbt"> 테스트<br /> <input
					type="button" id="myBtn" value="모달 열기">
				<div id="myModal" class="modal">
					<span id="myBtn_close" class="close">&times;</span>
					<iframe src="albumView" allowTransparency='true' frameborder="0"
						width=100% height="100%"></iframe>
				</div>
			</div>
			<input type="button" id="createBtn" value="앨범 생성">
		</form>
	</aside>


	<main role="main" class="probootstrap-main js-probootstrap-main">
	<div class="probootstrap-bar">
		<a href="#" class="probootstrap-toggle js-probootstrap-toggle">
			<span class="oi oi-menu"></span>
		</a>
		<div class="probootstrap-main-site-logo">
			<a href="index.html">COOING</a>
		</div>
	</div>
	
	
	
	
	<!-- 앨범 리스트 -->
	<div class="card-columns" id="card-columns">
	
		<!--  -->
		<div class="card">
			<a href="single.html">
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
	</div>
	
	
	
	

	<div class="container-fluid d-md-none">
		<div class="row">
			<div class="col-md-12">
				<ul class="list-unstyled d-flex probootstrap-aside-social">
					<li><a href="#" class="p-2"><span class="icon-twitter"></span></a></li>
					<li><a href="#" class="p-2"><span class="icon-instagram"></span></a></li>
					<li><a href="#" class="p-2"><span class="icon-dribbble"></span></a></li>
				</ul>
				<p>
					&copy; 2017 <a href="https://uicookies.com/" target="_blank">uiCookies:Aside</a>.
					<br> All Rights Reserved. Designed by <a
						href="https://uicookies.com/" target="_blank">uicookies.com</a>
				</p>
			</div>
		</div>
	</div>

	</main>

	<aside class="probootstrap-aside2 js-probootstrap-aside">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="index.html" class="mb-2 d-block probootstrap-logo">COOING2</a>
			<p class="mb-0">
				Another free html5 bootstrap 4 template by
				<a href="https://uicookies.com/" target="_blank">uiCookies</a>
			</p>
		</div>
		<div class="probootstrap-overflow">
			<div>
				<form>
					<input type="text" placeholder="친구검색" id="friendsearch" class="search1">
					<input type="button" id="friendsearchbt" value="s">
				</form>

				<c:if test="${Member ne null}">
					<c:if test="${fn:length(friend) ne 0}">
						<c:forEach var="arrf" items="${friend }">
							<div name="friend">
								<p onclick="openChat('1', '${arrf}', '')">${arrf}</p>
							</div>
						</c:forEach>
					</c:if>
				</c:if>
			</div>
			<div>
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
				<input type="button" value="그룹생성"
					onclick="window.open('./groupcreate_get?','','width=300 height=400 left=50% top=50% fullscreen=no,scrollbars=no,location=no,resizeable=no,toolbar=no')">
			</div>
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
		</div>
	</div>
	
	<div id="album_create_modal" class="modal">
		<span id="createBtn_close" class="close">&times;</span>
		<iframe id="album_create_frame" src="albumEdit/AlbumNameCreate"
			allowTransparency='true' frameborder="0" width=100% height="100%"></iframe>
	</div>

	<script src="resources/aside_js/popper.min.js"></script>
	<script src="resources/aside_js/bootstrap.min.js"></script>
	<script src="resources/aside_js/owl.carousel.min.js"></script>
	<script src="resources/aside_js/jquery.waypoints.min.js"></script>
	<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>

	<script src="resources/aside_js/main.js"></script>
</body>
</html>
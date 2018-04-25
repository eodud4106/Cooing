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
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Work+Sans">

<link rel="stylesheet" href="resources/aside_css/bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/open-iconic-bootstrap.min.css">

<link rel="stylesheet" href="resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.theme.default.min.css">
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>

<link rel="stylesheet" href="resources/aside_css/icomoon.css">
<link rel="stylesheet" href="resources/aside_css/animate.css">
<link rel="stylesheet" href="resources/aside_css/style.css">

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<!-- <script src="resources/js/chat.js"></script> -->
<script src="<c:url value="/resources/js/friend.js"/>" ></script>
<script src="<c:url value="/resources/js/search.js"/>" ></script>
<script>

var pagenum = 0;
var pagingcheck = false;
$(window).scroll(function() {
    if (pagingcheck == false && ($(window).scrollTop() + 100) >= $(document).height() - $(window).height()) {
    	if($('#totalpage').val() >= pagenum){
    		getIDAlbumList();
	    	pagingcheck = true;
    	}
    }
});

$(document).ready(function () {
	if (${sessionScope.Member != null}) {
		readyChat();
		sessionStorage.setItem('id', '${sessionScope.Member.member_id}');
	}
	initialize();
	getIDAlbumList();
});

//앨범 리스트 Ajax로 받는 코드
function getIDAlbumList() {
	var check  = false;
	if(pagenum == 0)
		check  = true;
	$.ajax({
		url: 'getIDAlbumList',
		type: 'post',
		data:{albumwriter:$('#friendid').text(),pagenum:++pagenum},
		dataType: 'json',
		success: function(result) {
			AlbumListPaging(check , result);
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

//모달
var modal = document.getElementById("myModal");

var btn = document.getElementById("myBtn");

var span = document.getElementsByClassName("close")[0];

btn.onclick = function() {
    modal.style.display = "block";
}

span.onclick = function() {
    modal.style.display = "none";
}

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
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


 @media screen and (max-width: 768px) {
   .probootstrap-main .search-bar{
      width: 100%;
      padding: 30px 15px; 
      padding-top: 30px;
	  padding-bottom: 30px;
      } }


select {
  width: 100px; 
  font-family: inherit;
  background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%;  
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  border: 1px solid #999;
  border-radius: 0px;
}

select::-ms-expand { /* for IE 11 */
    display: none;
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

			<p id="friendid"><img src="<c:url value="/memberimg?strurl=${friend_id.getMember_picture()}"/>">${friend_id.getMember_id()}</p>
		<p>
			<c:if test="${check ne true }">
				<input type="button" id="friendbt" value="친구추가" data="0">
			</c:if>
			<c:if test="${check eq true }">
				<input type="button" id="friendbt" value="친구삭제" data="1">
			</c:if>
			<input type="hidden" value="${friend_id.getMember_id()}" id="friendid">
		</p>

		</div>
		<div class="probootstrap-overflow">
			<nav class="probootstrap-nav">
				<p>FRIEND_PAGE</p>
				
				<p>CATEGORY</p>
				<ul>

					<li class="category" data="0">여행</li>
					<li class="category" data="1">음식</li>
					<li><a href="<c:url value ="/"/>">MainPage</a></li>
					<li><a href="<c:url value ="/myPage"/>">myPage</a></li>
					<li><a href="<c:url value ="/logout_get"/>">로그아웃</a></li>
					
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
			<a href="index.html">COOING</a>
		</div>
		<a href="#" class="probootstrap-toggle2 js-probootstrap-toggle2">
			<span class="oi oi-menu"></span>
		</a>	
	
	</div>	
	
	<div class ="search-bar">
		<br>
		<input type="text" id="searchtx" placeholder="검색어를 입력해주세요" value="${searchWord}" style = "float : left; margin-left: 200px;">
		<input type="button" value="검색" id="searchbt">
		<div class = "search" style= "z-index:99; float:left; padding-left : 10px;" id="searchbt" onclick=""><i class="fas fa-search"></i></div>
			
		<!-- 정렬순서 -->		
		<select style = "float:right; padding-left : 10px;">
		  <option selected >정렬순</option>
		  <option>최신순</option>
		  <option>인기순</option>
		</select>	
	</div>
		<br>	
	
	
	<!-- 앨범 리스트 -->
	<div class="card-columns" id="card-columns">
	
		<!--  -->
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
					&copy; 2018 <a href="https://uicookies.com/" target="_blank">COOING</a>.
					<br> All Rights Reserved. Designed by <a
						href="https://uicookies.com/" target="_blank">COOING</a>
				</p>
			</div>
		</div>
	</div>

	</main>

	<aside class="probootstrap-aside2 js-probootstrap-aside2">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu2 d-md-none">
			<span class="oi oi-arrow-right"></span> Close
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
			<input type="hidden" id="totalpage" value="${totalpage}">
		</div>
	</div>

	<script src="resources/aside_js/popper.min.js"></script>
	<script src="resources/aside_js/bootstrap.min.js"></script>
	<script src="resources/aside_js/owl.carousel.min.js"></script>
	<script src="resources/aside_js/jquery.waypoints.min.js"></script>
	<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>

	<script src="resources/aside_js/main.js"></script>
</body>
</html>
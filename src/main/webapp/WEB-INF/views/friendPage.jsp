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
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Work+Sans">

<link rel="stylesheet" href="resources/aside_css/bootstrap.min.css">
<link rel="stylesheet"
	href="resources/aside_css/open-iconic-bootstrap.min.css">

<link rel="stylesheet" href="resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet"
	href="resources/aside_css/owl.theme.default.min.css">
<script defer
	src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>

<link rel="stylesheet" href="resources/aside_css/icomoon.css">
<link rel="stylesheet" href="resources/aside_css/animate.css">
<link rel="stylesheet" href="resources/aside_css/style.css">
<link rel="stylesheet" href="resources/css/chat.css">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>

<script src="<c:url value="/resources/js/friend.js"/>"></script>
<script src="<c:url value="/resources/js/search.js"/>"></script>
<script src="resources/js/popup.js"></script>
<script src="resources/js/chat.js"></script>
<!-- 친구, 그룹 리스트 출력 -->
<link rel="stylesheet" href="resources/css/friend_list.css">

<script>

var pagenum = 0;
var pagingcheck = false;
//0번이면 검색 1번 이면 카테고리 
var searchcheck = 0; 
$(window).scroll(function() {
    if (pagingcheck == false && ($(window).scrollTop() + 100) >= $(document).height() - $(window).height()) {
    	if(searchcheck == 0){
	    	if($('#totalpage').val() >= pagenum){
	    		getIDAlbumList();
	    		pagingcheck = true;
	    	}
    	}else if(searchcheck == 1){
    		if($('#totalpage').val() >= pagenum){
    			getIDCategoryAlbumList();
    			pagingcheck = true;
    		}
    	}
    }
});

$(document).ready(function () {
	if (${sessionScope.Member != null}) {
		readyChat('${sessionScope.Member.member_id}', '');
		sessionStorage.setItem('id', '${sessionScope.Member.member_id}');
	}
	initialize();
	getIDAlbumList();
});
</script>

<style>
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
</style>
</head>
<body style="font-family: Poppins-Bold;">

	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate"
			data-animate-effect="fadeInLeft">

			<a href="./" class="mb-2 d-block probootstrap-logo">COOING</a>

			<p id="friendid">
				<img
					src="<c:url value="/memberimg?strurl=${friend_id.getMember_picture()}"/>">${friend_id.getMember_id()}</p>
			<p>
				<c:if test="${check ne true }">
					<div style="z-index: 99; float: right; margin-top: -40px;"
						id="friendbt" data="0">
						<i class="fas fa-user-plus"></i>
					</div>
					<!-- <input type="button" id="friendbt" value="친구추가" data="0"> -->
				</c:if>
				<c:if test="${check eq true }">
					<!-- <input type="button" id="friendbt" value="친구삭제" data="1"> -->
					<div style="z-index: 99; float: right; margin-top: -40px;"
						id="friendbt" data="1">
						<i class="fas fa-user-times"></i>
					</div>
				</c:if>
				<input type="hidden" value="${friend_id.getMember_id()}"
					id="friendidval">
			</p>


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
		<div style="margin-left: 20px;">
			SEARCH &nbsp<img id='image_search'
				src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png"
				style="width: 24px; height: 24px; margin-right: 5px;"
				onclick="inputbox_focus()">
			<input id='searchtx' type="text"
				onblur="search_bar(this)"
				style="border: none; background-color: rgba(0, 0, 0, 0); color: #666666; border-bottom: solid 2px #333; outline: none; width: 0px; transition: all 0.5s;">

		</div>
		<input type="hidden" id="totalpage" value="${totalpage }"> <br>
		<input type="hidden" id="categorynum">
	</div>



	<!-- 앨범 리스트 -->
	<div class="card-columns" id="card-columns">

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
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-right"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate"
			data-animate-effect="fadeInLeft">
			<p class="mb-2 d-block probootstrap-logo" style="text-align: center;">MY
				FRIEND</p>
		</div>
		<form>
			&nbsp<input type="text" placeholder="친구검색" id="friendsearch"
				class="search1">
			<div>
				<img id="image_search"
					src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png"
					style="width: 24px; height: 24px; margin-left: 215px; margin-top: -50px;">
		</form>
		<div class="friendList">
			<div name="friend" id="friend"></div>
			<div name="user" id="user"></div>
		</div>

		<div class="probootstrap-site-logo probootstrap-animate"
			data-animate-effect="fadeInLeft">
			<p class="mb-2 d-block probootstrap-logo" style="text-align: center;">MY
				GROUP</p>

			<!-- <div class="probootstrap-overflow"> -->

			<!-- 그룹생성 -->
			<div class="button_container">
				<button class="btn"
					onclick="window.open('./groupcreate_get?','','width=500 height=1000 left=50% top=50% fullscreen=no,scrollbars=no,location=no,resizeable=no,toolbar=no')">
					<span>GROUP CREATE</span>
				</button>
			</div>
		</div>
		<div class="groupList">
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
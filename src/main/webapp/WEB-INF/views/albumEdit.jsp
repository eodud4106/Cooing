<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<title>AlbumEdit</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="../resources/aside_css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/aside_css/open-iconic-bootstrap.min.css">

<link rel="stylesheet" href="../resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet" href="../resources/aside_css/owl.theme.default.min.css">

<link rel="stylesheet" href="../resources/aside_css/icomoon.css">
<link rel="stylesheet" href="../resources/aside_css/animate.css">
<link rel="stylesheet" href="../resources/aside_css/style.css">

<!-- 기본 js -->
<script type="text/javascript" src="../resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="../resources/js/jquery-ui.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>

<!-- <script type="text/javascript" src="../resources/album_page_js/extras/modernizr.2.5.3.min.js"></script> -->
<!-- <script type="text/javascript" src="../resources/album_page_js/basic.js"></script> -->


<!-- 기본 css -->
<link rel="stylesheet" href="../resources/css/albumEdit.css">
<link rel="stylesheet" href="../resources/css/jquery-ui.min.css">

<script src="../resources/skin_radio/icheck.js"></script>
<link rel="stylesheet" href="../resources/skin_radio/green.css">

<link rel="stylesheet" href="../resources/album_css/album_edit_basic.css">
<link rel="stylesheet" href="../resources/album_css/album_edit_drag_and_drop.css">

<script src="../resources/aside_js/popper.min.js"></script>
<script src="../resources/aside_js/owl.carousel.min.js"></script>
<script src="../resources/aside_js/jquery.waypoints.min.js"></script>
<script src="../resources/aside_js/imagesloaded.pkgd.min.js"></script>
<script src="../resources/aside_js/main.js"></script>

<!-- <script type="">
	//Load the HTML4 version if there's not CSS transform
    yepnope({
        test : Modernizr.csstransforms,
        yep : [ '../resources/album_page_js/lib/turn.js' ],
        nope : [ '../resources/album_page_js/lib/turn.html4.min.js' ],
        both : [ '../resources/album_css/basic.css' ],
        complete : loadApp
    });

</script> -->

<!-- 페이지 넘김 효과를 위한 js -->
<script type="text/javascript" src="../resources/js/turn.min.js"></script>
<!-- albumEdit 용 js -->
<script type="text/javascript" src="../resources/js/albumEdit.js"></script>

<style type="text/css">
html, body, main, .container-fluid {
	height: 100%;
}
.container-fluid {
	padding: 0;
}

.album_wrapper {
	margin: 0;
	margin-left: 250px;
	display: flex;
	flex-wrap: wrap;
}
.album, .top_bar {
	margin: auto !important;
}
.checkbox {
	font-size: 20px;
}
.page {
	background-color: #eee;
}
.hard {
	background-color: #aaa;
}
</style>

</head>
<body>

	<!-- 사이드 바 -->
	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="index.html" class="mb-2 d-block probootstrap-logo">COOING</a>
			<p class="mb-0"> 친구목록출력, 채팅기능
				<a href="https://uicookies.com/" target="_blank">uiCookies</a>
			</p>
		</div>
		<div class="probootstrap-overflow">
			<nav class="probootstrap-nav">
				<input type="text" placeholder="친구검색" name="" value="" class="search">
				<button class="bt">s</button>
			</nav>

			<p></p>
			<p>친구1</p>
			<p>친구2</p>
			<p>친구3</p>
			<p>친구4</p>

			<p>그룹1</p>
			<p>그룹2</p>

			<footer class="probootstrap-aside-footer probootstrap-animate" data-animate-effect="fadeInLeft">

				<p>
					&copy; 2018 <a href="https://uicookies.com/" target="_blank">COOING</a>
					<br> All Rights Reserved.
				</p>
			</footer>
		</div>
	</aside>

	<!-- 메인 -->
	<main role="main" class="probootstrap-main2 js-probootstrap-main">
		<div class="probootstrap-bar">
	
			<a href="#" class="probootstrap-toggle js-probootstrap-toggle">
				<span class="oi oi-menu"></span>
			</a>
			<div class="probootstrap-main-site-logo">
				<a href="index.html">COOING</a>
			</div>
	
		</div>
	
		<div class="container-fluid">
			<div class="album_wrapper">
	
				<div class="col-xl-8 col-lg-12 top_bar">
					<!-- 텍스트, 이미지, 비디오 삽입 버튼 -->
					<div class="tool text"><i class="fas fa-align-justify"></i></div>
                	<div class="tool image"><i class="far fa-image"></i></div>
                	<div class="tool video"><i class="fas fa-video"></i></div> -->
                	<!-- 고침 -->
                	<div id="text_add" style= "z-index:99; float:left; width: 5%;"><i class="fas fa-align-justify"></i></div>
					<div id="picture_add" style="z-index:99; float:left; width: 5%;"><i class="far fa-image"></i></div>
					<div id="video_add" style="z-index:99; float:left; width: 5%;"><i class="fas fa-video"></i></div>
					<!-- 배경변경버튼 -->
					<form class="tool checkbox" name="form">
						<input type="radio" name="iCheck" value="1" onclick="bgchange(0)">Sakura
						<input type="radio" name="iCheck" value="2" onclick="bgchange(1)">Pink
						<input type="radio" name="iCheck" value="3" checked
							onclick="bgchange(2)">Vintage <input type=button
							value="라디오버튼 체크여부확인" onClick="checkRadioButton('iCheck')">
					</form>
	
				</div>
				
				<!-- 앨범 영역 -->
				<div class="album" id="album">
<!-- 					<div class="hard page" id="page1">
						1
					</div>
					<div class="hard page" id="page2">
						2
					</div>
					<div class="page" id="page3">
						3
					</div>
					<div class="page" id="page4">
						4
					</div> -->
				</div>
				
			</div>
			<!-- END row -->
	
			<!--   <section class="probootstrap-section"> -->
			<div class="container-fluid">
			
	
			</div>
	
		</div>

	</main>



</body>
</html>

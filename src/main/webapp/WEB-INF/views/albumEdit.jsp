<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<title>AlbumEdit</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 기본 js -->
<script type="text/javascript" src="../resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="../resources/js/jquery-ui.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>

<script src="../resources/aside_js/popper.min.js"></script>
<script src="../resources/aside_js/owl.carousel.min.js"></script>
<script src="../resources/aside_js/jquery.waypoints.min.js"></script>
<script src="../resources/aside_js/imagesloaded.pkgd.min.js"></script>
<script src="../resources/aside_js/main.js"></script>

<script src="../resources/skin_radio/icheck.js"></script>

<!-- 페이지 넘김 효과를 위한 js -->
<script type="text/javascript" src="../resources/js/turn.js"></script>

<!-- albumEdit 용 js -->
<script type="text/javascript" src="../resources/js/albumEdit.js"></script>

<!-- 기본 css -->
<link rel="stylesheet" href="../resources/css/albumEdit.css">
<link rel="stylesheet" href="../resources/css/jquery-ui.min.css">

<!-- 기타 css -->
<link rel="stylesheet" href="../resources/album_css/album_edit_basic.css">
<link rel="stylesheet" href="../resources/album_css/album_edit_drag_and_drop.css">

<link rel="stylesheet" href="../resources/aside_css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/aside_css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="../resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet" href="../resources/aside_css/owl.theme.default.min.css">
<link rel="stylesheet" href="../resources/aside_css/icomoon.css">
<link rel="stylesheet" href="../resources/aside_css/animate.css">
<link rel="stylesheet" href="../resources/aside_css/style.css">

<link rel="stylesheet" href="../resources/skin_radio/green.css">

<style type="text/css">
html, body, main, .container-fluid {
	height: 100%;
}
.container-fluid {
	padding: 0;
}

.view_wrapper {
	margin: 0;
	margin-left: 250px;
	display: flex;
	flex-wrap: wrap;
}
.album_wrapper, .top_bar {
	margin: auto !important;
	display: block;
}
.checkbox {
	font-size: 20px;
}
.page {
	background-color: #eee;
}
.outer {
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
		<div class="main">
		<input class = "input1" id="tab1" type="radio" name="tabs" checked> <!--디폴트 메뉴-->
		<label for="tab1">앨범생성</label>

  		<input class = "input1" id="tab2" type="radio" name="tabs">
    	<label for="tab2">채팅</label>   

    	<section id="content1"> 
    	<!-- 페이지 저장 -->		
		<form method="POST" action="personal_AlbumTotalCreate" id="albumlist_form">
			<div id="entry">
				<h5 style="color: black;">앨범명</h5><input type="text" id="album_name" name="album_name">
				<h5 style="color: black;">앨범 내용</h5>
				<input type="text" id="album_contents" style = "height: 100px;" name="album_contents">
				<h5 style="color: black;">앨범 카테고리</h5>
				<select name="album_category">		
					<option value="0">여행</option>
				    <option value="1">스포츠/래저</option>
				    <option value="2">동물</option>
				    <option value="3">음악</option>
				    <option value="4">요리/음식</option>
				    <option value="5">패션/뷰티</option>
				    <option value="6">연예/TV</option>
				    <option value="7">게임</option>
				    <option value="8">영화</option>
				    <option value="9">도서</option>
				    <option value="10">공연/전시</option>
				    <option value="11">외국어</option>
				    <option value="12">전문지식</option>
				    <option value="13">수집/제작</option>
				    <option value="14">자기계발</option>
				    <option value="15">육아</option>
				    <option value="16">일상생활</option>
				    <option value="17">자동차</option>
				    <option value="18">낚시</option>
				    <option value="19">건강</option>
				    <option value="20" selected="selected">기타</option>
				</select>
				<h5 style="color: black;">앨범 공개범위</h5>
				<select name="album_openrange">		
					<option value="1" selected="selected">나만 보기</option>
				    <option value="2">전체 공개</option>
				    <option value="3">더 추가해서 ㄱㄱ</option>
				</select>
				
				<br><br><br>
				<!-- <input type="text" id="hashtagtx" placeholder="해쉬태그"><input type="button" id="hashtagbt" value="추가">--> 
				<div id="hashtagvw"></div>
				<input type="button" id="hashtagbt" value="추가">
				<br><br>
				<input type="hidden" name="album_party" value="1">
				<input type="hidden" name="album_version" value="1">
				<!-- <input type="hidden" id="hashtag" name="hashtag"> -->
				<!-- <input type="submit" onsubmit="formCheck()"> -->
			</div>
			
		</form>
		    
       
    	</section>

   		<section id="content2">
       		<form id ="" method="" action="">
			<input type ="text" placeholder = "친구검색"  name="" value = "" class ="search">
			<button class = "bt">s</button>
			</form>					
				<p></p>			
				<p>친구1</p>
				<p>친구2</p>
				<p>친구3</p>
				<p>친구4</p>
		
				<p>그룹1</p>
				<p>그룹2</p>		
    	</section>
    	</div>			

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
			<div class="view_wrapper">
	
				<div class="col-xl-8 col-lg-12 top_bar">
					<!-- 텍스트, 이미지 삽입 버튼 -->
					<div class="tool text"><i class="fas fa-align-justify"></i></div>
                	<div class="tool image"><i class="far fa-image"></i></div>
                	
					<!-- 배경변경버튼 -->
					<form name="form" style = "float:right;">
						<input type="radio" name="iCheck" class = "input"value="1" >Sakura
						<input type="radio" name="iCheck" class = "input"value="2" >Pink
						<input type="radio" name="iCheck" class = "input"value="3" checked>Vintage
						<div style= "z-index:99; float:right; " onClick="checkRadioButton('iCheck')"><i class="far fa-check-circle"></i></div>
					</form>
	
				</div>
				
				<!-- 앨범 영역 -->
				<div class="album_wrapper" id="album_wrapper">
					<div class="album" id="album"></div>
				</div>

				<!-- 하단 바 영역 -->
				<div class="under_bar">
					<button>이전</button>
					<button onclick="savePage()">저장</button>
					<button onclick="addPage()">페이지 추가</button>
					<button onclick="removePage()">페이지 삭제</button>
					<button>다음</button>
				</div>
				
			</div>
			<!-- END row -->
	
		</div>

	</main>



</body>
</html>

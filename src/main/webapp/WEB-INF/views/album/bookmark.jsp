<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>BookMark</title>
<meta charset="utf-8" />
<style>
.bookmark_img {
cursor:pointer;
}
.friendList{
	height: 600px;		
	overflow-y : scroll;
	padding-left: 30px;	
    font-size: 18px;
    cursor: pointer;
    margin-top: -15px;
}
.groupList{
	height: 600px;	
	overflow-y : scroll;
	padding-left: 30px;
	/* overflow-y:hidden; */
	/* background-color : aliceblue; */
    font-size: 18px;
    cursor: pointer;
    margin-top: 100px;    
}
.newsList{
	height: 600px;	
	overflow-y : scroll;
	padding-left: 30px;
	/* overflow-y:hidden; */
	/* background-color : aliceblue; */
    font-size: 18px;
    cursor: pointer;
    margin-top: 100px;
    
}
#main {
    min-width: 200px;
    max-width: 200px;
    margin-top : 30px;
    padding: 10px;
    margin: 0 auto;
    background: #ffffff;}
section {
    display: none;
    padding: 20px 0 0;    
    font-size : 14px;        
    border-top: 1px solid #ddd;}
/*라디오버튼 숨김*/
#tab1,#tab2,#tab3 {
      display: none;}

label {
    display: inline-block;
    margin: 0 0 -1px;
    padding: 5px 10px;
    font-weight: 600;
    text-align: center;
    color: #bbb;
    border: 1px solid transparent;
    font-size: 15px;}

label:hover {
    color: #2e9cdf;
    cursor: pointer;}

/*input 클릭시, label 스타일*/
#tab1:checked + label,#tab2:checked + label,#tab3:checked + label {
      color: #555;
      border: 1px solid #ddd;
      border-top: 2px solid #2e9cdf;
      border-bottom: 1px solid #ffffff;}

#tab1:checked ~ #content1,
#tab2:checked ~ #content2,
#tab3:checked ~ #content3{
    display: block;}

.search{	
	width: 120px;
	display:block;
	position: absolute;	
}
.bt{
	position: absolute;
	right: 40px;
}
.tb1{
	padding-top: 20px;
}	    

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
	background-color: #A4A4A4;
	
}
.outer {
	background-color: #aaa;
}
.button_container {
  position: absolute;
 /*  left: 0; */
  /* right: 0; */
 /* top: 50%;  */
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
</style>
<style type="text/css">
a{
	font-size: 20px;
	color: black;
}
.c{
	font-size: 20px;
	font-family: 'Nanum Gothic Coding', monospace;
}
li{
	cursor: pointer;	
}
p{
	font-size: 20px;
}
</style>
<script src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
<!-- 폰트 -->
<!-- 폰트 -->
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<!-- <link href="https://fonts.googleapis.com/css?family=McLaren" rel="stylesheet"> -->

<link rel="icon" type="image/png" href="resources/assets/images/cooing_logo.png"/>
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
<script src="<c:url value="/resources/aside_js/search.js"/>"></script>
<script src="<c:url value="/resources/aside_js/main.js"/>"></script>
<script src="resources/js/popup.js"></script>
<script src="resources/js/chat.js"></script>
<script src="resources/js/push.js"></script>

<link rel="stylesheet" href="resources/skin_radio/green.css">
<script src="resources/skin_radio/icheck.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- 라디오버튼 -->
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>

<script src="resources/js/jquery-ui.min.js"></script>
<script src="<c:url value="/resources/js/search.js"/>"></script>

<script>
$(document).ready(function () {
	if (${sessionScope.Member != null}) {
		readyChat('${sessionScope.Member.member_id}', '');
	}
	//북마크 리스트
	bookmark_list();
	
	//초기 친구 찾을 때만 사용했었음
	$('#friendsearch').keyup(function() {
		searchword();
	});
	$('#searchtx').keydown(function(event){
		if(event.keyCode == 13){
			location.href = './search_other?search=' + $('#searchtx').val() + '';
		}
	});
	$('.category').on('click' , function(){
		location.href = './category_other?categorynum=' + $(this).attr('data') + '';
	});
	
	searchword();
	searchgroup();
});

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
//북마크 리스트
function bookmark_list() {
	$.ajax({
		url: 'bookmark_list',
		type: 'post',
		dataType: 'json',
		success: function(bookmark_info) {
			$(bookmark_info).each(function(i, vo){
				var bookmark_page_div = document.createElement('div');
				var bookmark_info_div = document.createElement('div');
				var bookmark_link_div = document.createElement('div');
				var button_bookmark = document.createElement('img');
				var bookmark_img_thumbnail = document.createElement('img');
				
				//맨 왼쪽 디브에 사진 넣는 부분
				$(bookmark_img_thumbnail).attr('src', ''+ vo.album_thumbnail +'');
				//버튼에 링크 다는 부분
				$(button_bookmark).attr('onclick', 'location.href="albumView?album_num='+ vo.bookmark_albumnum + '&page_num=' + vo.bookmark_page + '"');
				$(button_bookmark).attr('src', 'resources/img/bookmark3.png');
				$(button_bookmark).addClass('bookmark_img');
				
				var temp_contents;
				if(vo.album_contents == null){
					temp_contents = '(내용 없음)';
				}

				var bookmark_info_div_html = '';
					bookmark_info_div_html += '<p class="bookmark_p"> 앨범 이름 : ' + vo.album_name + '</p>';
					bookmark_info_div_html += '<p class="bookmark_p"> 작성자 : ' + vo.album_writer + '</p>';
					bookmark_info_div_html += '<p class="bookmark_p"> 앨범내용 : ' + temp_contents + '</p>';
					var temp_category = category_change(vo.album_category);
					bookmark_info_div_html += '<p class="bookmark_p"> 앨범카테고리 : ' + temp_category + '</p>';
					bookmark_info_div_html += '<p class="bookmark_p"> 북마크된 페이지 : ' + vo.bookmark_page + '</p>';
				
				$(bookmark_page_div).addClass('bookmark_page_div').append(bookmark_img_thumbnail);
				$(bookmark_info_div).addClass('bookmark_info_div').append(bookmark_info_div_html);
				$(bookmark_link_div).addClass('bookmark_link_div').append(button_bookmark);
				
				$('#bookmark').append(bookmark_page_div);
				$('#bookmark').append(bookmark_info_div);
				$('#bookmark').append(bookmark_link_div);
				

			});
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

function category_change(category) {
	
	var change_category;
	switch (category) {
		case 0: change_category = '여행'; break;
		case 1: change_category = '스포츠/래저'; break;
		case 2: change_category = '동물'; break;
		case 3: change_category = '음악'; break;
		case 4: change_category = '요리/음식'; break;
		case 5: change_category = '패션/뷰티'; break; 
		case 6: change_category = '연예/TV'; break;
		case 7: change_category = '게임'; break; 
		case 8: change_category = '영화'; break; 
		case 9: change_category = '도서'; break;
		case 10: change_category = '공연/전시'; break;
		case 11: change_category = '외국어'; break;
		case 12: change_category = '전문지식'; break;
		case 13: change_category = '수집/제작'; break;
		case 14: change_category = '자기계발'; break;
		case 15: change_category = '육아'; break;
		case 16: change_category = '일상생활'; break;
		case 17: change_category = '자동차'; break;
		case 18: change_category = '낚시'; break;
		case 19: change_category = '건강'; break;
		default: change_category = '기타'; break;
	}
	return change_category;
	
}

</script>

<style>
	.bookmark_page_div {float: left; width: 200px; height: 200px; margin-bottom: 70px;}
	.bookmark_info_div {padding-top:40px; margin-left:120px; float: left; width: 200px; height: 200px; margin-bottom: 70px;}
	.bookmark_link_div {float: right; width: 200px; height: 200px; margin-bottom: 70px;}
	.bookmark{width:750px; margin-left: 150px;}
	.bookmark_page_div img {width: 100%;}
	.bookmark_link_div button {width: 50%; height: 50%;}
	.bookmark_p{font-size: small;}
</style>

</head >
<body style ="font-family: 'Nanum Gothic Coding', monospace; ">

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
					<p class = "c">CATEGORY</p>
				<ul>
					<li><a href="<c:url value ="/logout_get"/>">LOGOUT</a></li>						
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
     			 <input id='searchtx' type="text" onblur="search_bar(this)" style="  border: none;
              	 background-color: rgba(0,0,0,0);
              	 color: #666666;
               	 border-bottom: solid 2px #333;
               	 outline: none;
              	  width: 0px;
               	 transition: all 0.5s;
               	 padding-right:0px;
               	 padding-left:0px;"
               	 >		
				
		</div>
		<br>	
	</div>
	
	<!-- 북마크 div -->
	<div class="bookmark" id="bookmark">
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
				<div class = "friendList" style = "width: 200px; margin-top: 30px;">
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
	<section id ="content3">       					
		<div class = "newsList"  style= "margin-top: 70px; width: 200px;">
		여기 넣으셈
		</div>		
	</section>     
</aside>
	

	<script src="resources/aside_js/popper.min.js"></script>
	<script src="resources/aside_js/bootstrap.min.js"></script>
	<script src="resources/aside_js/owl.carousel.min.js"></script>
	<script src="resources/aside_js/jquery.waypoints.min.js"></script>
	<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>

	<script src="resources/aside_js/main.js"></script>
</body>
</html>
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

<script>
$(document).ready(function () {
	
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
				var button_bookmark = document.createElement('button');
				var bookmark_img_thumbnail = document.createElement('img');
				
				//맨 왼쪽 디브에 사진 넣는 부분
				$(bookmark_img_thumbnail).attr('src', ''+ vo.album_thumbnail +'');
				//버튼에 링크 다는 부분
				$(button_bookmark).attr('onclick', 'location.href="albumView?album_num='+ vo.bookmark_albumnum + '&page_num=' + vo.bookmark_page + '"');
				$(button_bookmark).addClass('bookmark_button');

				var bookmark_info_div_html = '';
					bookmark_info_div_html += '<p class="bookmark_p"> 앨범 이름 : ' + vo.album_name + '</p>';
					bookmark_info_div_html += '<p class="bookmark_p"> 작성자 : ' + vo.album_writer + '</p>';
					bookmark_info_div_html += '<p class="bookmark_p"> 앨범내용 : ' + vo.album_contents + '</p>';
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
	.bookmark_info_div {margin-left:120px; float: left; width: 200px; height: 200px; margin-bottom: 70px;}
	.bookmark_link_div {float: right; width: 200px; height: 200px; margin-bottom: 70px;}
	.bookmark{width:750px; margin-left: 260px;}
	.bookmark_page_div img {width: 100%;}
	.bookmark_link_div button {width: 50%; height: 50%;}
	.bookmark_p{font-size: small;}
</style>

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
				<p>TODAY's RANKING</p>
				<p></p>
				<p>CATEGORY</p>
				<ul>

					<li class="category" data="0">Journey</li>
					<li class="category" data="1">Food</li>
					<li><a href="<c:url value ="/"/>">MainPage</a></li>
					<li><a href="<c:url value ="/myPage"/>">myPage</a></li>
					<li><a href="<c:url value ="/bookmark"/>">bookmark</a></li>
					<li><a href="<c:url value ="/logout_get"/>">LogOut</a></li>
					<li><a href="javascript:create_personal_album()">Created Album</a></li>
					
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
			<div name="group" id="group">
			</div>
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
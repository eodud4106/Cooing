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
	
	$(document).mouseup(function(e){
		var container=$('.popuplayer');
		if(container.has(e.target).length == 0)
			container.hide();
	});
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
				
				var a_bookmark = document.createElement('a');
				$(a_bookmark).attr('href', 'albumView?album_num='+ vo.bookmark_albumnum + '&page_num=' + vo.bookmark_page + '');
				
				var bookmark_img_thumbnail = document.createElement('img');
				$(bookmark_img_thumbnail).attr('src', ''+ vo.album_thumbnail +'');
				
				$(a_bookmark).append(bookmark_img_thumbnail);
				$(bookmark_page_div).addClass('bookmark_page_div').append(a_bookmark);
	
				var bookmark_info_div_html = '';
					bookmark_info_div_html += '<p> 앨범 이름 : ' + vo.album_name + '</p>';
					bookmark_info_div_html += '<p> 작성자 : ' + vo.album_writer + '</p>';
					bookmark_info_div_html += '<p> 앨범내용 : ' + vo.album_contents + '</p>';
					bookmark_info_div_html += '<p> 앨범카테고리 : ' + vo.album_category + '</p>';
					bookmark_info_div_html += '<p> 북마크된 페이지 : ' + vo.bookmark_page + '</p>';
					bookmark_info_div_html += '<input type="hidden" id="bookmark_num" name="bookmark_num" value="' + vo.bookmark_num + '">';
				
				$(bookmark_info_div).addClass('bookmark_info_div').append(bookmark_info_div_html);
				
				$('#bookmark').append(bookmark_page_div);
				$('#bookmark').append(bookmark_info_div);

			});
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}
</script>

<style>
	.bookmark_page_div {float: left; width: 50%; height: 400px; margin: auto;}
	.bookmark_info_div {float: right; width: 50%; height: 400px; margin: auto;}
	.bookmark{width:70%; margin-left: 250px;}
	.bookmark_page_div img {width: 80%;}
	.bookmark_page_div a {display: block;}
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
		<!-- 이 div들을 계속 생성해주기 
		<div class="bookmark_page_div" id="bookmark_page_div1" style="border-style: solid;">
		</div>
		
		<div class="bookmark_info_div" id="bookmark_info_div1" style="border-style: solid;">
		</div>
		-->
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
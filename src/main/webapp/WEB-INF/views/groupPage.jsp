<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>group Page</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<c:url value="/resources/js/groupview.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
});
</script>
<meta charset="utf-8" />

<style>
body {
width:900px;
margin:0 auto;
}
div {
padding:20px;
border:1px solid #ccc;
}
/* header */
#header {
margin:0 0 10px 0;
padding:10px;
width:900px;
position: fixed;
background-color:#FFB2F5;
color: #F6F6F6;
text-align: center;
}

/* Content */
#container {
width:900px;
}
#content {
float:left;
padding:10px;
width:520px;
margin-left: 200px;
margin-top:110px;	
}
/* Sidebar A */
#sidebar_a {
width: 150px;
float: left;
position: fixed; 				
height: 100%; 
margin-top:110px;		
}
/* Sidebar B */
#sidebar_b {
float:right;
height : 100%;
position: fixed; 	
padding:10px;
width:150px;
margin-left: 750px;
position: fixed;
margin-top:110px;    			
}

/* Footer */
#footer {
clear:both;
padding:10px;
background-color:#CCC;
width:778px;
}

img{
	width : 50px;
	height: 50px;
}
.img_1{
	width : 150px;
	height: 150px;
}
.img_2{
	width : 30px;
	height: 30px;
}
.img_3{
	width : 20px;
	height: 20px;
}
.search{
	margin: auto;	
}
#albumList{
	margin-top: 20px;
}
.search1 {
	width: 110px;
}
.modal {
    display: block;
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
.close:hover,
.close:focus {
   color: black;
   text-decoration: none;
   cursor: pointer;
}
</style>

</head>
<body>
	<div id="header">
	<h1>COOING</h1>
	</div>

	<!-- 왼쪽 사이드바 -->
	<div id="sidebar_a">
		<c:if test="${partyinfo ne null}">${partyinfo.getParty_name()}<input type="hidden" id="sessionid" data="${Member.getMember_id()}"></c:if>
		<c:if test="${partyleader ne null}">
			<p><img src = "<c:url value="/jinsu/memberimg?strurl=${partyleader.getMember_picture()}"/>"><c:if test="${partyleader ne null}">${partyleader.getMember_id()}</c:if></p>
		</c:if>	
		<div id="memberdiv">
		<c:if test="${fn:length(memberinfo) ne 0}">
			<c:forEach var="arrmi" items="${memberinfo}">
					<p><img src = "<c:url value="/jinsu/memberimg?strurl=${arrmi.getMember_picture()}"/>"></p><p>${arrmi.getMember_id()}
					<c:if test="${partyinfo.getParty_leader() eq Member.getMember_id() and partyinfo.getParty_leader() ne arrmi.getMember_id()}">
						<img src = "./resources/image_mj/remove.png" class = "img_3" data="${arrmi.getMember_id()}" data2="${partyinfo.getParty_num()}">
					</c:if>
					</p>
			</c:forEach>
		</c:if>
		</div>
		<c:if test="${partyinfo.getParty_leader() eq Member.getMember_id()}">
			<div>
			<p>멤버 추가</p>
			<p>	<input type="text" id="findid" placeholder="Member Id 검색" size="10">
				<input type="button" id="gmemberplus" value="추가" data="${partyinfo.getParty_num()}"></p>			
			</div>
			<div>
				<p><input type="button" id="desolve" value="그룹해체" data="${partyinfo.getParty_num()}"></p>
			</div>
		</c:if>
		<p></p>
		<p></p>
		<p>ALBUM</p>
		<ul> 	
		<li>앨범1</li>
		<li>앨범2</li>				
		</ul>
	</div>	
	
	<!-- 앨범리스트 -->
	<div id="content">
					
		<div id = "albumList">	
		<!-- <button id="myBtn">모달 열기</button>

		<div id="myModal" class="modal">
                <span class="close">&times;</span>
                <iframe src="albumView" allowTransparency='true' frameborder="0" width=100% height="100%"></iframe>
        </div>
				 -->	
		<table>
		<tr>	
			<td><img src = "./resources/image_mj/yui.jpg"></td>	
			<td>그룹명</td>
		</tr>					
		</table>
		<table id = "table1">
		<tr>	
			<td><img src = "./resources/image_mj/yui2.jpeg" class = "img_1"></td>
			<td></td>
			<td><p>앨범제목dkfadfadkfasdkfadklsfaklsdfaklsddaf 
				<p>앨범설명dfadafadfadfadfadfadfadfadfadfads
				<p>해쉬태그dafdafadfadfadfadfadfadfadfad</td>													
		</tr>
		<tr>
			<td><img src = "./resources/image_mj/comment.jpg" class = "img_2">20
						    <img src = "./resources/image_mj/heart.png" class = "img_2">10</td>						
		</tr>
		</table>											
		</div>			
	</div>
	
	<!-- 오른쪽 사이드바 -->
	<div id="sidebar_b">
		<form id ="" method="" action="">
		<input type ="text" placeholder = "친구검색"  name="" value = "" class ="search1">
		<button>s</button>
		</form>		
				
		<div>				
			<p>친구1</p>
			<p>친구2</p>
			<p>친구3</p>
			<p>친구4</p>				
		</div>
		<div>
		<p>그룹1</p>
		<p>그룹2</p>
		</div>
	</div>
			
	</div>
		
	<!-- <script>
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
      </script> -->

</body>
</html> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>GroupPage</title>
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
<script src="resources/js/chat.js"></script>
<script src="<c:url value="/resources/js/groupview.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
});

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
		$('#album_create_frame').attr('src', '/AlbumNameCreate');
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

// 그룹 앨범 만드기...
function create_group_album() {
	$.ajax({
		url: 'create_album',
		type: 'post',
		data: {
			party_name: '${partyinfo.party_name}',
			isPersonal: 0
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

<style>
.img1 {
	width: 50px;
	height: 50px;
}
.img_3{
	width : 20px;
	height: 20px;
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
			<button onclick="create_group_album()">앨범 만들기</button>

			<c:if test="${partyinfo ne null}">(GROUP_NAME)${partyinfo.getParty_name()}<input type="hidden" id="sessionid" data="${Member.getMember_id()}"></c:if>
				<c:if test="${partyleader ne null}">
				<p><img class = "img1" src = "<c:url value="/jinsu/memberimg?strurl=${partyleader.getMember_picture()}"/>">
				<c:if test="${partyleader ne null}">${partyleader.getMember_id()}(Leader)</c:if></p>
			</c:if>	
		<div id="memberdiv">
		<c:if test="${fn:length(memberinfo) ne 0}">
			<c:forEach var="arrmi" items="${memberinfo}">
				<p><img class = "img1" src = "<c:url value="/jinsu/memberimg?strurl=${arrmi.getMember_picture()}"/>"></p><p>${arrmi.getMember_id()}
				<c:if test="${partyinfo.getParty_leader() eq Member.getMember_id() and partyinfo.getParty_leader() ne arrmi.getMember_id()}">
					<img src = "./resources/image_mj/remove.png" class = "img_3" data="${arrmi.getMember_id()}" data2="${partyinfo.getParty_num()}">
				</c:if>
				</p>
			</c:forEach>
		</c:if>

		</div>
		<div class="probootstrap-overflow">
			<nav class="probootstrap-nav">				
				
			<c:if test="${partyinfo.getParty_leader() eq Member.getMember_id()}">
				<div>
					<p>멤버 추가</p>
					<p>	<input type="text" id="findid" placeholder="Member Id 검색" size="10">
					<input type="button" id="gmemberplus" value="추가" data="${partyinfo.getParty_num()}"></p>			
				</div>
				<div>
					<p><input type="button" id="desolve" value="그룹해체" data="${partyinfo.getParty_num()}"></p>
				</div>
			</c:if>
				
				<%-- <p>CATEGORY</p>
				<ul>

					<li class="category" data="0">여행</li>
					<li class="category" data="1">음식</li>
					<li><a href="<c:url value ="/"/>">MainPage</a></li>
					<li><a href="<c:url value ="/albumTestView"/>">albumView</a></li>
					<li><a href="<c:url value ="/myPage"/>">myPage</a></li>
					<li><a href="<c:url value ="/friendPage"/>">friendPage</a></li>
					<li><a href="<c:url value ="/albumEdit/edit"/>">albumEdit</a></li>
					<li><a href="<c:url value ="/jinsu/member_get"/>">회원가입...</a></li>
					<li><a href="<c:url value ="/jinsu/login_get"/>">로그인...</a></li>
					<li><a href="<c:url value ="/jinsu/logout_get"/>">로그아웃</a></li>
					
				</ul> --%>
			</nav>
		</div>

		<form>			
				 <input	type="button" id="myBtn" value="모달 열기">
				<div id="myModal" class="modal">
					<span id="myBtn_close" class="close">&times;</span>
					<iframe src="albumView" allowTransparency='true' frameborder="0"
						width=100% height="100%"></iframe>
				</div>			
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
		</div>
	</div>
	
	<div id="album_create_modal" class="modal">
		<span id="createBtn_close" class="close">&times;</span>
		<iframe id="album_create_frame" src="/AlbumNameCreate"
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
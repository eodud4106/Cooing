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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

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

<link rel="stylesheet" href="resources/css/jquery-ui.min.css">
<link rel="stylesheet" href="resources/css/chat.css">

<!-- 친구그룹목록출력 -->
<link rel="stylesheet" href="resources/css/friend_list.css">

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/chat.js"></script>
<script src="resources/js/groupview.js"/></script>
<script src="resources/js/search.js"></script>
<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<script>

$(document).ready(function () {
	initialize();
	
	if (${sessionScope.Member != null}) {
		readyChat();
		sessionStorage.setItem('id', '${sessionScope.Member.member_id}');
	}
	
	getPartyAlbumList(0);
	
	$('#albumcreate').on('click',create_group_album);
});

//그룹 앨범 만드기...
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
.img-responsive img-circle {
	width: 50px;
	height: 50px;
	
}
.img_3{
	width : 20px;
	height: 20px;
}

@media screen and (max-width: 768px) {
   .probootstrap-main .search-bar{
      width: 100%;
      padding: 30px 15px; 
      padding-top: 30px;
	  padding-bottom: 30px;
    }
}

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
<body style ="font-family: 'Nanum Gothic Coding', monospace;">

	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">

			<a href="/www" class="mb-2 d-block probootstrap-logo">COOING</a>
			<div id="party_name" class="mb-2 d-block probootstrap-logo" style = "font-family: 'Do Hyeon', sans-serif; color : #1f5dad">${partyinfo.getParty_name()}</div>	
			
			<c:if test="${partyinfo.getParty_leader() eq Member.getMember_id()}">
				<div style= "z-index:99; float:right; margin-top: -40px;"id="desolve" data="${partyinfo.getParty_num()}">
				<i class="far fa-times-circle"></i></div>
				
				<%-- 
					<p><input type="button" id="desolve" value="그룹해체" data="${partyinfo.getParty_num()}"></p>
				</div> --%>
				<div>
					<p>	<input type="text" id="findid" placeholder="Member 추가" size="19">
					<!-- <input type="button" id="gmemberplus" value="추가"></p> -->	
					<div style= "z-index:99; float:right; margin-top: -40px;"id="gmemberplus">
					<i class="fas fa-user-plus"></i></div>
				</div>
				
			</c:if>				
			
			<input type="hidden" id="sessionid" data="${Member.getMember_id()}">
				<c:if test="${partyleader ne null}">
				<p><img  class="img-circle" style =" border-radius: 80%; display: inline-block;; width: 100% \9;
    				max-width: 25%; height: auto;"src = "<c:url value="/memberimg?strurl=${partyleader.getMember_picture()}"/>">&nbsp
				<c:if test="${partyleader ne null}">${partyleader.getMember_id()}(Leader)</c:if></p>
			</c:if>	
			
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<p class="mb-2 d-block probootstrap-logo" style = "text-align: center;">MEMBERS	
		</div>	
		<div id="memberdiv">
		<c:if test="${fn:length(memberinfo) ne 0}">
			<c:forEach var="arrmi" items="${memberinfo}">
				<p><img  class="img-responsive img-circle" style =" border-radius: 80%; display: inline-block;; width: 100% \9;
    				max-width: 25%; height: auto;"src = "<c:url value="/memberimg?strurl=${arrmi.getMember_picture()}"/>">&nbsp${arrmi.getMember_id()}
				<c:if test="${partyinfo.getParty_leader() eq Member.getMember_id() and partyinfo.getParty_leader() ne arrmi.getMember_id()}">
					<%-- <img src = "./resources/image_mj/remove.png" class="img_3" data="${arrmi.getMember_id()}" data2="${partyinfo.getParty_num()}"> --%>
					<div style= "z-index:99; float:right;margin-top: -29px; " class="img_3" data="${arrmi.getMember_id()}" data2="${partyinfo.getParty_num()}">
					<i class="fas fa-user-times" ></i></div>
				</c:if>
				</p>
			</c:forEach>
		</c:if>

		</div>
		<div class="probootstrap-overflow" id="albumcreate">
			<nav class="probootstrap-nav">	
			<a href="#">앨범 만들기</a>				
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
	<div class="card-columns" id="card-columns">
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
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-right"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<p class="mb-2 d-block probootstrap-logo" style = "text-align: center;">MY FRIEND		
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
			<p class="mb-2 d-block probootstrap-logo" style = "text-align: center;">MY GROUP				
						
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
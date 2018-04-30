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

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/chat.js"></script>
<script src="resources/js/groupview.js"/></script>
<script src="resources/js/search.js"></script>
<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">

<link rel="stylesheet" href="resources/button_css/style.css">
<script>

var pagenum = 0;
var pagingcheck = false;
//이게 0번이면 검색어 1번이면 카테고리 2번이면 그냥 메인 으로 나눠서 페이징 가지고 오게 된다.
var searchcheck = 99;
$(window).scroll(function() {
    if (pagingcheck == false && ($(window).scrollTop() + 100) >= $(document).height() - $(window).height()) {
    	//메인으로 그냥 들어왔을 때 와 검색해서 들어왔을 때 = 0 / 카테고리 눌러서 들어왔을 때  = 1 
    	if(searchcheck == 0){
    		if($('#totalpage').val() >= pagenum){	
    			get_group_album_list('writer' , 'party', ${partyinfo.getParty_name()} , 'date', ++pagenum , 0);
        		pagingcheck = true;
        	}
    	}else if(searchcheck == 1){
    		if($('#totalpage').val() >= pagenum){	
    			get_group_album_list('category' , 'party', ${partyinfo.getParty_name()} , 'date', ++pagenum , 1);
        		pagingcheck = true;
        	}
    	}   	
    }
});

$(document).ready(function () {
	initialize();
	
	$('.category').on('click' , function(){
		searchcheck = 99;
		$('#categorynum').val($(this).attr('data'));
		get_album_list('category' , 'party' , '${partyinfo.getParty_name()}'  , 'date', ++pagenum , 1);
	});
	
	if (${sessionScope.Member != null}) {
		readyChat();
		sessionStorage.setItem('id', '${sessionScope.Member.member_id}');
	}
	
	get_album_list('writer' , 'party' , '${partyinfo.getParty_name()}' ,  'date', ++pagenum , 0);
	
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
<style type="text/css">
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
#tab1,#tab2 {
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
#tab1:checked + label,#tab2:checked + label {
      color: #555;
      border: 1px solid #ddd;
      border-top: 2px solid #2e9cdf;
      border-bottom: 1px solid #ffffff;}

#tab1:checked ~ #content1,
#tab2:checked ~ #content2{
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

.friendList{
	height: 700px;		
	overflow-y : scroll;
	padding-left: 30px;	
    font-size: 18px;
    cursor: pointer;
    margin-top: -15px;
}
.groupList{
	height: 700px;	
	overflow-y : scroll;
	padding-left: 30px;
	/* overflow-y:hidden; */
	/* background-color : aliceblue; */
    font-size: 18px;
    cursor: pointer;
    margin-top: 100px;
    
}

</style>
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
			<div id="party_name" class="mb-2 d-block probootstrap-logo" style = "font-family: 'Do Hyeon', sans-serif; color : #1f5dad"><${partyinfo.getParty_name()}></div>	
			
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
			
		<p style = "font-size: 20px;">[Member]</p>	
		<div id="memberdiv" style ="height: 400px;">
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
		
		<button id="albumcreate" class = "button">
			Album Create
			<div class="button__horizontal"></div>
			<div class="button__vertical"></div>
		</button>

		
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

	
	<%-- <aside class="probootstrap-aside2 js-probootstrap-aside2">
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

	</aside> --%>
	
	<aside class="probootstrap-aside2 js-probootstrap-aside2">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
		
			<span class="oi oi-arrow-right"></span> Close
		</a>
		
		<div class="probootstrap-overflow">
		<div id="main">
		<input class = "input1" id="tab1" type="radio" name="tabs" checked> <!--디폴트 메뉴-->
		<label for="tab1">FRIEND</label>

  		<input class = "input1" id="tab2" type="radio" name="tabs">
    	<label for="tab2">GROUP</label>   

    	<section id="content1"> 
    	<!-- 페이지 저장 -->		
			<form class="contact100-form validate-form" id="entry">
				<span class="contact100-form-title">
					&nbsp<input type="text" placeholder="친구검색" id="friendsearch" class = "search1" style ="font-size: 14px; width:100%;" >					
				</span>
			</form>						
				<div class = "friendList" style = "width: 200px;">
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
		</div>		
		
		<div class = "groupList" style= "margin-top: 70px; width: 200px;">
			<c:if test="${Member ne null}">
				<c:if test="${fn:length(group) ne 0}">
					<c:forEach var="party" items="${group}">
						<div name="group">
							<p class="arr_party" partynum="${party.party_num}">${party.party_name}</p>
						</div>
					</c:forEach>
				</c:if>
			</c:if>				
		</div>
	</section>   
   </div>
   </div>
</aside>
	
	<!-- 
	<div class="popuplayer">
		<p onClick="friendpage()" style="font-size:8pt;color:#26afa1;">친구페이지</p>
		<p onClick="chatpage()" style="font-size:8pt;color:#26afa1;">채팅</p>
	</div>
	 -->	

	<script src="resources/aside_js/popper.min.js"></script>
	<script src="resources/aside_js/bootstrap.min.js"></script>
	<script src="resources/aside_js/owl.carousel.min.js"></script>
	<script src="resources/aside_js/jquery.waypoints.min.js"></script>
	<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>

	<script src="resources/aside_js/main.js"></script>
</body>
</html>
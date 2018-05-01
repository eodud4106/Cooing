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
<link rel="icon" type="image/png" href="resources/assets/images/cooing_logo.png"/>
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
<!-- 탭메뉴 -->
<link rel="stylesheet" href="resources/css/tab.css">
<link rel="stylesheet" href="resources/css/jquery-ui.min.css">
<link rel="stylesheet" href="resources/css/chat.css">

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/chat.js"></script>
<script src="resources/js/popup.js"></script>
<script src="resources/js/groupview.js"/></script>
<script src="resources/js/search.js"></script>
<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">
<link rel="stylesheet" href="resources/button_css/style.css">
<style>
#image_search {
	cursor: pointer;
}
.dropbtn {
    background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropdown {
    position: relative;
    display: inline-block;    
}

.dropdown-content {
    display: none;
    position: absolute;    
    background-color: #f9f9f9;
    min-width: 160px;
    height : 200px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    overflow-y: scroll;
    padding-bottom: 1px;
}

.dropdown-content li {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content li:hover {
	background: -webkit-linear-gradient(right, #00dbde, #499ce8);
	color : white;
}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown:hover .dropbtn {
    background-color: #3e8e41;
}
</style>
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
    			get_group_album_list('writer' , 'party', '${partyinfo.getParty_name()}' , 'date', ++pagenum , 0);
        		pagingcheck = true;
        	}
    	}else if(searchcheck == 1){
    		if($('#totalpage').val() >= pagenum){	
    			get_group_album_list('category' , 'party', '${partyinfo.getParty_name()}' , 'date', ++pagenum , 1);
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
		get_group_album_list('category' , 'party' , '${partyinfo.getParty_name()}'  , 'date', ++pagenum , 1);
	});
	
	if (${sessionScope.Member != null}) {
		readyChat();
		sessionStorage.setItem('id', '${sessionScope.Member.member_id}');
	}
	
	$('#searchtx').keydown(function(event){
		if(event.keyCode == 13){
			searchcheck = 99;
			get_group_album_list('writer' , 'party' , '${partyinfo.getParty_name()}' , 'data', ++pagenum , 0);
		}
	});
	
	get_group_album_list('writer' , 'party' , '${partyinfo.getParty_name()}' ,  'date', ++pagenum , 0);
	
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
			<div id="party_name" class="mb-2 d-block probootstrap-logo" style = "color : #1f5dad"><${partyinfo.getParty_name()}>
			</div>	
			
			<c:if test="${partyinfo.getParty_leader() eq Member.getMember_id()}">
				<div style= "z-index:99; float:right; margin-top: 60px; cursor: pointer;"id="desolve" data="${partyinfo.getParty_num()}">
				<i class="far fa-times-circle"></i>
				</div>
				
				<div>
					<p>	<input type="text" id="findid" placeholder="Member 추가" size="19" style= "width: 150px;">						
					<div style= "z-index:99; float:right; margin-top: -35px; margin-right: -20px; cursor: pointer;" id="gmemberplus">
					<i class="fas fa-user-plus"></i>
					</div>
				</div>				
			</c:if>				
			<div style ="font-family: 'Nanum Gothic Coding', monospace;"><a class="mb-2 d-block probootstrap-logo">${partyinfo.getParty_name() }</a></div>
			<input type="hidden" id="sessionid" data="${Member.getMember_id()}">
				<c:if test="${partyleader ne null}">
				<p><img  class="img-circle" style =" border-radius: 80%; display: inline-block;; width: 100% \9;
    				max-width: 25%; height: auto;"src = "<c:url value="/memberimg?strurl=${partyleader.getMember_picture()}"/>">&nbsp
				<c:if test="${partyleader ne null}">${partyleader.getMember_id()}(Leader)</c:if></p>
			</c:if>	
			
		<p style = "font-size: 20px;">[Member]</p>	
		<div id="memberdiv" style ="height: 300px;">
		<c:if test="${fn:length(memberinfo) ne 0}">
			<c:forEach var="arrmi" items="${memberinfo}">
				<p class ="p1"><img  class="img-responsive img-circle" style =" border-radius: 80%; display: inline-block;; width: 100% \9;
    				max-width: 25%; height: auto;"src = "<c:url value="/memberimg?strurl=${arrmi.getMember_picture()}"/>">&nbsp${arrmi.getMember_id()}
				<c:if test="${partyinfo.getParty_leader() eq Member.getMember_id() and partyinfo.getParty_leader() ne arrmi.getMember_id()}">					
					<div style= "z-index:99; float:right;margin-top: -29px; cursor: pointer;" class="img_3" data="${arrmi.getMember_id()}" data2="${partyinfo.getParty_num()}">
					<i class="fas fa-user-times" ></i></div>
				</c:if>
				</p>
			</c:forEach>
		</c:if>
		</div>
		<nav class="probootstrap-nav">
		<ul>
			<li><a href="<c:url value ="/"/>">HOME</a></li>
			<li><a href="<c:url value ="/myPage"/>">MYPAGE</a></li>
			<li><a href="<c:url value ="/LankingPage"/>">TODAY'S RANKING</a></li>						
		</ul>
			<div class = "dropdown">
						<p class ="c" class = "dropbtn">CATEGORY</p>
						 <div class="dropdown-content">
						 <ul>
						  	<li class="category" data="0">여행</li>
						    <li class="category" data="1">스포츠/레저</li>
						    <li class="category" data="2">동물</li>
						    <li class="category" data="3">음악</li>
						    <li class="category" data="4">요리/음식</li>
						    <li class="category" data="5">패션/뷰티</li>
						    <li class="category" data="6">연예/TV</li>
						    <li class="category" data="7">게임</li>
						    <li class="category" data="8">영화</li>
						    <li class="category" data="9">도서</li>
						    <li class="category" data="10">공연/전시</li>
						    <li class="category" data="11">외국어</li>
						    <li class="category" data="12">전문지식</li>
						    <li class="category" data="13">수집/제작</li>
						    <li class="category" data="14">자기계발</li>
						    <li class="category" data="15">육아</li>
						    <li class="category" data="16">일상생활</li>
						    <li class="category" data="17">자동차</li>
						    <li class="category" data="18">낚시</li>
						    <li class="category" data="19">건강</li>
						    <li class="category" data="20">기타</li>
						    </ul>
					    </div>
					</div>
		<ul>
			<li><a href="<c:url value ="/logout_get"/>">LOGOUT</a></li>						
		</ul>		
		</nav>	
		
		
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
		<div style = "margin-left: 20px; font-size: 20px;">
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
	
	
	<!-- 앨범 리스트 -->
	<div class="card-columns" id="card-columns" style="cursor: pointer;">
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
				<div class = "friendList" style = "width: 200px; margin-top: 20px;">
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
	
	<section id ="content3">       					
	<div class="button_container">		
		여기!
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
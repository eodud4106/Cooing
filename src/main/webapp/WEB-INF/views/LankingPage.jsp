<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>RankingPage</title>
<meta charset="UTF-8" />
<link rel="icon" type="image/png" href="resources/assets/images/cooing_logo.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/css/graph.css">
<link rel="stylesheet" href="resources/css/green.css">
<link rel="stylesheet" href="resources/css/icomoon.css">
<link rel="stylesheet" href="resources/css/animate.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/jquery-ui.css">
<link rel="stylesheet" href="resources/css/chat.css">
<link rel="stylesheet" href="resources/css/push.css">

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/popper.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>
<script type="text/javascript" src="http://www.workshop.rs/jqbargraph/jqBarGraph.js"></script>
 <script src="resources/js/icheck.js"></script>
<script src="resources/js/owl.carousel.min.js"></script>
<script src="resources/js/jquery.waypoints.min.js"></script>
<script src="resources/js/imagesloaded.pkgd.min.js"></script>
<script src="resources/js/laking.js"></script>
<script src="resources/js/search.js"></script>
<script src="resources/js/popup.js"></script>
<script src="resources/js/main.js"></script>
<script src="resources/js/chat.js"></script>
<script src="resources/js/push.js"></script>

<!-- 탭나누는 사이드바 -->
<link rel="stylesheet" type="text/css" href="resources/album_create/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/album_create/css/main.css">


<script>
$(document).ready(function() {
	initialize();
	/* readyChat('${sessionScope.Member.member_id}', ''); */
});

</script>
<!-- 정렬순 라디오 버튼 -->
<script>
$(document).ready(function(){
  $('.input').iCheck({
    checkboxClass: 'icheckbox_square-green',
    radioClass: 'iradio_square-green',
    increaseArea: '20%' // optional
  });
	//경고!! 아래 코드를 절대 별도의 js파일로  마시오!!
	if ('${sessionScope.Member}' != null) {
		readyChat('${sessionScope.Member.member_id}', '');
		readyPush('${sessionScope.Member.member_id}', '');
	}
});
</script>
<style>
#image_search {
	cursor: pointer;
}
.img1 {
	width: 50px;
	height: 50px;
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

.friendList{
	height: 700px;		
	overflow-y : scroll;
	padding-left: 30px;	
    font-size: 14px;
    font-family: Poppins-Regular;
    cursor: pointer;
    margin-top: -15px;
}
.groupList{
	height: 700px;	
	/* overflow-y : scroll; */
	padding-left: 30px;
	font-family: Poppins-Regular;
	/* overflow-y:hidden; */
    font-size: 14px;
    cursor: pointer;
    margin-top: 100px;
    
}
.newsList{
	height: 700px;	
	/* overflow-y : scroll; */
	padding-left: 30px;
	/* overflow-y:hidden; */
	/* background-color : aliceblue; */
    font-size: 18px;
    cursor: pointer;
    margin-top: 100px;
    
}

a{
	font-size: 20px;
}
.c{
	font-size: 20px;
	font-family: 'Nanum Gothic Coding', monospace;
}
li{
	cursor: pointer;
}

</style>
</head>
<body style ="font-family: 'Nanum Gothic Coding', monospace;">

	<aside class="probootstrap-aside js-probootstrap-aside" style = "background-color: aliceblue;">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">

			<a href="/www" class="mb-2 d-block probootstrap-logo" style= "font-size: 30px;">COOING</a>

			<!-- 로그인되어있을 때 -->
			<c:if test="${Member ne null}">
				<p>
					<img src="<c:url value="/img_member" />" class="img1">${Member.getMember_id()}
				</p>
			</c:if>
			<!-- 로그인 안되어있을 때 -->
			<c:if test="${Member eq null}">
				<p>
					<img class="img1" src="http://1.bp.blogspot.com/-t9dmAueNbW0/VQYvJX7kVrI/AAAAAAAAGYY/Ou05G2Vi2kw/s1600/1%2B(3).jpg">Please LOGIN
				</p>
			</c:if>

		</div>
		<div class="probootstrap-overflow">
			<nav class="probootstrap-nav">
				<ul>					
					<li><a href="<c:url value ="/"/>">HOME</a></li>
					<li><a href="<c:url value ="/myPage"/>">MY PAGE</a></li>
					<li><a href="<c:url value ="/LankingPage"/>">TODAY'S RANKING</a></li>														
					<li><a href="<c:url value ="/logout_get"/>">LOGOUT</a></li>
				</ul>									
			</nav>
			<footer class="probootstrap-aside-footer probootstrap-animate" data-animate-effect="fadeInLeft" 
				style = "font-family: Poppins-Regular;">          
         		 <p>&copy; 2018 <a href="cooing.site/www" target="_blank">COOING</a>. <br> All Rights Reserved.</p>
       			 </footer>	
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
               	 padding-left:0px;
               	 padding-right:0px;">		
		
	</div>
		<br>	
	
	
	<div class="card-columns" id="card-columns">
	
	<div align="center">
		DATE : <input type="text" id="datepicker">
		<!-- 정렬순서 -->		
		<form style = "float:right; padding-left : 10px; font-size: 20px;" id="radiobutton">
			<input type="radio" name="iCheck" class="input"value="1" checked>Category 
			<input type="radio" name="iCheck" class="input"value="2">Keyword
			<input type="radio" name="iCheck" class="input"value="3">Like
		</form>
	</div>	
		<!-- 그래프 출력될 곳 -->
		
		<!-- <div id="graphdiv" style="width:100%;height:100%"></div>	 -->	
	
	</div>
	
	
	
	<div id="graphdiv" style="width:100%;height:100%;margin:0 auto;"></div>
	

	<div class="container-fluid d-md-none">
	
		<div class="row">
		
			<div class="col-md-12">				
				<p>
					<!-- &copy; 2018<a href="https://uicookies.com/" target="_blank">COOING</a>.
					<br> All Rights Reserved. Designed by <a
						href="https://uicookies.com/" target="_blank">COOING</a> -->
							
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
		<label for="tab1"style = "font-size: 13px;" >FRIEND</label>

  		<input class = "input1" id="tab2" type="radio" name="tabs">
    	<label for="tab2"style = "font-size: 13px;">GROUP</label>   

    	<input class = "input1" id="tab3" type="radio" name="tabs">
    	<label for="tab3" style = "font-size: 13px;">NEWS</label>  
    	
    	<section id="content1"> 
    	<!-- 페이지 저장 -->		
			<form class="contact100-form validate-form" id="entry">
				<span class="contact100-form-title">
					&nbsp<input type="text" placeholder="친구 찾기" id="friendsearch" class = "search1" style ="font-size: 14px; width:100%;" >					
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
			<button class="btn"onclick="window.open('./groupcreate_get?','','width=500 height=600 left=50% top=50% fullscreen=no,scrollbars=no,location=no,resizeable=no,toolbar=no')"><span>GROUP CREATE</span></button></div>
			
		<div class = "groupList" id="group" style= "margin-top: 70px; width: 200px;">
		</div>
	</section>   
	<!-- 영준이 알림공간 -->
	<section id ="content3" class="content3">       					
		<div class = "div_news" id="div_news" style = "text-align :center;  font-size: 14px;">
			<div class="msg_box" id="msg_box">
				<div class="msg_title">MESSAGE</div>
				<div class="msg_list" id="msg_list"></div>
			</div>
			<div class="invite_box" id="invite_box">
				<div class="invite_title">INVITE</div>
				<div class="invite_list" id="invite_list"></div>
			</div>
		</div>
	</section> 
</aside>


</body>
</html>
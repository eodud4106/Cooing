<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	     pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>AlbumView</title>
<meta charset="utf-8" />
<meta name="viewport" content="width = 1050, user-scalable = no" />
	<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="resources/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="./resources/album_page_js/extras/modernizr.2.5.3.min.js"></script>
	<link rel="stylesheet" href="resources/css/jquery-ui.min.css">
<style>

body {
	width:100%;
	background-color:rgba(255,255,255,0.8);	
}
div {
	border: 1px solid #ccc; /* 모든 영역에 테두리 표시 */
}
#container {
	width:100%; /* 컨테이너 너비 */
	padding:20px; /* 패딩 */			
	height: 100%;
	border: none;
}		
#contents {
	padding: 20px;  /* 패딩 */
	float: left;  /* 왼쪽으로 플로팅 */				
	position: absolute;
	bottom: 50px;
	top : 50px;
	left: 10px;
	right:270px;
}
#sidebar {
	width: 220px;  /* 너비 */
	padding: 20px;  /* 패딩 */
	float: right;  /* 오른쪽으로 플로팅 */			
	background:#eee;
	margin-left : 665px;
	position :absolute;
	bottom: 50px;
	right:10px;
	top : 50px
}
img {
	width : 50px;
	height: 50px;
}
.img1 {
	width : 30px;
	height: 30px;
}

p {
    margin: 0 0 20px;
    line-height: 1.5;}

.main {
    min-width: 200px;
    max-width: 200px;
    padding: 10px;
    margin: 0 auto;
    background: #ffffff;}

section {
    display: none;
    padding: 20px 0 0;    
    font-size : 14px;        
    border-top: 1px solid #ddd;}

/*라디오버튼 숨김*/
input {
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
input:checked + label {
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
		
</style>
</head>
<body>
<div id="container"> 
   
<!--   앨범제목, 앨범내용, 태그, 댓글, 좋아요, 채팅 -->
<div id="sidebar">
<table>
	<tr>	
		<td><img src = "./resources/image_mj/suji.jpg"></td>	
		<td>id</td>
	</tr>				
</table>
<table id = "table1">
	<tr>	
		<td><p>앨범제목 
			<p>앨범설명
			<p>해쉬태그</td>													
	</tr>
</table>
	
	<div class="main">
 		<input id="tab1" type="radio" name="tabs" checked> <!--디폴트 메뉴-->
		<label for="tab1">댓글</label>

  		<input id="tab2" type="radio" name="tabs">
    	<label for="tab2">채팅</label>   

    	<section id="content1">     
        <table>        	
        <tr>	      
			<td><img src = "./resources/image_mj/suji.jpg" class = "img1"></td>		 
			<td><input type ="text" placeholder = ""  name="" value = "" class ="search">
			<button class = "bt">s</button></td>		
	    </tr>	
        </table>
     
        <table class = tb1>
        <tr>
       		<th>mj</th>
       		<td>css담당</td>
        </tr>
        <tr>
       		<th>js</th>
      	 	<td>우리조조장</td>
        </tr>
        <tr>
       		<th>yj</th>
       		<td>흰둥아빠</td>
        </tr>
        <tr>
       		<th>dy</th>
       		<td>앨범팀장</td>
        </tr>
        <tr>
       		<th>hj</th>
       		<td>9호선친구</td>
        </tr>       	
        </table>        
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
</div>
<button>편집</button>

<div id="contents">
	<div class="flipbook-viewport">	
		<div class="container">
			<div class="flipbook">
				<div style="background-image:url(./resources/image_mj/yui.jpg)"></div>
				<div style="background-image:url(./resources/image_mj/suji2.jpg)"></div>
				<div style="background-image:url(./resources/image_mj/yui2.jpeg)"></div>
				<div style="background-image:url(./resources/image_mj/josh.jpg)"></div>
		</div>
	</div>
</div>

			
<script type="text/javascript">

function loadApp() {

	// Create the flipbook

	$('.flipbook').turn({
			// Width

			width:1200,
			
			// Height

			height:600,

			// Elevation

			elevation: 50,
			
			// Enable gradients

			gradients: true,
			
			// Auto center this flipbook

			autoCenter: true

	});
}

// Load the HTML4 version if there's not CSS transform

yepnope({
	test : Modernizr.csstransforms,
	yep: ['./resources/album_page_js/lib/turn.js'],
	nope: ['./resources/album_page_js/lib/turn.html4.min.js'],
	both: ['./resources/album_css/basic.css'],
	complete: loadApp
});

</script>           
	
	</div>	

</div> 

</body>
</html>

  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	     pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Albumview</title>
<meta charset="utf-8" />

<title>2단 레이아웃</title>
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
.tab_menu{
	width:200px;
	font-size: 9pt;
	font-weight: bold;
	height : 30px;
	text-align: left;
}
.tab_menu>ul{
	display : block;
	margin : 0;
	padding : 0;
	width: 200px;
	vertical-align: middle;
}
.tab_menu>ul>li{
	display: inline-block;
	width: 50px;
	line-height: 20px;
	white-space: nowrap;
	text-transform: capitalize !important;
	text-align: center;
	list-style: none;
	vertical-align: middle;
	color: #929292;
	background-color: #DBDBDB;
	border: 1px solid #989a9f;
	cursor: pointer;
}
.tab_menu>ul>li.active{
	color: #1c58af;
	background-color: #ffffff;
	border-bottom: 1px solid #ffffff;
}
.tab_content{
	width: 200px;
	padding: 1em;
	border: 1px solid #989a9f;
	font-size: 9pt;
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
				<td><p>앨범제목dkfadfadkfasdkfadklsfaklsdf 
					<p>앨범설명dfadafadfadfadfadfadfaddfadfads
					<p>해쉬태그dafdafadfadfadfadfadfadfadfad</td>													
			</tr>
		</table>
		<div class ="tab_menu">
			<ul>
				<li class ="active">댓글</li>
				<li>채팅</li>
			</ul>
		</div>
		<div class = "tab_content">
		content
		</div>
					
		</div>
		<div id="contents">
			<h2>앨범</h2>
            
		</div>
		
     </div> 
</body>
</html>

  
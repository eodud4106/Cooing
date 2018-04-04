<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Layouts</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="resources/js/chat.js"></script>
<script>
$(document).ready(function () {
	initialize();
});
function initialize(){
	$('#searchbt').on('click' ,searchfriend);
	$('#searchtx').keyup(searchword);
}
function openGUpdate(group_name) {
	var url = "groupPage?group_name=" + group_name;  
	location.href=url;
}
function searchfriend(){
	var text = $('#searchtx').val();
	$.ajax({
		url:'friend_check',
		type:'POST',		
		data:{id:text},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				location.href='./friend_get?id='+text;
			}
			else{
				alert('찾으시는 친구 ID가 없습니다.');
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function searchword(){
	var text = $('#searchtx').val();
	if(text.length >= 2){
		$.ajax({
			url:'jinsu/search_id',
			type:'POST',		
			data:{text:text},
			dataType:'json',
			success: function(array){
				$('#searchtx').autocomplete({
					source:array 
				});
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}
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
width:500px;
width: 540px;
margin-left: 180px;
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

img {
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
		<c:if test="${Member ne null}">
			<p><img src="<c:url value="/jinsu/img" />">${Member.getMember_id()} </p>
		</c:if>		
		<c:if test="${Member eq null}">
			<p><img src="http://1.bp.blogspot.com/-t9dmAueNbW0/VQYvJX7kVrI/AAAAAAAAGYY/Ou05G2Vi2kw/s1600/1%2B(3).jpg">ID </p>
		</c:if>
		<p>MYPAGE</p>
		<p>오늘의 랭킹</p>
		<p></p>
		<p>CATEGORY</p>
		<ul> 	
		<li>여행</li>
		<li>음식</li>				
		</ul>
	</div>	
	
	<!-- 앨범리스트 -->
	<div id="content">
		<form>
			<div class = "search">
			<input type="text" id="searchtx" placeholder = "검색어를 입력해주세요">
			<input type="button" value="검색" id="searchbt">
			테스트<br />
			<button id="myBtn">모달 열기</button>
	
			<div id="myModal" class="modal">
	                <span class="close">&times;</span>
	                <iframe src="albumView" allowTransparency='true' frameborder="0" width=100% height="100%"></iframe>
	        </div>
        </div>		
        </form>
							
		<div id = "albumList">				
				<table>
				<tr>	
					<td><img src = "./resources/image_mj/suji.jpg"></td>	
					<td>id</td>
				</tr>				
				</table>
				<table id = "table1">
				<tr>	
					<td><img src = "./resources/image_mj/suji2.jpg" class = "img_1"></td>
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
			
			<div>
			<table>
				<tr>	
					<td><img src = "./resources/image_mj/suji2.jpg" class = "img_1"></td>
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
		<div>
			<form id ="" method="" action="">
			<input type ="text" placeholder = "친구검색"  name="" value = "" class ="search1">
			<button>s</button>
			</form>		
			<c:if test="${Member ne null}">
				<c:if test="${fn:length(friend) ne 0}">
					<c:forEach var="arrf" items="${friend }">
						<div name="friend">
							<p onclick="openPChat('${arrf}', '')">${arrf}</p>
						</div>
					</c:forEach>
				</c:if>
			</c:if>
		</div>
		<div>
			<c:if test="${Member ne null}">
				<c:if test="${fn:length(group) ne 0}">
					<c:forEach var="arrg" items="${group}">
						<div name="group">
							<p onclick="openGUpdate('${arrg}')">${arrg}</p>
						</div>
					</c:forEach>
				</c:if>
			</c:if>
			<input type="button" value="그룹생성" onclick="window.open('./groupcreate_get?','','width=300 height=210 left=50% top=50% fullscreen=no,scrollbars=no,location=no,resizeable=no,toolbar=no')">
		</div>
	</div>
			<script>
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
        </script>

</body>
</html>
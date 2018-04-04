<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<script>
$(document).ready(function () {
	initialize();
});
function initialize(){
	$('#findid').keyup(searchword);
	$('#gmemberplus').on('click',memberplus);
	$('.img_3').on('click',memberdelete);
	$('#desolve').on('click',deleteparty);
}
function deleteparty(){
	var party_num = $('#desolve').attr('data');
	$.ajax({
		url:'delete_party',
		type:'POST',		
		data:{partynum:party_num},
		dataType:'text',
		success: function(list){
			if(list=='success'){
				location.href="./";
			}else{
				alert(list);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function memberdelete(){
	var member_id = $(this).attr('data');
	var party_num = $(this).attr('data2');
	$.ajax({
		url:'delete_member',
		type:'POST',		
		data:{memberid:member_id,partynum:party_num},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				$.ajax({
					url:'member_list_post',
					type:'POST',		
					data:{partynum:party_num},
					dataType:'json',
					success: function(list){
						var strmember='';
						$.each(list,function(i,data){
							strmember += '<p><img src = "<c:url value="/jinsu/memberimg?strurl='+(data.member_picture==null?'':data.member_picture)	+'"/>"></p><p>'+ data.member_id;
							strmember +='<img src = "./resources/image_mj/remove.png" class = "img_3" data="'+data.member_id+'" data2="'+party_num+'">';	
						});
						$('#memberdiv').html(strmember);
						$('#findid').val('');
						$('.img_3').on('click',memberdelete);
					},
					error:function(e){alert(JSON.stringify(e));}		
				});
			}else{
				alert(a);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function memberplus(){
	var member_id = $('#findid').val();
	var party_num = $('#gmemberplus').attr('data');
	$.ajax({
		url:'party_member_input',
		type:'POST',		
		data:{groupmember:member_id,partynum:party_num},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				$.ajax({
					url:'member_list_post',
					type:'POST',		
					data:{partynum:party_num},
					dataType:'json',
					success: function(list){
						var strmember='';
						$.each(list,function(i,data){
							strmember += '<p><img src = "<c:url value="/jinsu/memberimg?strurl='+(data.member_picture==null?'':data.member_picture)+'"/>"></p><p>'+ data.member_id;
							strmember +='<img src = "./resources/image_mj/remove.png" class = "img_3" data="'+data.member_id+'" data2="'+party_num+'">';	
						});
						$('#memberdiv').html(strmember);
						$('#findid').val('');
						$('.img_3').on('click',memberdelete);				
					},
					error:function(e){alert(JSON.stringify(e));}		
				});				
			}else{
				alert(a);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function searchword(){
	var text = $('#findid').val();
	if(text.length >= 1){
		$.ajax({
			url:'jinsu/search_id',
			type:'POST',		
			data:{text:text},
			dataType:'json',
			success: function(array){
				$('#findid').autocomplete({
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
		<c:if test="${partyinfo ne null}">${partyinfo.getParty_name()}</c:if>
		<c:if test="${partyleader ne null}">
			<p><img src = "<c:url value="/jinsu/memberimg?strurl=${partyleader.getMember_picture()}"/>"><c:if test="${partyleader ne null}">${partyleader.getMember_id()}</c:if></p>
		</c:if>	
		<div id="memberdiv">
		<c:if test="${fn:length(memberinfo) ne 0}">
			<c:forEach var="arrmi" items="${memberinfo}">
					<p><img src = "<c:url value="/jinsu/memberimg?strurl=${arrmi.getMember_picture()}"/>"></p><p>${arrmi.getMember_id()}
					<c:if test="${partyinfo.getParty_leader() eq Member.getMember_id()}">
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
</html>
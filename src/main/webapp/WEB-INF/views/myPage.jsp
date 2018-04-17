<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>My Page</title>
<meta charset="utf-8" />

<link rel="stylesheet" href="<c:url value="resources/css/myPage.css"/>">

<link rel="stylesheet" href="<c:url value="resources/aside_css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="resources/aside_css/open-iconic-bootstrap.min.css"/>">

<link rel="stylesheet" href="<c:url value="resources/aside_css/owl.carousel.min.css"/>">
<link rel="stylesheet" href="<c:url value="resources/aside_css/owl.theme.default.min.css"/>">

<link rel="stylesheet" href="<c:url value="resources/aside_css/icomoon.css"/>">
<link rel="stylesheet" href="<c:url value="resources/aside_css/animate.css"/>">
<link rel="stylesheet" href="<c:url value="resources/aside_css/style.css"/>">

<script src="<c:url value="resources/aside_js/popper.min.js"/>"></script>
<script src="<c:url value="resources/aside_js/bootstrap.min.js"/>"></script>
<script src="<c:url value="resources/aside_js/owl.carousel.min.js"/>"></script>
<script src="<c:url value="resources/aside_js/jquery.waypoints.min.js"/>"></script>
<script src="<c:url value="resources/aside_js/imagesloaded.pkgd.min.js"/>"></script>
<script src="<c:url value="resources/aside_js/main.js"/>"></script>

<script src="<c:url value="resources/js/jquery-3.3.1.min.js"/>"></script>

<script>

$(document).ready(function() {

	getMyAlbumList();
	
	
})

	//나의 앨범 리스트 Ajax로 받는 코드
function getMyAlbumList() {
	$.ajax({
		url: 'getMyAlbumList',
		type: 'post',
		dataType: 'json',
		success: function(result) {
			myAlbumList(result);
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

function myAlbumList(result) {
	
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
				$(a_read_album).attr('href', 'albumView?album_num=' + album_num + '').append(div_page);
				$(div_card).addClass('card img-loaded').append(a_read_album);
				$('.card-columns').append(div_card);
				
			}
			
		}
		
		sw = 0;
		
	});
	
}

</script>

</head>
<body>
	<div id="header">
	<h1>COOING</h1>
	</div>

	<!-- 왼쪽 사이드바 -->
	<div id="sidebar_a">
		<p><img src = "<c:url value="resources/image_mj/suji.jpg"/>">suji</p>
		<p>Profile</p>
		<p></p>
		<p></p>
		<p>ALBUM</p>
		<ul> 	
		<li>앨범1</li>
		<li>앨범2</li>						
		</ul>
		<p>+앨범추가		
	</div>	
	
	<!-- 앨범리스트 -->
	<div id="content">
	
		<div id="albumLayout">
		앨범 레이아웃
		<p><button>앨범만들기</button>			
		</div>
					
		<!-- 앨범 리스트 -->
		<div class="card-columns" id="card-columns">
			
				<!--  -->
				<div class="card">
					<a href="single.html">
						<img class="card-img-top probootstrap-animate" 
						src = "<c:url value="resources/aside_images/img_1.jpg"/>" alt="Card image cap">
					</a>
				</div>
				<div class="card">
					<a href="single.html">
						<img class="card-img-top probootstrap-animate" 
						src = "<c:url value="resources/image_mj/a1.jpg"/>" alt="Card image cap">
					</a>
				</div>
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
	
	<!-- 	
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
       -->

</body>
</html>
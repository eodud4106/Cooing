<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
<head>
<title>AlbumView</title>
<meta charset="utf-8" />
<meta name="viewport" content="width = 1050, user-scalable = no" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/open-iconic-bootstrap.min.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.carousel.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.theme.default.min.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/icomoon.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/animate.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/style.css"/>">
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/album_page_js/extras/modernizr.2.5.3.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/album_page_js/basic.js"/>"></script>		
<script defer src="<c:url value="https://use.fontawesome.com/releases/v5.0.10/js/all.js"/>"></script>


<script src="<c:url value="/resources/aside_js/popper.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/owl.carousel.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/jquery.waypoints.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/imagesloaded.pkgd.min.js"/>"></script>
<script src="<c:url value="/resources/aside_js/main.js"/>"></script>    

<link rel="stylesheet" href="<c:url value="/resources/skin_radio/green.css"/>">

<script>

$(document).ready(function() {
	getMyAlbumRead();
})

	//앨범 읽기 Ajax로 받는 코드
function getMyAlbumRead() {
	$.ajax({
		url: 'getMyAlbumRead',
		type: 'post',
		data:{num : ${album_num}},
		dataType: 'json',
		success: function(result) {
			myAlbumRead(result);
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

function myAlbumRead(result) {
	
	var page_num;
	var page_html;
	var sw = 0;
	
$(result).each(function(i, page) {
		
		page_num = i+1;
		page_html = page;
		
		alert(page_html);
		
		var page = document.createElement('div'); //페이지 클래스 div
		$(page).addClass('page');
		$(page).attr('id', 'page'+page_num).html(page_html);
		$('#flipbook').append(page);
		
	});
	
}

</script>

</head>
<body>



 <aside class="probootstrap-aside js-probootstrap-aside">
      <a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none"><span class="oi oi-arrow-left"></span> Close</a>
      <div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
        
        <a href="index.html" class="mb-2 d-block probootstrap-logo">COOING</a>
        <p class="mb-0">친구목록출력, 채팅기능 <a href="https://uicookies.com/" target="_blank">uiCookies</a></p>
      </div>
      <div class="probootstrap-overflow">
        <nav class="probootstrap-nav">
          <input type ="text" placeholder = "친구검색"  name="" value = "" class ="search">
			<button class = "bt">s</button>
        </nav>
        
        <p></p>			
				<p>친구1</p>
				<p>친구2</p>
				<p>친구3</p>
				<p>친구4</p>
		
				<p>그룹1</p>
				<p>그룹2</p>						 		
    	
        <footer class="probootstrap-aside-footer probootstrap-animate" data-animate-effect="fadeInLeft">
         
          <p>&copy; 2018 <a href="https://uicookies.com/" target="_blank">COOING</a>. <br> All Rights Reserved.</p>
        </footer>
      </div>
    </aside>
	  
    <div class="flipbook" id="flipbook">
	</div> 


<!-- 메인표지업로드 -->
<script type="text/javascript">

function loadApp() {

	// Create the flipbook
	$('.flipbook').turn({
		width:1200,
		height:600,
		elevation: 50,
		gradients: true,
		autoCenter: true
	});
}

// Load the HTML4 version if there's not CSS transform
yepnope({
	test : Modernizr.csstransforms,
	yep: ['resources/album_page_js/lib/turn.js'],
	nope: ['resources/album_page_js/lib/turn.html4.min.js'],
	both: ['resources/album_css/basic.css'],
	complete: loadApp
});

</script>    

</body>
</html>  
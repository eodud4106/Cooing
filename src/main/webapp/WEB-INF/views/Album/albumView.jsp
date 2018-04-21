<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
<head>
<title>AlbumEdit</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 기본 js -->
<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>

<script src="resources/aside_js/popper.min.js"></script>
<script src="resources/aside_js/owl.carousel.min.js"></script>
<script src="resources/aside_js/jquery.waypoints.min.js"></script>
<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>
<script src="resources/aside_js/main.js"></script>

<script src="resources/skin_radio/icheck.js"></script>

<!-- 페이지 넘김 효과를 위한 js -->
<script type="text/javascript" src="resources/js/turn.js"></script>

<!-- albumEdit 용 js -->
<script type="text/javascript" src="resources/js/albumEdit.js"></script>
<script type="text/javascript" src="resources/js_js/html2canvas.min.js"></script>
<!-- 기본 css -->
<link rel="stylesheet" href="resources/css/albumEdit.css">
<link rel="stylesheet" href="resources/css/jquery-ui.min.css">

<!-- 기타 css -->
<link rel="stylesheet" href="resources/album_css/album_edit_basic.css">
<link rel="stylesheet" href="resources/album_css/album_edit_drag_and_drop.css">

<link rel="stylesheet" href="resources/aside_css/bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/aside_css/icomoon.css">
<link rel="stylesheet" href="resources/aside_css/animate.css">
<link rel="stylesheet" href="resources/aside_css/style.css">

<link rel="stylesheet" href="resources/skin_radio/green.css">

<style type="text/css">

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
.input1 {
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
.input1:checked + label {
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
	width: 100%;
}
.container-fluid {
	padding: 0;
}

.view_wrapper {
	margin: 0;
	padding-left: 250px !important;
	display: flex;
	flex-wrap: wrap;
	width: 100%;
}
.album_wrapper {
	width: 100%;
}

.album_wrapper, .top_bar, .under_bar, .album {
	margin: auto;
	display: block;
}
.checkbox {
	font-size: 20px;
}
.page {
	background-color: #eee;
}
.outer {
	background-color: #aaa;
}
.div_reply, .div_reply form, .div_reply form input,
#resultDiv, #resultDiv table {
	position: relative;
}
</style>

<script>
	
	var selectcheck = true;


	//라디오버튼
	$(document).ready(function() {
		replyList();
		// alert(${album.album_num});	
		$('.input').iCheck({
			radioClass : 'iradio_square-green',
		// increaseArea: '20%' // optional

		});
		
		ready_album('view');
	
		/* check_likes(); */
		
	});
	// 좋아요 확인
	function check_likes() {
		
		var albumnum = ${album.album_num};
		
		$.ajax({
			url:'check_likes',
			type: 'GET',		
			data: {
				"likeit_albumnum": albumnum
			},
			dataType: 'text',
			success: function(a){
				alert(a);
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
	}
	// 좋아요
	function likes() {
		
		var albumnum = ${album.album_num};
				
		$.ajax({
			url:'likes',
			type: 'POST',		
			data: {
				"likeit_albumnum": albumnum
			},
			dataType: 'text',
			success: function(a){
				if(a == 'success'){
					alert("좋아요!");	
							
				}
				else{
					alert("좋아요 실패!");
				}
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
	}
	// 좋아요 취소
	function deletelikes(){

		var albumnum = ${album.album_num};
		
		$.ajax({
			url:'deleteLikes',
			type: 'POST',		
			data: {
				"likeit_albumnum": albumnum
			},
			dataType: 'text',
			success: function(a){
				if(a == 'success'){
					alert("좋아요 취소");
					
				}
				else{
					alert("좋아요 취소 실패");
				}
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
	}
	
	// 댓글 쓰기
	function writereply(){

		var conents = $('#contents').val();
		var albumnum = ${album.album_num};
		
		$.ajax({
			url:'writeReply',
			type: 'POST',		
			data: {
				"reply_albumnum": albumnum,
				"reply_contents": conents 
				
			},
			dataType: 'text',
			success: function(a){
				
				if(a == 'success'){
					// alert("댓글 등록");	
					replyList();		
				}
				else{
					alert('실패');
				}
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
	}
	//댓글 목록
	function replyList(){
		
		var albumnum = ${album.album_num};
		
		$.ajax({
			url:'listReply',
			type: 'get',		
			data: {
				"reply_albumnum": albumnum		
			},
			dataType: 'json',
			success: function(list){
				viewResult(list);
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
	}
	// 댓글 목록
	function viewResult(list){
		
		var str = '';
		
		str += '<table>';
		$(list).each(function(i, vo){
			str += '<tr>';
			str += '<td>';
			str += ' ' + vo.reply_memberid;
			str += ' ' + vo.reply_contents;
			/* str += ' ' + vo.reply_date; */
			if (vo.reply_memberid == '${Member.member_id}') {
			str += ' ' + "<input type='button' value='삭제' onclick='deletereply("+vo.reply_num+")'>";
			}
			str += '</td>';
			str += '</tr>';
		});
		str += '</table>';
		$("#resultDiv").html(str);
	}

	// 댓글 삭제
	function deletereply(replynum){

		// alert(replynum);
		
		if(confirm("댓글을 삭제 하시겠습니까?")){
			 	
			$.ajax({
				url:'deleteReply',
				type: 'POST',		
				data: {
					"reply_num": replynum
				},
				dataType: 'text',
				success: function(a){
					if(a == 'success'){
						// alert("댓글 삭제");	
						replyList();
					}
					else{
						alert("본인 글이 아닙니다.");
					}
				},
				error:function(e){
					alert(JSON.stringify(e));
				}		
			});
		} 
	}
	function checkRadioButton(iCheck){   
	   
	   var temp;
	   
	   var radioObj = document.all(iCheck);
	   
	   
	   var isChecked;
	   if(radioObj.length == null)
	   { // 라디오버튼이 같은 name 으로 하나밖에 없다면
	   isChecked = radioObj.checked;
	   }
	   else
	   { // 라디오 버튼이 같은 name 으로 여러개 있다면
	      for(var i=0; i<radioObj.length; i++)
	      {
	         if(radioObj[i].checked)
	         {
	            isChecked = true;
	            break;
	         }
	      }
	   }

	   if(isChecked){
		   alert('체크된거있음' + radioObj[i].value);
		   temp = radioObj[i].value; 
		   alert('템프 값 : ' + temp);
		   
		   //value값
		   switch (temp) {
		      case '1':
		         alert(temp);
		         $('.pages').css("background-image","url(..//resources//image_mj//season.jpg)"); 
		         break;
		         
		      case '2':
		         alert(temp);
		         $('.pages').css("background-color","pink");
		         break;
	
		      default:
		         alert(temp);
		         $('.pages').css("background-image","url(..//resources//image_mj//vintage.jpg)");
		         break;    
		   }
	   
	   }else{
			alert('체크된거없음');
	   }	 
	}

</script>

</head>
<body>

	<!-- 사이드 바 -->
	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="index.html" class="mb-2 d-block probootstrap-logo">COOING</a>
			<p class="mb-0"> 친구목록출력, 채팅기능
				<a href="https://uicookies.com/" target="_blank">uiCookies</a>
			</p>
		</div>
		<div class="probootstrap-overflow">
		<div class="main">

  		<input class = "input1" id="tab2" type="radio" name="tabs" checked>
    	<label for="tab2">채팅</label>   

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
				<form id="testimg">
					<input type="hidden" name="imgSrc" id="imgSrc" />
				</form>	
				<c:if test = "${check_isLike != Member.member_id}"> 
				<p><button type="button" onclick="likes()">좋아요!</button></p>
				</c:if> 
				<c:if test = "${check_isLike == Member.member_id}"> 
				<p><button type="button" onclick="deletelikes()">좋아요 취소!</button></p> 	
				</c:if> 
				<!-- 하단 바 영역 -->
				<div class="div_reply">
				<form>
				내용
				<input type="text" id="contents" class ="reply">
				<button type="button" onclick="writereply()">저장</button>
				<input type="hidden" name="reply_albumnum">
				</form>
				<div id="resultDiv">
				
				</div>
				</div>
				
				
    	</section>
    	</div>			

			<footer class="probootstrap-aside-footer probootstrap-animate" data-animate-effect="fadeInLeft">

				<p>
					&copy; 2018 <a href="https://uicookies.com/" target="_blank">COOING</a>
					<br> All Rights Reserved.
				</p>
			</footer>
		</div>
	</aside>

	<!-- 메인 -->
	<main role="main" class="probootstrap-main2 js-probootstrap-main">
		<div class="probootstrap-bar">
	
			<a href="#" class="probootstrap-toggle js-probootstrap-toggle">
				<span class="oi oi-menu"></span>
			</a>
			<div class="probootstrap-main-site-logo">
				<a href="index.html">COOING</a>
			</div>
	
		</div>
	
		<div class="container-fluid">
			<div class="view_wrapper">
			
				<!-- 앨범 영역 -->
				<div class="album_wrapper" id="album_wrapper">
					<div class="album" id="album" style="display: none">
						<c:if test="${arr_page.size() > 0 }">
							<c:forEach items="${arr_page}" var="page">
								<div id="page${page.page_num}" class="page hard">${page.page_html}</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
				

				<div class="under_bar">
					<div id="slider-bar" class="turnjs-slider">
						<div id="slider"></div>
					</div>
					<button>이전</button>
					<button>다음</button>
					<c:if test="${album.album_writer == sessionScope.Member.member_id }">
						<button onclick="location.href='albumEdit/edit_album?album_num=${album.album_num}'">편집</button>
					</c:if>
				</div>
				
				
			</div>
			<!-- END row -->
			
			
		</div>

	</main>

</body>
</html>

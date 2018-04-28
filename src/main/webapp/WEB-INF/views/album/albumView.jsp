<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
<head>
<title>AlbumView</title>
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

<link rel="stylesheet" href="resources/aside_css/bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/aside_css/icomoon.css">
<link rel="stylesheet" href="resources/aside_css/animate.css">
<link rel="stylesheet" href="resources/aside_css/style.css">
<!-- 아이콘 -->
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>
<!-- 친구 그룹 리스트 출력 -->
<link rel="stylesheet" href="resources/css/friend_list.css">


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
#resultReply, #resultReply table {
	position: relative;
}
.deleteLikes:after{
	font-size: 20px;
	height: 30px;	
}
.deleteLikes:after{
	content: "❤";
	left: 21px;
	top: 21px;
	color:#FF0000;
}
.likes:after{
	font-size: 20px;
	height: 30px;	
}
.likes:after{
	content: "❤";
	left: 21px;
	top: 21px;
	color:#D5D5D5;
}
.buttonHolder{
	float : left;
}
.img1{
	width:30px;
	height:30px;
}
</style>

<script>
	
	var p; //페이징 용 변수

	function hashtagCheck(){
		var title = '${album.album_name}';
		var content = $('#content').html();
		//일단 ' '로 나누고 맨 앞이 #인 문자를 찾아서 a태그를 앞뒤로 붙여서 더해서 다시 넣어준다
		//SearchController에 searchHashTag를 좀 고쳐야 된다.
		//일단 정보 창이 뜨면 해쉬태그를 달 예정 
		
		var splitedArray = content.split(' '); 
		var filter = /#[^#\s,;]+/gm;
		var linkedContent = '';
		for(var word in splitedArray)
		{
		   word = splitedArray[word];
			// # 문자를 찾는다.
		   if(word.match(filter) && word.charAt(0) == '#'){
			   var count = 1;
			   var tmp = word.replace(/\s|　/gi, ' ');
			   for(var i = 0; i < tmp.length; i++){
				   if(tmp.charAt(i)!='\r\n' && tmp.charAt(i) != ' ' && tmp.charAt(i)!='\t' && tmp.charAt(i)!='\n' && tmp.charAt(i)!='<')
					   count++;
				   else
					   	break;
			   }
			   var hashword = word.substring(1,count-1);
			   var hashwordother = word.substring(count-1,word.length);
			   word = '<a href="./hashtag_other?search='+ hashword+'">#' + hashword + '</a>' + hashwordother; 
		   }
		   linkedContent += word+' ';
		}
		$('#title').html(title);
		$('#content').html(linkedContent);
	}
	
	var selectcheck = true;

	//라디오버튼
	$(document).ready(function() {
		
		replyList();
		likesList();
		check_likes();
		
		hashtagCheck();
		
		$('#bookmarkButton').on('click' , function(){
			if($('#bookmarkButton').attr('data') == 1){
				bookmark_delete();
			}else{
				bookmark_create();
			}
		});
		
		 $('#album').on('change' , function(){
			alert('test');
		 });
		
		$('.input').iCheck({
			radioClass : 'iradio_square-green',
		// increaseArea: '20%' // optional

		});
		
		ready_album('view');

	});
	//현재 페이지의 북마크가 있는지 검색 
	function bookmark_check(){
		var albumnum = ${album.album_num};
		var pagenum = $('#album').turn('page');
		if(pagenum != null){
			pagenum = (pagenum==1?1:(pagenum%2==0?pagenum:pagenum-1));
			$.ajax({
				url:'bookmark_check',
				type: 'POST',		
				data: {
					bookmark_albumnum:albumnum,
					bookmark_page:pagenum
				},
				dataType: 'text',
				success: function(a){
					//성공이면 있는 거 책갈피가  data 가 1일때는 있는거 
					if(a == 'success'){
						//data값을 넣어서 data값으로 확인
						$('#bookmarkButton').attr('data' , 1);
						//책갈피 해제 이미지가 바뀐다면 여기 밑에 text를 없애고 사용
						$('#bookmarkButton').text('책갈피 해제');
					}
					//fail이면 없는 거 책갈피가 
					else{
						//data값을 넣어서 data값으로 확인
						$('#bookmarkButton').attr('data' , 0);
						//책갈피 해제 이미지가 바뀐다면 여기 밑에 text를 없애고 사용
						$('#bookmarkButton').text('책갈피');
					}					
				},
				error:function(e){
					alert(JSON.stringify(e));
				}		
			});		
		}
	}
	//책갈피
	function bookmark_create(){
		var albumnum = ${album.album_num};
		var pagenum = $('#album').turn('page');
		if(pagenum != null){
			pagenum = (pagenum==1?1:(pagenum%2==0?pagenum:pagenum-1));
			$.ajax({
				url:'bookmark_create',
				type: 'POST',		
				data: {
					bookmark_albumnum:albumnum,
					bookmark_page:pagenum
				},
				dataType: 'text',
				success: function(a){
					if(a == 'success'){
						//data값을 넣어서 data값으로 확인
						$('#bookmarkButton').attr('data' , 1);
						//책갈피 해제 이미지가 바뀐다면 여기 밑에 text를 없애고 사용
						$('#bookmarkButton').text('책갈피 해제');						
					}
				},
				error:function(e){
					alert(JSON.stringify(e));
				}		
			});		
		}
	}
	
	//책갈피삭제
	function bookmark_delete(){
		var albumnum = ${album.album_num};
		var pagenum = $('#album').turn('page');
		if(pagenum != null){
			pagenum = (pagenum==1?1:(pagenum%2==0?pagenum:pagenum-1));
			$.ajax({
				url:'bookmark_delete',
				type: 'POST',		
				data: {
					bookmark_albumnum:albumnum,
					bookmark_page:pagenum
				},
				dataType: 'text',
				success: function(a){
					if(a == 'success'){
						//data값을 넣어서 data값으로 확인
						$('#bookmarkButton').attr('data' , 0);
						//책갈피 이미지가 바뀐다면 여기 밑에 text를 없애고 사용
						$('#bookmarkButton').text('책갈피');						
					}
				},
				error:function(e){
					alert(JSON.stringify(e));
				}		
			});		
		}
	}
	
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
				console.log('조회 결과 -> ' + JSON.stringify(a));
				// 좋아요 했을 때
				if (a != "") {
					$('#likes').css('display', 'none');
				// 좋아요 안했을 때
				}	
				else { 
					$('#deleteLikes').css('display', 'none');
				}
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
				likesList();
				$('#likes').css('display', 'none');
				$('#deleteLikes').css('display', 'block');
				checklikes();
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});		
	}
	//좋아요 갯수 최신화
	function checklikes(){
		var albumnum = ${album.album_num};
		$.ajax({
			url:'count_like',
			type: 'POST',		
			data: {
				"likeit_albumnum": albumnum
			},
			dataType: 'text',
			success: function(a){
				$('#likecount').text(a);
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
				likeit_albumnum: albumnum
			},
			dataType: 'text',
			success: function(a){
				likesList();
				$('#likes').css('display', 'block');
				$('#deleteLikes').css('display', 'none');
				checklikes();
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});		
	}
	// 좋아요 목록
	function likesList(){
		
		var albumnum = ${album.album_num};
		
		$.ajax({
			url:'listLikes',
			type: 'get',		
			data: {
				"likeit_albumnum": albumnum		
			},
			dataType: 'json',
			success: function(likesList){
				var str = '';
				
				$(likesList).each(function(i, vo){
				str += vo.likeit_memberid + ' ';

				});
				str += '</table>';
				$("#resultLikes").html(str);
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
	}

	// 댓글 쓰기
	function writereply(){

		var contents = $('#contents').val();
		var albumnum = ${album.album_num};
		
		if (contents == "") {
			alert("댓글의 내용을 입력하세요.");
			return;
		}
		if (contents.length > 15) {
			alert("댓글은 15자 이내로 입력하세요.")
			return;
		}
		
		$.ajax({
			url:'writeReply',
			type: 'POST',		
			data: {
				"reply_albumnum": albumnum,
				"reply_contents": contents 
			},
			dataType: 'text',
			success: function(a){
				
				if(a == 'success'){
					// alert("댓글 등록");	
					$('#contents').val('');
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
	// 댓글 삭제
	function deletereply(replynum){		
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
	//댓글 목록
	function replyList(p){
		
		var rep_page = p;
		var albumnum = ${album.album_num};
		
		$.ajax({
			url:'listReply',
			type: 'get',		
			data: {
				"reply_albumnum": albumnum,
				"rep_page" : rep_page
			},
			dataType: 'json',
			success: function(replyList){
				var str = '';

				str += '<table>';
				
				$(replyList).each(function(i, vo){
					
					if(i < 0){
						p = vo.currentPage;
					}
					
					str += '<tr>';
					str += '<td>';
					str += ' ' + vo.reply_contents;
					str += '<br>';
					str += ' ' + vo.reply_memberid;
					/* str += ' ' + vo.reply_date; */
					if (vo.reply_memberid == '${Member.member_id}') {
						str += ' ' + "<i onclick='updatereply("+vo.reply_num+")' style = 'width: 15px; height: 15px; cursor:pointer;' class='far fa-check-circle'></i>";
						str += ' ' + "<i onclick='deletereply("+vo.reply_num+")' style = 'width: 15px; height: 15px; cursor:pointer;' class='far fa-trash-alt'></i>";
					}
					str += '</td>';
					str += '</tr>';
				});
				str += '</table>';
				$("#resultReply").html('');
				$("#resultReply").html(str);
				
				$("#reply_page").html('');
				
				if(typeof p == "undefined") {
					p = 1;
				}
				
				pageReply(p);//리스트 뿌려질 때 페이징도 같이 뿌려주기
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
	}
	
	// 페이징
	function pageReply(p){
		
		var albumnum = ${album.album_num};
		var rep_page = p;
		
		$.ajax({
			url:'pageReply',
			type: 'get',		
			data: {
				"reply_albumnum": albumnum,
				"rep_page" : rep_page
			},
			dataType: 'json',
			success: function(navi){
				
				var html = '';
				if(navi.endPageGroup > 1){
					html += '<a href="javascript:replyList(' + (navi.currentPage - navi.pagePerGroup) + ')" style="color: navy;">◁◁ </a>&nbsp;';
					html += '<a href="javascript:replyList(' + (navi.currentPage - 1) + ')" style="color: navy;">◀</a>&nbsp;';
				}
				for(var i=navi.startPageGroup; i<=navi.endPageGroup; i++) {
					if(i == navi.currentPage){
						html += '<a href="javascript:replyList('+ i +')" style="color: navy;"><b>' + i + '</b></a>&nbsp;';
					}
					else{
						html += '<a href="javascript:replyList('+ i +')" style="color: navy;">' + i + '</a>&nbsp;';
					}
				}
				if(navi.endPageGroup > 1){
					html += '<a href="javascript:replyList(' + (navi.currentPage + 1) + ')" style="color: navy;">▶</a>&nbsp;';
					html += '<a href="javascript:replyList(' + (navi.currentPage + navi.pagePerGroup) + ')" style="color: navy;">▷▷</a>';
				}
				$('#reply_page').html('');
				$('#reply_page').append(html);
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
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
<body style ="font-family: 'Nanum Gothic Coding', monospace;">

	<!-- 사이드 바 -->
	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="/www" class="mb-2 d-block probootstrap-logo" style = "font-family: Poppins-Bold;">COOING</a>			
		</div>
		<div class="probootstrap-overflow">
		<div class="main">
		<input class = "input1" id="tab1" type="radio" name="tabs" checked> <!--디폴트 메뉴-->
		<label for="tab1">Comment</label>

  		<input class = "input1" id="tab2" type="radio" name="tabs" >
    	<label for="tab2">Chat</label>   
    	<section id="content1"> 
    	
    	<div>
    	<!-- 앨범 만든사람 아이디와 프로필사진 -->    	
    	<img class="img-responsive img-circle" style =" border-radius: 100%; display: inline-block;; width: 100% \9;
    				width: 25%; height: 25%;" src="<c:url value="/memberimg?strurl=${albumwrite.member_picture}" />" class="img1">${albumwrite.member_id}
    	<!-- 앨범제목, 앨범내용, 태그 -->
    	<div class = "album_content" style = "height:150px;">
    		<table>
    		<tr><th id="title"></th></tr>
    		<tr><td id="content">${album.album_contents}</td></tr>
    		</table>
    	</div>
    	
    	</div>
    	<div class="buttonHolder" id = "likes" onclick="likes()">
  			<a href="#" class="likes"></a>
		</div>
		<div class="buttonHolder" id = "deleteLikes" onclick="deletelikes()">
  			<a href="#" class="deleteLikes"></a>
		</div>				
		<span id="likecount">${likecount}</span>명
		<!-- <div id="resultLikes">	
		</div> -->
		<!-- 하단 바 영역 -->
		<div class="reply_page_div" id="reply_page_div" style = "float : left;">
			<form>		
			<!-- 로그인한 사람 프로필 사진만 -->
				<img class="img-responsive img-circle" style =" border-radius: 100%; display: inline-block; width: 100% \9;
    				width: 15%; height: 25%;"src="<c:url value="/img_member" />" class="img1">	
				<input type="text" id="contents" class ="reply" style ="width: 130px;"placeholder="comment...">
				<i onClick="writereply()" style = "width: 20px; height: 20px; cursor:pointer; margin-left: 180px;" class="far fa-check-circle"></i> 
				<!-- <button type="button" onclick="writereply()">저장</button> -->
				<input type="hidden" name="reply_albumnum">
			</form>
			
			<div id="resultReply" style = "height: 150px;"><!-- 댓글리스트 출력 -->
			</div>
			
			<div id="reply_page"> <!-- 댓글 페이지 -->
			</div>
	
		</div>
		</section>
		
   		<section id="content2">
       		<!-- <form id ="" method="" action="">
			<input type ="text" placeholder = "친구검색"  name="" value = "" class ="search">
			<button class = "bt">s</button>
			</form>					
				<p></p>			
				<p>친구1</p>
				<p>친구2</p>
				<p>친구3</p>
				<p>친구4</p>
		
				<p>그룹1</p>
				<p>그룹2</p>	 -->
				<form id="testimg">
					<input type="hidden" name="imgSrc" id="imgSrc" />
				</form>	
				
				<p class="mb-2 d-block probootstrap-logo" style = "text-align: center; font-size: 20px; padding: 0px 0px 0px 0px;font-family: Poppins-Bold;">MY FRIEND</p>			
				 <form>
					&nbsp<input type="text" placeholder="친구검색" id="friendsearch" class="search1" >
					<div>
       			  <img id="image_search" src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png" style="width: 24px;
       			 height: 24px;margin-left: 180px; margin-top: -50px;">
				</form>	
			<div class = "friendList" style = "width: 200px;">
				<div name="friend" id="friend">
				</div>
				<div name="user" id="user">
				</div>
			</div>
		
			<p class="mb-2 d-block probootstrap-logo" style = "text-align: center; font-size: 20px; padding: 20px 0px 0px 0px; font-family: Poppins-Bold;">MY GROUP</p>				
		
			<div class = "groupList" style= "margin-top: 20px; width: 200px;">
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

	</aside>
	
	<div class="popuplayer">
		<p onClick="friendpage()" style="font-size:8pt;color:#26afa1;">친구페이지</p>
		<p onClick="chatpage()" style="font-size:8pt;color:#26afa1;">채팅</p>
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
				<c:if test="${check ne 2}">
					<button id="bookmarkButton" data="${check}">
						<c:if test="${check eq 1}">	
							책갈피 해제
						</c:if>
						<c:if test="${check eq 0}">	
							책갈피
						</c:if>
					</button>
				</c:if>
					<div class="album" id="album" style="display: none">
						<c:if test="${arr_page.size() > 0 }">
							<c:forEach items="${arr_page}" var="page">
								<div id="page${page.page_num}" class="page hard" style="background-image: ${page.page_background}">${page.page_html}</div>
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
						<button onclick="location.href='edit_album?album_num=${album.album_num}'">편집</button>
					</c:if>
				</div>
				
				
			</div>
			<!-- END row -->
			
			
		</div>

	</main>

</body>
</html>

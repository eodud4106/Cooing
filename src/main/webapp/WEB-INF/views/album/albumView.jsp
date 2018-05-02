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
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 기본 js -->
<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>
<script src="resources/aside_js/popper.min.js"></script>
<script src="resources/aside_js/owl.carousel.min.js"></script>
<script src="resources/aside_js/jquery.waypoints.min.js"></script>
<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>
<script src="resources/aside_js/main.js"></script>
<script src="resources/js/chat.js"></script>
<script src="resources/js/push.js"></script>
<script src="resources/skin_radio/icheck.js"></script>
<!-- 페이지 넘김 효과를 위한 js -->
<script type="text/javascript" src="resources/js/turn.js"></script>
<!-- 친구 그룹창을 위한 js -->
<script src="resources/js/search.js"></script>
<script src="resources/js/popup.js"></script>
<!-- albumEdit 용 js -->
<script type="text/javascript" src="resources/js/albumEdit.js"></script>
<script type="text/javascript" src="resources/js_js/html2canvas.min.js"></script>

<!-- 기본 css -->
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/albumEdit.css">
<link rel="stylesheet" href="resources/css/jquery-ui.min.css">
<link rel="stylesheet" href="resources/aside_css/bootstrap.min.css"><link rel="stylesheet"
	href="resources/aside_css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/aside_css/icomoon.css">
<link rel="stylesheet" href="resources/aside_css/animate.css">
<link rel="stylesheet" href="resources/aside_css/style.css">
<link rel="stylesheet" href="resources/css/albumEdit.css">
<link rel="stylesheet" href="resources/css/chat.css">
<link rel="stylesheet" href="resources/css/push.css">
<!-- 친구 그룹 리스트 출력 -->
<link rel="stylesheet" href="resources/css/friend_list.css">

<!--앨범 생성하기 =======================================================================================-->
<link rel="icon" type="image/png" href="resources/assets/images/cooing_logo.png"/>
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/album_create/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/album_create/vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/album_create/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/album_create/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/album_create/vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/album_create/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/album_create/css/util.css">
<link rel="stylesheet" type="text/css"
	href="resources/album_create/css/main.css">
<!--===============================================================================================-->
<style type="text/css">
#image_search {
	cursor: pointer;
}
.main {
	min-width: 200px;
	max-width: 200px;
	padding: 10px;
	margin: 0 auto;
	background: #ffffff;
}

section {
	display: none;
	padding: 20px 0 0;
	font-size: 14px;
	border-top: 1px solid #ddd;
}

.div_reply, .div_reply form, .div_reply form input, #resultReply,
	#resultReply table {
	position: relative;
}

.deleteLikes:after {
	font-size: 20px;
	height: 30px;
}

.deleteLikes:after {
	content: "❤";
	left: 21px;
	top: 21px;
	color: #FF0000;
}

.likes:after {
	font-size: 20px;
	height: 30px;
}

.likes:after {
	content: "❤";
	left: 21px;
	top: 21px;
	color: #D5D5D5;
}

.buttonHolder {
	float: left;
}

.img1 {
	width: 30px;
	height: 30px;
}
.wrap-contact100-form-btn {
height: 30px;
}
/* 페이지별 배경이미지 꽉 채우기 */
.page{
	background-repeat: no-repeat !important;
	background-size:100% 100% !important;
}
</style>


<script>
	var p; //페이징 용 변수
	var album_num = '${album.album_num}';

	function hashtagCheck(){
		var content = $('#album_contents').html();
		//일단 ' '로 나누고 맨 앞이 #인 문자를 찾아서 a태그를 앞뒤로 붙여서 더해서 다시 넣어준다
		//SearchController에 searchHashTag를 좀 고쳐야 된다.
		//일단 정보 창이 뜨면 해쉬태그를 달 예정 \
		var splitedArray = content.split('#'); 
		var filter = /#[^#\s,;]+/gm;
		var linkedContent = splitedArray[0];
		for(var i = 1; i < splitedArray.length; i++)
		{
			var word = splitedArray[i];
		 	// # 문자를 찾는다.
		   	var end = 0;
		   	for(var j = 0; j < word.length; j++){
			   if(end == 0 && (word.charAt(j) == ' '||  word.charAt(j) == '<' || word.charAt(j)=='\n' || word.charAt(j)=='\r\n')){
				   end = j;
			   }
		   	}
		   	var hashword_be = word.substring(0,end);
		   	var hashword_af = word.substring(end,word.length);
		   	if(end == 0){
		   		hashword_be = word.substring(0,word.length);
		   		hashword_af = '';
		   	}
		   	word ='<a href="./?search='+ hashword_be+'">#' + hashword_be + '</a>' + hashword_af;
		   
		   	linkedContent += word+' ';
		}
		$('#album_contents').html(linkedContent);
	}
	
	var selectcheck = true;
	var page_num = '${page_num}';
	//라디오버튼
	$(document).ready(function() {
		// 경고!! 아래 구문 절대 지우거나 옮기지 마세요!
		if ('${sessionScope.Member}' != null) {
			readyChat('${sessionScope.Member.member_id}', '');
			readyPush('${sessionScope.Member.member_id}', '');
		}
		//댓글 15자 넘으면 alert창으로 막기
		$('#input_reply').on('keyup', function() {
	        if($(this).val().length > 15) {
	            $(this).val($(this).val().substring(0, 15));
	            alert('댓글은 최대 15자까지 입력하실 수 있습니다.');
	        }
	    });
		
		ready_album('view');
		
		replyList();
		
		if(page_num != ''){
			$('#album').turn('page', page_num);
		}

		hashtagCheck();
		
		bookmark_check();

		$('.input').iCheck({
			radioClass : 'iradio_square-green',
		// increaseArea: '20%' // optional

		});
		
		searchword();
		searchgroup();
		
		$('#friendsearch').keyup(function() {
			searchword();
		});
		nowpage();
	});
	
	//앨범 뷰 친구 추가
	function fiendplus(){
		var friendid = $('#friendidval').val();
		var data = $('#friendbt').attr('data');
		if(data == 0){
			//TODO 친구 요청..
			sendPush($('#user_id').val(), friendid, 1, '우리 친구해요');
			alert('친구 요청을 보냈습니다!');
			
			$.ajax({
				url:'albumView_friend_plus',
				type:'POST',		
				data:{friendid:friendid},
			dataType:'text',
				success: function(a){
				if(a=='success'){
						$('#friendbt').html('<i class="fas fa-user-times"></i>');
						$('#friendbt').attr('data' , '1');
						searchword();
					}
					else{
						alert(a);
					}
				},
				error:function(e){alert(JSON.stringify(e));}		
			});
		}else if(data == 1){
			$.ajax({
				url:'albumView_friend_delete',
				type:'POST',		
				data:{friendid:friendid},
				dataType:'text',
				success: function(a){
					if(a=='success'){
						$('#friendbt').html('<i class="fas fa-user-plus"></i>');
						$('#friendbt').attr('data' , '0');
						searchword();
					}
					else{
						alert(a);
					}
				},
				error:function(e){alert(JSON.stringify(e));}		
			});
		}	
	}
	
	//현재 페이지의 북마크가 있는지 검색 
	function bookmark_check() {

		var pagenum = $('#album').turn('page');
		if (pagenum != null) {
			pagenum = (pagenum == 1 ? 1 : (pagenum % 2 == 0 ? pagenum
					: pagenum - 1));
			$.ajax({
				url : 'bookmark_check',
				type : 'POST',
				data : {
					bookmark_albumnum : album_num,
					bookmark_page : pagenum
				},
				dataType : 'text',
				success : function(a) {
					//성공이면 있는 거 책갈피가  data 가 1일때는 있는거
					$('#i_bookmark').html('');
					var $icon = $('<i />').css({
						"width": "30px",
						"height": "30px",
						"margin": "10px"
					}).appendTo($('#i_bookmark'));
					
					if (a == 'success') {
						$icon.addClass("fas fa-check");
						$('#i_bookmark').attr('role' , '책갈피 제거');
					}
					//fail이면 없는 거 책갈피가 
					else {
						$icon.addClass("fas fa-plus");
						$('#i_bookmark').attr('role' , '책갈피 추가');
					}
				},
				error : function(e) {
					alert(JSON.stringify(e));
				}
			});
		}
	}
	
	//책갈피 토글
	function bookmark_toggle() {
		var pagenum = $('#album').turn('page');
		var isMarked = $('#i_bookmark').attr('role') == '책갈피 추가' ? 'bookmark_create' : 'bookmark_delete'
		if (pagenum != null) {
			pagenum = (pagenum == 1 ? 1 : (pagenum % 2 == 0 ? pagenum
					: pagenum - 1));
			$.ajax({
				url : isMarked,
				type : 'POST',
				data : {
					bookmark_albumnum : album_num,
					bookmark_page : pagenum
				},
				dataType : 'text',
				success : function(a) {
					if (a == 'success') {
						$('.tooltip_under_bar').remove();
						$('#i_bookmark').html('');
						var $isMarked = $('<i />').css({
							"width": "30px",
							"height": "30px",
							"margin": "10px"
						}).appendTo($('#i_bookmark'));
						
						if(isMarked == 'bookmark_create') {
							$isMarked.addClass('fas fa-check');
							$('#i_bookmark').attr('role', '책갈피 제거');
						} else {
							$isMarked.addClass('fas fa-plus');
							$('#i_bookmark').attr('role', '책갈피 추가');
						}
						
					}
				},
				error : function(e) {
					alert(JSON.stringify(e));
				}
			});
		}
	}
	
	
	// 좋아요...??
	function addLike() {
		$.ajax({
			url : 'addLike',
			type : 'POST',
			data : {
				"album_num" : album_num
			},
			dataType : 'json',
			success : function(result) {
				$('#curr_like').text(' ' + result.totalLike);
				if(result.isLike == 1) {
					$('#isLike').text('♥');
				} else {
					$('#isLike').text('♡');
				}
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}

	// 댓글 쓰기
	function writereply() {

		var contents = $('#input_reply').val();

		if (contents.length == 0) {
			alert("댓글의 내용을 입력하세요.");
			return;
		}
		if (contents.length > 15) {
			alert("댓글은 15자 이내로 입력하세요.")
			return;
		}

		$.ajax({
			url : 'writeReply',
			type : 'POST',
			data : {
				"reply_albumnum" : album_num,
				"reply_contents" : contents
			},
			dataType : 'text',
			success : function(a) {
				
				if (a == 'success') {
					// alert("댓글 등록");	
					$('#input_reply').val('');
					replyList();
				} else {
					alert('실패');
				}
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}
	// 댓글 삭제
	function deletereply(replynum) {
		if (confirm("댓글을 삭제하시겠습니까?")) {
			$.ajax({
				url : 'deleteReply',
				type : 'POST',
				data : {
					"reply_num" : replynum
				},
				dataType : 'text',
				success : function(a) {
					if (a == 'success') {
						// alert("댓글 삭제");	
						replyList();
					} else {
						alert("본인 글이 아닙니다.");
					}
				},
				error : function(e) {
					alert(JSON.stringify(e));
				}
			});
		}
	}
	// 댓글 신고
	function sirenreply(replynum) {
		alert("악성 댓글로 신고되었습니다. 해당 댓글은 검토 후 처리하겠습니다.")
	}
	// 댓글 목록
	function replyList(p) {
		var rep_page = p; 
	    $.ajax({ 
			url : 'listReply', 
			type : 'get', 
			data : { 
				"reply_albumnum" : album_num, 
				"rep_page" : rep_page 
			}, 
			dataType : 'json', 
			success : function(replyList) {
				
				$('#div_reply_list').html('');
	 
				$(replyList).each(function(i, reply) { 
	 
					var $reply_wrapper = $('<div />', {
						"class": "reply_wrapper",
						"reply_num": reply.reply_num
					}).appendTo($('#div_reply_list'));
	          		var $reply_text = $('<div />', {
	          			"class": "reply_text",
	          			"text": reply.reply_contents
	          		}).appendTo($reply_wrapper);
	          		var $reply_writer = $('<div />', {
	          			"class": "reply_writer",
	          			"html": reply.reply_memberid
	          		}).appendTo($reply_wrapper).css({
	          			"text-align": "right"
	          		});
	          		// 댓글 삭제
	          		if(reply.reply_memberid == '${sessionScope.Member.member_id}') {
	          			
		          		var $i_delete = $('<i />', {
		          			"class": "far fa-trash-alt"
						}).css({
							"width": "15px",
							"height": "15px",
							"cursor": "pointer"
						});		

		          		var $tmp_div = $('<div />').append($i_delete, $i_siren).appendTo($reply_writer).css({
		          			"display": "inline"
		          		}).click(function(e) {
							deletereply($(this).parent().parent().attr('reply_num'));
						})
	          		}
	          		// 댓글 신고	          	
					if(reply.reply_memberid != '${sessionScope.Member.member_id}') {
	          					          		
		          		var $i_siren = $('<i />', {
		          			"class" : "fas fa-lightbulb"
		          		}).css({
							"width": "15px",
							"height": "15px",
							"cursor": "pointer",
							"color" : "red"
						});		
		          	
						var $tmp_div = $('<div />').append($i_siren).appendTo($reply_writer).css({
		          			"display": "inline"
		          		}).click(function(e) {
							sirenreply($(this).parent().parent().attr('reply_num'));
						})
	          		}
	          	});
	 
		        if (typeof p == "undefined") { 
					p = 1; 
		        } 
		 
		        pageReply(p);//리스트 뿌려질 때 페이징도 같이 뿌려주기 
			}, 
			error : function(e) { 
				alert(JSON.stringify(e)); 
			} 
		}); 
	}
	// 페이징
	function pageReply(curr_page) {

		var rep_page = p;

		$.ajax({
			url : 'pageReply',
			type : 'get',
			data : {
				"reply_albumnum" : album_num,
				"rep_page" : rep_page
			},
			dataType : 'json',
			success : function(navi) {
				
				$('#div_reply_paging').html('');
				
				var $paging_wrapper = $('<div />', {
					"class": "paging_wrapper"
				}).css({
					"text-align": "center"
				}).appendTo($('#div_reply_paging'));
				
				if(curr_page > 1) {
					var $go_first = $('<a />', {
						"href": "javascript:replyList(1)",
						"text": "◀"
					}).appendTo($paging_wrapper);
					var $go_before = $('<a />', {
						"href": "javascript:replyList(" + (curr_page - 1) + ")",
						"text": "◁"
					}).appendTo($paging_wrapper);
				}
				
				for (var i = navi.startPageGroup; i <= navi.endPageGroup; i++) {
					var $go_page = $('<a />', {
						"href": "javascript:replyList(" + i + ")",
						"text": i
					}).appendTo($paging_wrapper);
					if(i == curr_page) {
						$go_page.css({
							"font-weight": "bold"
						})
					}
				}
				
				if(curr_page < navi.totalPageCount) {
					var $go_next = $('<a />', {
						"href": "javascript:replyList(" + (curr_page + 1) + ")",
						"text": "▷"
					}).appendTo($paging_wrapper);
					var $go_end = $('<a />', {
						"href": "javascript:replyList(" + navi.totalPageCount + ")",
						"text": "▶"
					}).appendTo($paging_wrapper);
				}
				
				$paging_wrapper.children().css({
					"margin" : "3px"
				})

			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}
</script>

</head>
<body style ="font-family: 'Nanum Gothic Coding', monospace;">

	<!-- 사이드 바 -->
	<aside class="probootstrap-aside js-probootstrap-aside" style = "background-color: aliceblue;">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate"
			data-animate-effect="fadeInLeft" style="padding-bottom: 0;">			
			<a href="/www" class="mb-2 d-block probootstrap-logo">COOING</a>
		</div>
		<div class="probootstrap-overflow">
			<div class="main">
				<!-- 왼쪽 대 메뉴 3가지 -->
				<input class="input1" id="tab1" type="radio" name="tabs" checked>
				<label for="tab1" style = "font-size: 13px;">Album</label> 
				
				<input class="input1" id="tab2" type="radio" name="tabs">
				<label for="tab2" style = "font-size: 13px;">Chat</label>
				
				<input class="input1" id="tab3" type="radio" name="tabs">
				<label for="tab3" style = "font-size: 13px;">NEWS</label>
				
				<section id="content1">

					<!-- 페이지 저장 -->
					<div class="contact100-form validate-form" id="entry">
						<span class="contact100-form-title" style="font-size: 15pt; margin-top: 0px"> ${album.album_name } </span>
					</div>

					<!-- 앨범 정보 -->
					<div class="wrap-input100 validate-input">
						<span class="label-input100"><img src="${profile_url}" style="width: 30px; height: 40px;"></span>
						<span class="label-input100">${album.album_writer }</span>
						

					<!-- 앨범 작성자와 보는 사람이 나였을 때 -->
					<c:if test="${friend_id.getMember_id() eq sessionScope.Member.member_id}">
					</c:if>
					<!-- 앨범 작성자와 보는 사람이 내가 아닐 때 -->
					<c:if test="${friend_id.getMember_id() ne sessionScope.Member.member_id}">
						<c:if test="${checks ne true }">
							<button style="z-index: 99; float: right; margin-top:10px; cursor: pointer;"
								id="friendbt" data="0" onclick="fiendplus()">
								<i class="fas fa-user-plus"></i>
							</button>					
						</c:if>
						<c:if test="${checks eq true }">					
							<button style="z-index: 99; float: right; margin-top:10px; cursor: pointer;"
								id="friendbt" data="1" onclick="fiendplus()">
								<i class="fas fa-user-times"></i>
							</button>
						</c:if>
					</c:if>				

					<input type="hidden" value="${friend_id.getMember_id()}"
					id="friendidval">
					<input style="display: none" id="user_id" value="${sessionScope.Member.member_id }">
					
					

					<div class="wrap-input100 validate-input">					
						<div class="input100" name="album_contents"
							id="album_contents"
							class="input_album_info input_album_info_contents"
							contenteditable="false" style="min-height: 100px">${album.album_contents}</div>
						<span class="focus-input100"></span>
					</div>
					
					<!-- 좋아요 -->
					<div class="wrap-contact100-form-btn bt_hindoong">
						<div class="contact100-form-bgbtn"></div>
						<button class="contact100-form-btn bt_album_info"
							onclick="addLike()">
							<span>
								좋아요
								<span id="isLike">
									<c:if test="${like.isLike == 1 }">
									♥
									</c:if>
									<c:if test="${like.isLike == 0 }">
									♡
									</c:if>
								</span>
								<span id="curr_like"> ${like.totalLike }</span>
							</span>
						</button>
					</div>
					<span class="focus-input100"></span>
					
					<!--  댓글 영역 -->
					<div class="wrap-input100 validate-input">
												
						<!-- 불러온 댓글 보여줄 영역 -->
						<div id="div_reply_list" style = "font-family: Poppins-Regular; height: 200px;"></div>
						<!-- 페이징 버튼 영역 -->
						<div id="div_reply_paging"></div>
					</div>
					<div class="wrap-input100 validate-input">	
						<textarea class="input100" id="input_reply"
							class="input_album_info input_album_info_contents"
							style="padding-bottom: 5px; min-height: 10px" placeholder="댓글을 작성해보세요..."
							maxlength="20"></textarea>
						<span class="focus-input100"></span>
					</div>

					<div class="wrap-contact100-form-btn">
						<div class="contact100-form-bgbtn"></div>
						<button class="contact100-form-btn bt_album_info"
							onclick="writereply()">
							<span>
								댓글
							</span>
						</button>
					</div>

				</section>

				<section id="content2">
				
					<form id="testimg">
						<input type="hidden" name="imgSrc" id="imgSrc" />
					</form>

					<p class="mb-2 d-block probootstrap-logo"
						style="text-align: center; font-size: 20px; padding: 0px 0px 0px 0px; font-family: 'Nanum Gothic Coding', monospace;">MY
						FRIEND</p>
					<form>
						&nbsp<input type="text" placeholder="친구검색" id="friendsearch"
							class="search1">
						<div>
							<img id="image_search"
								src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png"
								style="width: 24px; height: 24px; margin-left: 180px; margin-top: -50px;">
						</div>
					</form>
					<div class="friendList" style="width: 200px;">
						<div name="friend" id="friend"></div>
						<div name="user" id="user"></div>
					</div>

					<p class="mb-2 d-block probootstrap-logo"
						style="text-align: center; font-size: 20px; padding: 20px 0px 0px 0px; font-family: 'Nanum Gothic Coding', monospace;">MY
						GROUP</p>

					<div class="groupList" id="group" style="margin-top: 20px; width: 200px;">
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

	<!-- 메인 -->
	<main role="main" class="probootstrap-main2 js-probootstrap-main">
	<div class="probootstrap-bar">

		<a href="#" class="probootstrap-toggle js-probootstrap-toggle"> <span
			class="oi oi-menu"></span>
		</a>
		<div class="probootstrap-main-site-logo">
			<a href="/www">COOING</a>
		</div>

	</div>

	<div class="container-fluid">
		<div class="view_wrapper">
			<div id="slider-bar" class="turnjs-slider" style="width: 300px; margin-top: -15px; padding-bottom: 25px; margin-left: 350px;">
					<div id="slider" ></div>
			</div>
	 		<!-- 진수가만든 바... -->
			<!-- <div style="text-align:center">
				<input type="text" id="left_page" width="10px" height="10px">
				<input type="text" id="right_page" width="10px" height="10px">
				<input type="text" id="total_page" width="10px" height="10px">
			</div> -->
			<!-- 앨범 영역 -->
			<div class="album_wrapper" id="album_wrapper">
				<div class="album" id="album" style="display: none">
					<c:if test="${arr_page.size() > 0 }">
						<c:forEach items="${arr_page}" var="page">
							<div id="page${page.page_num}" class="page hard"
								style='background-color: ${page.page_color}; background-image: ${page.page_background};'>${page.page_html}</div>
						</c:forEach>
					</c:if>
				</div>
			</div>

		</div>
		<!-- END row -->
		<!-- 하단 바 영역 -->
		<div style="margin-right: 20px; float:right">
			<div class="under_bar">
				 			
				<!-- 각종 버튼 -->
				<!--
				<div id="i_before" class="under_tool" onclick="go_page('first')" role="첫 페이지">
					<i style="width: 30px; height: 30px; margin: 10px;"
						class="fas fa-angle-double-left"></i>
				</div>
				<div id="i_before" class="under_tool" onclick="go_page('before')" role="이전 페이지">
					<i style="width: 30px; height: 30px; margin: 10px;"
						class="fas fa-angle-left"></i>
				</div>
				<div id="i_next" class="under_tool" onclick="go_page('next')" role="다음 페이지">
					<i style="width: 30px; height: 30px; margin: 10px;"
						class="fas fa-angle-right"></i>
				</div>
				<div id="i_before" class="under_tool" onclick="go_page('end')" role="마지막 페이지">
					<i style="width: 30px; height: 30px; margin: 10px;"
						class="fas fa-angle-double-right"></i>
				</div>
				-->
				<c:if test="${album.isPersonal == 1 }">
					<c:if test="${sessionScope.Member.member_id == album.album_writer}">
						<div id="i_edit" class="under_tool" onclick="location.href='edit_album?album_num=${album.album_num}'" role="편집">
							<i style="width: 30px; height: 30px; margin: 10px;"
								class="fas fa-pencil-alt"></i>
						</div>
					</c:if>
				</c:if>
				<c:if test="${album.isPersonal == 0 }">
					<c:if test="${isPartymember == 1 }">
						<div id="i_edit" class="under_tool" onclick="location.href='edit_album?album_num=${album.album_num}'" role="편집">
							<i style="width: 30px; height: 30px; margin: 10px;"
								class="fas fa-pencil-alt"></i>
						</div>
					</c:if>
				</c:if>
				<div id="i_bookmark" class="under_tool" onclick="bookmark_toggle()" role="책갈피 추가">
					<i style="width: 30px; height: 30px; margin: 10px;"
						class="fas fa-plus"></i>
				</div>
			
			</div>
		</div>

	</div>

	</main>

</body>
</html>

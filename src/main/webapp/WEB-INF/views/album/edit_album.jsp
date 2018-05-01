<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
<head>
<title>AlbumEdit</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 기본 js -->
<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui.min.js"></script>
<script defer
	src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>

<script src="resources/aside_js/popper.min.js"></script>
<script src="resources/aside_js/owl.carousel.min.js"></script>
<script src="resources/aside_js/jquery.waypoints.min.js"></script>
<script src="resources/aside_js/imagesloaded.pkgd.min.js"></script>
<script src="resources/aside_js/main.js"></script>

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
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">
<link rel="stylesheet" href="resources/css/albumEdit.css">
<link rel="stylesheet" href="resources/css/jquery-ui.min.css">

<link rel="stylesheet" href="resources/aside_css/bootstrap.min.css">
<link rel="stylesheet"
	href="resources/aside_css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet"
	href="resources/aside_css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/aside_css/icomoon.css">
<link rel="stylesheet" href="resources/aside_css/animate.css">
<link rel="stylesheet" href="resources/aside_css/style.css">

<link rel="stylesheet" href="resources/skin_radio/green.css">
<!-- 친구, 그룹 리스트 출력 -->
<link rel="stylesheet" href="resources/css/friend_list.css">

<!--앨범 생성하기 =======================================================================================-->
<link rel="icon" type="image/png"
	href="resources/album_create/images/icons/favicon.ico" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/album_create/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/album_create/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
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

/*라디오버튼 숨김*/
.input1 {
	display: none;
}

label {
	display: inline-block;
	margin: 0 0 -1px;
	padding: 5px 10px;
	font-weight: 600;
	text-align: center;
	color: #bbb;
	border: 1px solid transparent;
	font-size: 15px;
}

label:hover {
	color: #2e9cdf;
	cursor: pointer;
}

/*input 클릭시, label 스타일*/
.input1:checked+label {
	color: #555;
	border: 1px solid #ddd;
	border-top: 2px solid #2e9cdf;
	border-bottom: 1px solid #ffffff;
}

#tab1:checked ~ #content1, #tab2:checked ~ #content2, #tab3:checked ~ #content3 {
	display: block;
}

.search {
	width: 120px;
	display: block;
	position: absolute;
}

.bt {
	position: absolute;
	right: 40px;
}

.tb1 {
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
/* 앨범 에딧 들어왔을 때 배경화면 꽉 채우기 */
.page{
	background-repeat: no-repeat !important;
	background-size:100% 100% !important;
}
</style>

<script>
	
	//전체저장, 앨범정보 저장 confirm
	var all_save;
	var info_save;
	//홈버튼 눌렀을 때 confirm
	function really_back_home() {
		
		if(all_save != true) {
			var return_home = confirm('저장 버튼을 누르지 않으셨습니다. 정말 홈으로 돌아가겠습니까?');
			if (return_home == false) {
				return false;
			}
		}
		if(info_save != true) {
			var return_home = confirm('앨범정보를 저장하지 않으셨습니다. 정말 홈으로 돌아가시겠습니까?');
			if (return_home == false) {
				return false;
			}
		}
	}

	//페이지 로딩 후 초기화 내용
	$(document).ready(
			function() {

				$('.input').iCheck({
					radioClass : 'iradio_square-green',
				// increaseArea: '20%' // optional

				});

				ready_album('edit');

				$('html').click(function(e) {
					$('#home_button').text(e.target.nodeName);
				})

				// 앨범 로딩 시 카테고리 설정
				var album_openrange = '${album.album_openrange}';
				var album_category = '${album.album_category}';

				$("#album_openrange").val(album_openrange).prop("selected",
						true).trigger('change');
				$("#album_category").val(album_category).prop("selected", true)
						.trigger('change');
				
				searchword();
				searchgroup();
				$('#friendsearch').keyup(function() {
					searchword();
				});
			});

	function page1ImageSave() {
		html2canvas($('#page1'), {
			onrendered : function(canvas) {
				if (typeof FlashCanvas != "undefined") {
					FlashCanvas.initElement(canvas);
				}
				//반전이라는데 확인은 못해봄 작동을 안해서리...
				//canvas.scale(1,-1);
				$('#imgSrc').val(canvas.toDataURL('image/png'));
				$.ajax({
					url : 'page1ImageSave',
					type : 'POST',
					data : $('#testimg').serialize(),
					dataType : 'text',
					success : function(a) {
						console.log('표지 저장 -> ' + a);
						if (a != 'fail') {
							$.ajax({
								url : 'thumbnailPathSave',
								type : 'POST',
								data : {
									thumbnail : a,
									albumnum : '${album.album_num}'
								},
								dataType : 'text',
								success : function(b) {
								},
								error : function(e) {
									alert(JSON.stringify(e));
								}
							});
						} else {
							alert(a);
						}
					},
					error : function(e) {
						alert('파일 업로드 실패');
					}
				});
			}
		});
	}

	// 앨범 정보 수정
	function modifiy_AlbumInfomation() {
		var content = $('#album_contents').val().replace(/(?:\r\n|\r|\n)/g,'<br>');
		var album_name = $('#album_name').text();
		if(album_name.length > 10) {
			alert('앨범 이름은 최대 10글자까지만 가능합니다.');
			return false;
		}

		$.ajax({
			url : 'update_albuminfo',
			type : 'POST',
			data : {
				album_num : '${album.album_num}',
				album_name : album_name,
				album_contents : content,
				album_category : $('#album_category').val(),
				album_openrange : $('#album_openrange').val()
			},
			dataType : 'text',
			success : function(e) {
				alert('앨범정보가 저장되었습니다.');
				info_save = true;
			},
			error : function(e) {
				console.log('에러 발생.' + e);
			}
		});

	}
	
	
	//앨범 삭제
	function removeAlbum() {
		var isDelete = confirm("앨범을 삭제 하시겠습니까?");
		if(isDelete == false){
			return false;
		}
		location.href="deleteAlbum?album_num=" + ${album.album_num} + "";
	}
	
	//배경 되돌리기
	function reset_background() {
		$('#page1').css('background-image', '');
	}

</script>

</head>
<body style ="font-family: 'Nanum Gothic Coding', monospace;">

	<!-- 사이드 바 -->
	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate"
			data-animate-effect="fadeInLeft" style="padding: 30px 30px 0px 30px;">
			<a href="/www" class="mb-2 d-block probootstrap-logo"
				id="home_button" onclick="return really_back_home()">COOING</a>
		</div>
		<div class="probootstrap-overflow">
			<div class="main">
				<!-- 왼쪽 대 메뉴3가지 -->
				<input class="input1" id="tab1" type="radio" name="tabs" checked>
				<label for="tab1" style = "font-size: 13px;">Album</label>
				
				<input class="input1" id="tab2" type="radio" name="tabs">
				<label for="tab2" style = "font-size: 13px;">Chat</label>
				
				<input class="input1" id="tab3" type="radio" name="tabs">
				<label for="tab3" style = "font-size: 13px;">NEWS</label>
				
				<section id="content1">
				
					<!-- 앨범 정보 -->
					<div class="wrap-input100 validate-input"
						data-validate="Name is required">
						<span class="label-input100">Album Name</span>
						<div class="contact100-form-title input100" id="album_name" style="font-size: 20pt; outline:none; margin-top: 0" contenteditable="true">${album.album_name}</div>
						<span class="focus-input100"></span>
						<input hidden="hidden" id="hidden_album_num" value="${album.album_num}">
					</div>

					<div class="wrap-input100 validate-input"
						data-validate="Message is required">
						<span class="label-input100">Content</span>
						<textarea class="input100" name="album_contents"
							id="album_contents"
							class="input_album_info input_album_info_contents"
							value="${album.album_contents }"
							placeholder="your message here...">${album.album_contents}</textarea>
						<span class="focus-input100"></span>
					</div>

					<div class="wrap-input100 input100-select">
						<span class="label-input100">Category</span>
						<div>
							<select id="album_category" class="selection-2"name="album_category">
								<option value="0">여행</option>
								<option value="1">스포츠/래저</option>
								<option value="2">동물</option>
								<option value="3">음악</option>
								<option value="4">요리/음식</option>
								<option value="5">패션/뷰티</option>
								<option value="6">연예/TV</option>
								<option value="7">게임</option>
								<option value="8">영화</option>
								<option value="9">도서</option>
								<option value="10">공연/전시</option>
								<option value="11">외국어</option>
								<option value="12">전문지식</option>
								<option value="13">수집/제작</option>
								<option value="14">자기계발</option>
								<option value="15">육아</option>
								<option value="16">일상생활</option>
								<option value="17">자동차</option>
								<option value="18">낚시</option>
								<option value="19">건강</option>
								<option value="20">기타</option>
							</select>
						</div>
						<span class="focus-input100"></span>
					</div>

					<div class="wrap-input100 input100-select">
						<span class="label-input100">공개범위</span>
						

						<div>
							<select class="selection-2" name="album_openrange" id="album_openrange">	
								<c:if test="${album.isPersonal eq '1'}">
									<option value="1">나만 보기</option>
									<option value="2">친구 공개</option>
									<option value="4">전체 공개</option>
								</c:if>
								
								<c:if test="${album.isPersonal eq '0'}">
									<option value="3">그룹 공개</option>
									<option value="4">전체 공개</option>
								</c:if>
							</select>
						</div>
						
						
						<span class="focus-input100"></span>
					</div>


					<div class="container-contact100-form-btn">
						<div class="wrap-contact100-form-btn">
							<div class="contact100-form-bgbtn"></div>
							<button class="contact100-form-btn bt_album_info"
								onclick="return modifiy_AlbumInfomation()">
								<span> Submit <i class="fa fa-long-arrow-right m-l-7"
									aria-hidden="true"></i>
								</span>
							</button>
						</div>
					</div>


					<div id="dropDownSelect1"></div>


				</section>

				<section id="content2">
					<form id="testimg">
						<input type="hidden" name="imgSrc" id="imgSrc" />
					</form>

					<p class="mb-2 d-block probootstrap-logo"
						style="text-align: center; font-size: 20px; padding: 0px 0px 0px 0px; font-family: Poppins-Bold;">MY
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
						style="text-align: center; font-size: 20px; padding: 20px 0px 0px 0px; font-family: Poppins-Bold;">MY
						GROUP</p>

					<div class="groupList" id="group" style="margin-top: 20px; width: 200px;">
					</div>
				</section>
				
				 <!-- 영준이 알림공간 -->
		<section id ="content3">       					
			<div class = "newsList"  style= "margin-top: 70px; width: 200px;">
			여기 넣으셈
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
		<div class="under_bar " align="right">
			<div id="i_left_reset" class="under_tool" onclick="reset_left_background()" role="왼쪽 페이지 배경 초기화">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="fas fa-eraser"></i>
			</div>
			<!--  텍스트, 이미지 삽입 버튼 -->
			<div id="i_text" class="tool text under_tool" role="글상자 추가">
				<i class="fas fa-align-justify"></i>
			</div>
			<div id="i_image" class="tool image under_tool" role="사진 추가">
				<i class="far fa-image"></i>
			</div> 
			<!-- 각종 버튼 -->
			<div id="i_brush" class="under_tool i_brush"
				onclick="open_background()" role="속지 변경">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="fas fa-paint-brush"></i>
			</div>
			<div id="i_start" class="under_tool" onclick="nav_page('start')" role="첫 페이지로">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="fas fa-backward"></i>
			</div>
			<div id="i_before" class="under_tool" onclick="go_page('before')" role="이전 페이지">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="fas fa-angle-left"></i>
			</div>
			<div id="i_next" class="under_tool" onclick="go_page('next')" role="다음 페이지">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="fas fa-angle-right"></i>
			</div>
			<div id="i_end" class="under_tool" onclick="nav_page('end')" role="마지막 페이지로">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="fas fa-forward"></i>
			</div>
			<div id="i_add" class="under_tool" onclick="addPage()" role="페이지 추가">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="far fa-plus-square"></i>
			</div>
			<div id="i_remove" class="under_tool" onclick="removePage()" role="페이지 삭제">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="far fa-minus-square"></i>
			</div>
			<div id="i_save" class="under_tool" onclick="savePage('all')" role="전체 저장">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="fas fa-check"></i>
			</div>
			<div id="i_exit" class="under_tool"
				onclick="location.href='albumView?album_num=${album.album_num}'" role="편집 종료">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="fas fa-sign-out-alt"></i>
			</div>
			<div id="i_remove" class="under_tool" onclick="return removeAlbum()" role="앨범 삭제">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="far fa-trash-alt"></i>
			</div>
			<div id="i_right_reset" class="under_tool" onclick="reset_right_background()" role="오른쪽 페이지 배경 초기화">
				<i style="width: 30px; height: 30px; margin: 10px;"
					class="fas fa-eraser"></i>
			</div>
		</div>
	</div>

	</main>
	<script
		src="resources/album_create/vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/album_create/vendor/bootstrap/js/popper.js"></script>
	<script
		src="resources/album_create/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/album_create/vendor/select2/select2.min.js"></script>
	<script>
		$(".selection-2").select2({
			minimumResultsForSearch : 20,
			dropdownParent : $('#dropDownSelect1')
		});
	</script>
	<!--===============================================================================================-->
	<script
		src="resources/album_create/vendor/daterangepicker/moment.min.js"></script>
	<script
		src="resources/album_create/vendor/daterangepicker/daterangepicker.js"></script>
	<!--===============================================================================================-->
	<script
		src="resources/album_create/vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script src="resources/album_create/js/main.js"></script>

	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async
		src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag() {
			dataLayer.push(arguments);
		}
		gtag('js', new Date());

		gtag('config', 'UA-23581568-13');
	</script>


</body>
</html>

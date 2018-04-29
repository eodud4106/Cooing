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

<!-- albumEdit 용 js -->
<script type="text/javascript" src="resources/js/albumEdit.js"></script>
<script type="text/javascript" src="resources/js_js/html2canvas.min.js"></script>
<!-- 기본 css -->
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

#tab1:checked ~ #content1, #tab2:checked ~ #content2 {
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
</style>

<script>
	//홈버튼 눌렀을 때 confirm
	function really_back_home() {
		var return_home = confirm('저장버튼이나 페이지를 넘기지 않으면 저장되지 않습니다. 정말 홈으로 돌아가시겠습니까?');

		if (return_home == false) {
			return false;
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

			});

	function checkRadioButton(iCheck) {

		var temp;

		var radioObj = document.all(iCheck);

		var isChecked;
		if (radioObj.length == null) { // 라디오버튼이 같은 name 으로 하나밖에 없다면
			isChecked = radioObj.checked;
		} else { // 라디오 버튼이 같은 name 으로 여러개 있다면
			for (var i = 0; i < radioObj.length; i++) {
				if (radioObj[i].checked) {
					isChecked = true;
					break;
				}
			}
		}

		if (isChecked) {
			alert('체크된거있음' + radioObj[i].value);
			temp = radioObj[i].value;
			alert('템프 값 : ' + temp);

			//value값
			switch (temp) {
			case '1':
				alert(temp);
				$('.pages').css("background-image",
						"url(..//resources//image_mj//season.jpg)");
				break;

			case '2':
				alert(temp);
				$('.pages').css("background-color", "pink");
				break;

			default:
				alert(temp);
				$('.pages').css("background-image",
						"url(..//resources//image_mj//vintage.jpg)");
				break;
			}

		} else {
			alert('체크된거없음');
		}
	}

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
		$.ajax({
			url : 'update_albuminfo',
			type : 'POST',
			data : {
				album_num : '${album.album_num}',
				album_name : $('#album_name').text(),
				album_contents : content,
				album_category : $('#album_category').val(),
				album_openrange : $('#album_openrange').val()
			},
			dataType : 'text',
			success : function(e) {
			},
			error : function(e) {
				console.log('에러 발생.' + e);
			}
		});

	}
</script>

</head>
<body>

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
				<!-- 왼쪽 대 메뉴 2가지 -->
				<input class="input1" id="tab1" type="radio" name="tabs" checked>
				<label for="tab1">Album</label>
				<input class="input1" id="tab2" type="radio" name="tabs">
				<label for="tab2">Chat</label>
				<section id="content1">
				
					<!-- 앨범 정보 -->
					<div class="wrap-input100 validate-input"
						data-validate="Name is required">
						<span class="label-input100">Album Name</span>
						<div class="contact100-form-title input100" id="album_name" style="font-size: 20pt; outline:none;" contenteditable="true"> 
							${album.album_name }
						</div>
						<span class="focus-input100"></span>
						<input hidden="hidden" id="hidden_album_num" value="${album.album_num }">
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
							<select id="album_category" class="selection-2"
								name="album_category">
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
							<select class="selection-2" name="album_openrange"
								id="album_openrange">
								<option value="1">나만 보기</option>
								<option value="2">친구 공개</option>
								<option value="3">그룹 공개</option>
								<option value="4">전체 공개</option>
							</select>
						</div>
						<span class="focus-input100"></span>
					</div>


					<div class="container-contact100-form-btn">
						<div class="wrap-contact100-form-btn">
							<div class="contact100-form-bgbtn"></div>
							<button class="contact100-form-btn bt_album_info"
								onclick="modifiy_AlbumInfomation()">
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

					<div class="groupList" style="margin-top: 20px; width: 200px;">
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
				</section>
			</div>
		</div>
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
								style="background-image: ${page.page_background}; background-color: ${page.page_color}">${page.page_html}</div>
						</c:forEach>
					</c:if>
				</div>
			</div>

		</div>
		<!-- END row -->
		<!-- 하단 바 영역 -->
		<div class="under_bar " align="right">
			<!-- 텍스트, 이미지 삽입 버튼 -->
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
					class="far fa-trash-alt"></i>
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

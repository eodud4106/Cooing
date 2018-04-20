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
<meta name="viewport" content="width = 1050, user-scalable = no" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/open-iconic-bootstrap.min.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.carousel.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/owl.theme.default.min.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/aside_css/icomoon.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/animate.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/aside_css/style.css"/>">

<!-- 기본 js -->
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/albumEdit.js"/>"></script>

<script type="text/javascript" src="<c:url value="/resources/album_page_js/extras/modernizr.2.5.3.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/album_page_js/basic.js"/>"></script>

<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>


<script src="<c:url value="/resources/skin_radio/icheck.js"/>"></script>
<!-- 기본 css -->
<link rel="stylesheet" href="<c:url value="/resources/css/albumEdit.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.min.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/skin_radio/green.css"/>">

<link rel="stylesheet" href="<c:url value="/resources/album_css/album_edit_basic.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/album_css/album_edit_drag_and_drop.css"/>">

<style>
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
</style>
<script>
	var count = 0;
	
	var selectcheck = true;
	
	function modifiy_AlbumInfomation() {
		
		alert('들어오니?');
		
		var album_num = $('#album_num').val();
		var album_name = $('#album_name').val();
		var album_contents = $('#album_contents').val();
		var album_category = $('#album_category').val();
		var album_openrange = $('#album_openrange').val();
		
		$.ajax({
			url : 'modifiy_AlbumInfomation',
			type : 'POST',
			data : {
				album_num : album_num,
				album_name : album_name,
				album_contents : album_contents,
				album_category : album_category,
				album_openrange : album_openrange
				
			},
			dataType : 'text',
			success : function(a) {
				if(a == 'success'){
					alert('저장 성공');
				}
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}
	
	
	
	
	// 페이지 넘김 효과 관련
	function pageChange(page) {
		if (page) {
			$('#flipbook').turn('disable', false);
			$('#flipbook').turn('previous');
			/* $('#flipbook').turn('disable', true); */

		} else {
			$('#flipbook').turn('disable', false);
			$('#flipbook').turn('next');
			/* $('#flipbook').turn('disable', true); */
		}
	}

	function pagePlus() {
		for (var i = 0; i < 2; i++) {

			var element = $('<div />');
			element.attr('class', 'pages');
			element.attr('id', 'page' + ($('#flipbook').turn('pages') + 1));

			$('#flipbook').turn('addPage', element,
					$('#flipbook').turn('pages') + 1).turn('pages',
					$('#flipbook').turn('pages'));

			$('#page' + $('#flipbook').turn('pages')).droppable({
				accept : "#picture_add",
				drop : function(event, ui) {
					var pageid = $(this).attr('id');
					var pagenum = pageid.substring(4, pageid.length);

					var number = $('#flipbook').turn('page');
					if ($('#flipbook').turn('page') > 1
							&& $('#flipbook').turn('page') % 2 == 1) {
						number -= 1;
					}

					if (pagenum == number
							|| pagenum == (parseInt(number) + 1)) {
						var div_holder = document.createElement('div');
						count++;
						var html = '<a class="close_border"></a><label for="cross' + count + '">'
								+ '<input type="file" id="cross'
								+ count
								+ '"class="cross'
								+ pagenum
								+ '"name="cross'
								+ count
								+ '"onchange="readURL(this)"></label>';

						$(div_holder).attr('id',
								'holder' + count).addClass(
								'holder').html(html);
						$(div_holder).css('position', 'absolute');

						$(div_holder).draggable({
							containment : 'parent',
							scroll : false
						}).resizable();

						$(this).append(div_holder);

						$('.close_border').on('click', function() {
							$(this).parent().remove();
						});
					}
				}
			});
		}
	}

	function fileSave(formdata, file, pagenum, last) {
		$.ajax({
			url : 'albumImageSave',
			processData : false,
			contentType : false,
			type : 'POST',
			data : formdata,
			dataType : 'text',
			success : function(a) {
				if (a != 'fail') {
					alert(a);
	
					var div_holder = document.createElement('div');
					$(div_holder).addClass('holder').attr('id', $(file).parent().parent().attr('id'));
					$(div_holder).css({
						'position' : 'absolute',
						'top' : $(file).parent().parent().css('top'),
						'left' : $(file).parent().parent().css('left'),
						'height' : $(file).parent().parent().css('height'),
						'width' : $(file).parent().parent().css('width')
					});
	
					$(div_holder)
						.append('<img src="<c:url value="/albumEdit/img?filePath=' + a
								+ '"/>" style="width:100%; height:100%;" class="img">');
	
					$('#page' + pagenum).children('#' + $(file).parent().parent().attr('id')).remove();
					$('#page' + pagenum).append(div_holder);
	
					if (last) {
						pageSave($('#page' + pagenum).html(), pagenum,
							(pagenum % 2 == 1 ? true : false));
					}
	
				} else {
					alert(a);
				}
			},
			error : function(e) {
				alert('파일 업로드 실패');
			}
		});
	}

	function pageSave(strhtml, nowpage, check) {
		var album_num = $('#album_num').val();
		
		$.ajax({
			url : 'personal_pageSave',
			type : 'POST',
			data : {
				html : strhtml,
				pagenum : nowpage,
				albumnum : album_num
			},
			dataType : 'text',
			success : function(a) {
				if (a != 'fail') {
					if (check) {
						pagePlus();
						$('#flipbook').turn('disable', false);
						$('#flipbook').turn('next');
						/* $('#flipbook').turn('disable', true); */
					}
				} else {
					alert("저장 실패");
				}
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}

	function pageallEmpty(pageNum) {
		if (pageNum != 1)
			$('#page' + (parseInt(pageNum) - 1)).html('');
		$('#page' + pageNum).html('');
		pagePlus();
		$('#flipbook').turn('next');
	}
	
	function thumbnailSave(){
		//앨범 번호 불러오기
		var album_num = $('#album_num').val();
		var formData = new FormData();
		formData.append('file', $('#img1')[0].files[0]);
		//앨범 썸네일 이미지 C드라이브에 파일 저장 
		$.ajax({
			url : 'thumbnailSave',
			processData : false,
			contentType : false,
			type : 'POST',
			data :formData,
			dataType : 'text',
			success : function(a) {
				if (a != 'fail') {
					//앨범 썸네일 경로 서버에 저장 후 배경 이미지 변경
					$.ajax({
						url : 'thumbnailPathSave',
						type : 'POST',
						data :{thumbnail:a , albumnum:album_num },
						dataType : 'text',
						success : function(b) {
							$('#page1').css('background-image' , 'url(./thumbnail?filePath='+a+')');
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
				alert(JSON.stringify(e));
			}
		});		
	}

	function fileSubmit() {
		var number = $('#flipbook').turn('page');
		if(number == 1){
			thumbnailSave();
		}
		if ($('#flipbook').turn('page') > 1
				&& $('#flipbook').turn('page') % 2 == 1) {
			number -= 1;
		}
		var num = 0;
		var last = $('input[class="cross' + number + '"]').length;
		var check = true;
		$('input[class="cross' + number + '"]').each(
			function(index, item) {
				if ($('input[class="cross' + number + '"]')[index].files[0]) {
					check = false;
					var formData = new FormData();
					formData.append('file' + num, $('input[class="cross' + number + '"]')[index].files[0]);
					fileSave(formData, item, number, (index == last - 1 ? true : false));
				}
			});

		if (check && number == 1)
			pageallEmpty(number);

		if (number != 1) {
			number = (parseInt(number) + 1);
			last = $('input[class="cross' + number + '"]').length;
			check = true;
			$('input[class="cross' + number + '"]').each(function(index, item) {
				if ($('input[class="cross' + number + '"]')[index].files[0]) {
					check = false;
					var formData = new FormData();
					formData.append('file' + num,
							$('input[class="cross' + number
									+ '"]')[index].files[0]);
					fileSave(formData, item, number,
							(index == last - 1 ? true : false));
				}
			});
			if (check)
				pageallEmpty(number);
		}
	}

	// 페이지 로딩 후 초기화
	$(document).ready(function() {
		$('#picture_add').draggable({
			revert : 'valid'
		});

		$('#page1').droppable({
			accept : '#picture_add',
			drop : function(event, ui) {
				var pageid = $(this).attr('id');
				var pagenum = pageid.substring(4, pageid.length);
				var number = $('#flipbook').turn('page');
				
				if ($('#flipbook').turn('page') > 1 && $('#flipbook').turn('page') % 2 == 1) {
					number -= 1;
				}
				
				if (pagenum == number || pagenum == (parseInt(number) + 1)) {
					var div_holder = document
							.createElement('div');
					count++;
					var html = '<a class="close_border"></a><label for="cross' + count + '">'
							+ '<input type="file" id="cross'
							+ count
							+ '"class="cross'
							+ pagenum
							+ '"name="cross'
							+ count
							+ '"onchange="readURL(this)"></label>';

					$(div_holder)
						.addClass('holder')
						.html(html)
						.attr(
								'id',
								'holder'
										+ count);
					$(div_holder).css('position', 'absolute');
					$(div_holder).draggable({
						containment : 'parent',
						scroll : false
					}).resizable();

					$(this).append(div_holder);

					$('.close_border').click(function() {
						$(this).parent().remove();
					});
				}
			}
		});
	});

	function readURL(input) {

		//사진 테두리 div
		var target = $(input).parent().parent();

		$(target).append(
				'<img src="" style="width:100%; height:100%;" class="img">');

		if (input.files && input.files[0]) {
			$(target).children('label').hide();

			var reader = new FileReader();

			reader.onload = function(e) {
				$(target).append('<a class="close_picture">');
				$(target).children('.img').attr('src', e.target.result);
				/* $(target).css('background-image', "url(" + e.target.result + ")"); */

				$(target).children().children().attr('data',
						$(target).attr('id'));

				$('.close_picture').on('click', function() {
					//$(this).parent().css('background-image', 'url("")');
					$(this).parent().children().show();
					$(this).parent().children('.img').hide();
					$(this).remove();
				});
			}

			reader.readAsDataURL(input.files[0]);
		}
	}

	//라디오버튼
	$(document).ready(function() {

		$('.input').iCheck({
			radioClass : 'iradio_square-green',
		// increaseArea: '20%' // optional

		});

		//value값

	});

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
	
	/* function pageExit() {
		if(selectcheck){
			var album_num = $('#album_num').val();
		      //페이지를 끝낼 때 하고 싶은 것을 지정합니다.  
			$.ajax({
				url : 'deleteAlbum',
				type : 'POST',
				data :{albumnum:album_num},
				dataType : 'text',
				success : function(a) {
					if (a != 'fail') {
						
					} else {
						alert("저장 실패");
					}
				},
				error : function(e) {
					alert(JSON.stringify(e));
				}
			});	      
		}
	}  */
</script>

</head>
<body>

	<!-- 사이드 바 -->
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
		<input class = "input1" id="tab1" type="radio" name="tabs" checked> <!--디폴트 메뉴-->
		<label for="tab1">앨범생성</label>

  		<input class = "input1" id="tab2" type="radio" name="tabs">
    	<label for="tab2">채팅</label>   

    	<section id="content1"> 
    	<!-- 페이지 저장 -->		
			<div id="entry">
				<h5 style="color: black;">앨범명</h5><input type="text" id="album_name" name="album_name" value="앨범이름을 입력해주세요.">
				<h5 style="color: black; ">앨범 내용</h5>
				<input type="text" style = "height: 100px;"id="album_contents" name="album_contents" value="앨범내용을 입력해주세요.">
				<h5 style="color: black;">앨범 카테고리</h5>
				<select name="album_category" id="album_category">		
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
				    <option value="20" selected="selected">기타</option>
				</select>
				<h5 style="color: black;">앨범 공개범위</h5>
				<select name="album_openrange" id="album_openrange">		
					<option value="1" selected="selected">나만 보기</option>
				    <option value="2">전체 공개</option>
				    <option value="3">더 추가해서 ㄱㄱ</option>
				</select>
				
				<input type="button" value="앨범정보저장" onclick="modifiy_AlbumInfomation()">
				<br><br><br>
				<!-- <input type="text" id="hashtagtx" placeholder="해쉬태그"><input type="button" id="hashtagbt" value="추가">--> 
				<div id="hashtagvw"></div>
				<br><br>
				<input type="button" id="hashtagbt" value="추가">
				<input type="hidden" name="album_num" value="${albumnum }" id="album_num">
				
				<br><br>
				<!-- <input type="hidden" id="hashtag" name="hashtag"> -->
				<!-- <input type="submit" onsubmit="formCheck()"> -->
			</div>
		    
       
    	</section>

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
			<div class="row justify-content-center">
	
				<div class="col-xl-8 col-lg-12">
					
                	<div id="text_add" style= "z-index:99; float:left; width: 5%;"><i class="fas fa-align-justify"></i></div>
					<div id="picture_add" style="z-index:99; float:left; width: 5%;"><i class="far fa-image"></i></div>
					<div id="video_add" style="z-index:99; float:left; width: 5%;"><i class="fas fa-video"></i></div>    	
					<!-- 배경변경버튼 -->
					<form name="form" style = "float:right;">
						<input type="radio" name="iCheck" class = "input"value="1" >Sakura
						<input type="radio" name="iCheck" class = "input"value="2" >Pink
						<input type="radio" name="iCheck" class = "input"value="3" checked>Vintage
						<div style= "z-index:99; float:right; " onClick="checkRadioButton('iCheck')"><i class="far fa-check-circle"></i></div>

					</form>
	
					<div class="row">
						<div class="col-xl-8 col-lg-12 mx-auto"></div>
					</div>
	
				</div>
				
				<!-- 앨범 영역 -->
				<div class="flipbook" id="flipbook">
					<div class="page1 canvas" id="page1">
						<!-- image 태그의 accept는 입력 받을 파일의 형식을 제한 -->
						<input type="file" name="img1" accept="image/*" id="img1">
					</div>
				</div>
				
			</div>
			<!-- END row -->
	
			<!--   <section class="probootstrap-section"> -->
			<div class="container-fluid">
				<div class="row mb-5 justify-content-center">
					<div class="col-md-8">
						<div class="row">
							<div class="col-md-8 mx-auto">	
									
								<div
									style="width: 50px; height: 50px; z-index: 99; float: left; width: 10%;" onClick="fileSubmit();">
									<i class="fas fa-plus"></i>
									<!-- <input type="button" value="저장" onClick="fileSubmit();"> -->
								</div>
								<div
									style="width: 50px; height: 50px; z-index: 99; float: left; width: 10%;" onClick="pageChange(true);">
									<i class="fas fa-backward"></i>
									<!-- <input type="button" value="전장" onClick="pageChange(true);"> -->
								</div>
								<div
									style="width: 50px; height: 50px; z-index: 99; float: left; width: 10%;" onClick="pageChange(false);">
									<i class="fas fa-forward"></i>
									<!-- <input type="button" value="뒷장" onClick="pageChange(false);"> -->
								</div>
								
								<div
									style="width: 50px; height: 50px; z-index: 99; float: left; width: 10%;" onClick="outOfPage();">
									<i class="fas fa-check"></i>
								</div>
	
	
							</div>
						</div>
	
					</div>
				</div>
	
	
			</div>
	
		</div>

	</main>


	<!-- 메인표지업로드 -->
	<script type="text/javascript">
		var homePhoto = document.querySelector(".flipbook");

		homePhoto.onchange = function(e) {

			var file = e.target.files[0];

			var reader = new FileReader();

			reader.addEventListener("load", function() {

				var container = e.target.parentNode;

				container.style.background = "url(" + reader.result
						+ ") no-repeat center";
				container.style["background-size"] = "cover";

			}, false);

			if (file) {
				reader.readAsDataURL(file);
			}

		}

		function loadApp() {

			// Create the flipbook
			$('.flipbook').turn({
				width : 1200,
				height : 600,
				elevation : 50,
				gradients : true,
				autoCenter : true
			});
		}

		// Load the HTML4 version if there's not CSS transform
		yepnope({
			test : Modernizr.csstransforms,
			yep : [ '../resources/album_page_js/lib/turn.js' ],
			nope : [ '../resources/album_page_js/lib/turn.html4.min.js' ],
			both : [ '../resources/album_css/basic.css' ],
			complete : loadApp
		});
	</script>


	<script src="<c:url value="/resources/aside_js/popper.min.js"/>"></script>
	<script src="<c:url value="/resources/aside_js/owl.carousel.min.js"/>"></script>
	<script src="<c:url value="/resources/aside_js/jquery.waypoints.min.js"/>"></script>
	<script src="<c:url value="/resources/aside_js/imagesloaded.pkgd.min.js"/>"></script>

	<script src="<c:url value="/resources/aside_js/main.js"/>"></script>

</body>
</html>

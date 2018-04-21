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

<link rel="stylesheet" href="./resources/aside_css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/aside_css/open-iconic-bootstrap.min.css">

<link rel="stylesheet" href="./resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet" href="./resources/aside_css/owl.theme.default.min.css">

<link rel="stylesheet" href="./resources/aside_css/icomoon.css">
<link rel="stylesheet" href="./resources/aside_css/animate.css">
<link rel="stylesheet" href="./resources/aside_css/style.css">
<script type="text/javascript" src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="./resources/album_page_js/extras/modernizr.2.5.3.min.js"></script>
<script type="text/javascript" src="./resources/album_page_js/basic.js"></script>		

<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" ></script>

<script src="./resources/album_drag_and_drop_js/jquery-ui.js"></script>

<link rel="stylesheet" href="./resources/skin_radio/green.css">		
<script src="./resources/skin_radio/icheck.js"></script>

<link rel="stylesheet" href="./resources/album_drag_and_drop_js/jquery-ui.css">		
<link rel="stylesheet" href="./resources/album_css/album_edit_basic.css">
<link rel="stylesheet" href="./resources/album_css/album_edit_drag_and_drop.css">

<script>
var count = 0;

// 페이지 넘김 효과 관련
function pageChange(page){
	if(page){
		$('#flipbook').turn('disable', false);
		$('#flipbook').turn('previous');
		/* $('#flipbook').turn('disable', true); */
		
	}else{
		$('#flipbook').turn('disable', false);
		$('#flipbook').turn('next');
		/* $('#flipbook').turn('disable', true); */		
	}
}

function pagePlus(){
	for(var i = 0; i < 2; i++){
		
		var element = $('<div />');
		element.attr('class', 'pages');
		element.attr('id', 'page' + ($('#flipbook').turn('pages')+1));
		
		$('#flipbook').turn('addPage', element, $('#flipbook').turn('pages') + 1)
			.turn('pages', $('#flipbook').turn('pages'));
		
		$('#page' + $('#flipbook').turn('pages')).droppable({
			accept: "#picture_add",
			drop: function(event, ui) {
				var pageid = $(this).attr('id');
				var pagenum = pageid.substring(4,pageid.length);
				
				var number = $('#flipbook').turn('page');
				if($('#flipbook').turn('page') > 1 && $('#flipbook').turn('page') % 2 == 1) {
					number -= 1;
				}
				
				if(pagenum == number || pagenum == (parseInt(number) + 1)){
					var div_holder = document.createElement('div');
					count ++;
					var html = '<a class="close_border"></a><label for="cross' + count + '">'
						+ '<input type="file" id="cross' + count + '"class="cross'+ pagenum
						+ '"name="cross' + count + '"onchange="readURL(this)"></label>';

					$(div_holder).attr('id', 'holder'+count).addClass('holder').html(html);
					$(div_holder).css('position', 'absolute');
					
					$(div_holder).draggable({
						containment: 'parent',
						scroll: false
					}).resizable();
					
					$(this).append(div_holder);
					
					$('.close_border').on('click', function() {
						$(this).parent().remove();
					});
				}
			}
		});
	}
	/* $('#flipbook').turn('disable', true); */
}

function fileSave(formdata, file, pagenum, last){
	$.ajax({
		url:'albumImageSave',
		processData: false,
		contentType: false,
		type: 'POST',		
		data: formdata,
		dataType: 'text',
		success: function(a){
			if(a!='fail'){
				alert(a);
				
				var div_holder = document.createElement('div');
				$(div_holder).addClass('holder').attr('id', $(file).parent().parent().attr('id'));
				$(div_holder).css({
					'position': 'absolute',
					'top': $(file).parent().parent().css('top'),
					'left': $(file).parent().parent().css('left'),
					'height': $(file).parent().parent().css('height'),
					'width': $(file).parent().parent().css('width')
				});
				
				$(div_holder).append('<img src="<c:url value="/albumEdit/img?filePath=' + a 
						+ '"/>" style="width:100%; height:100%;" class="img">');
				
				$('#page' + pagenum).children('#' + $(file).parent().parent().attr('id')).remove();
				$('#page' + pagenum).append(div_holder);
				
				if(last){
					pageSave($('#page' + pagenum).html(), pagenum, (pagenum % 2 == 1 ? true : false));
				}
				
			}else{
				alert(a);
			}
		},
		error:function(e){ alert('파일 업로드 실패'); }		
	});
}

function pageSave(strhtml , nowpage , check){
	$.ajax({
		url:'pageSave',
		type: 'POST',		
		data: {
			html: strhtml,
			pagenum: nowpage
		},
		dataType: 'text',
		success: function(a){
			if(a == 'success'){
				if(check){
					pagePlus();
					$('#flipbook').turn('disable', false);
					$('#flipbook').turn('next');
					/* $('#flipbook').turn('disable', true); */
				}
			}
			else{
				alert(a);
			}
		},
		error:function(e){
			alert(JSON.stringify(e));
		}		
	});
}

function pageallEmpty(pageNum){
	if(pageNum != 1)
		$('#page' + (parseInt(pageNum) - 1)).html('');
	$('#page' + pageNum).html('');
	pagePlus();
	$('#flipbook').turn('next');	
}

function fileSubmit() {
	var number = $('#flipbook').turn('page');
	if($('#flipbook').turn('page') > 1 && $('#flipbook').turn('page') % 2 == 1) {
		number -= 1;
	}
	var num = 0;
	var last = $('input[class="cross' + number + '"]').length;
	var check = true;
	$('input[class="cross' + number + '"]').each(function(index, item){
		if($('input[class="cross' + number + '"]')[index].files[0]){
			check = false;
			var formData = new FormData();
			formData.append('file' + num, $('input[class="cross' + number + '"]')[index].files[0]);
			fileSave(formData, item,number, (index == last-1 ? true : false));
		}
	});	
	
	if(check && number == 1)
		pageallEmpty(number);
	
	if(number != 1){
		number = (parseInt(number) + 1);
		last = $('input[class="cross'+number+'"]').length;
		check = true;
		$('input[class="cross'+number+'"]').each(function(index,item){
			if($('input[class="cross'+number+'"]')[index].files[0]){
				check = false;
				var formData = new FormData();
				formData.append('file'+num , $('input[class="cross'+number+'"]')[index].files[0]);
				fileSave(formData,item , number,(index == last-1 ? true : false));
			}
		});
		if(check)
			pageallEmpty(number);
	}
}

// 페이지 로딩 후 초기화
$(document).ready(function () {
	$('#picture_add').draggable({ revert: 'valid' });
	
	//다른 쪽 드롭되도 돌아 올 수 있게 하는 코드
	$('*').droppable({
		accept: '#picture_add',
		drop: function(event, ui) {
			//TODO
		}
	});
	
	$('#page1').droppable({
		accept: '#picture_add',
		drop: function(event, ui) {
			var pageid = $(this).attr('id');
			var pagenum = pageid.substring(4, pageid.length);
			var number = $('#flipbook').turn('page');
			if($('#flipbook').turn('page') > 1 && $('#flipbook').turn('page') % 2 == 1) {
				number -= 1;
			}
			if(pagenum == number || pagenum == (parseInt(number) + 1)){
				var div_holder = document.createElement('div');
				count ++;
				var html = '<a class="close_border"></a><label for="cross' + count + '">'
					+ '<input type="file" id="cross' + count + '"class="cross' + pagenum
					+ '"name="cross' + count + '"onchange="readURL(this)"></label>';
				
				$(div_holder).addClass('holder').html(html).attr('id', 'holder'+count);
				$(div_holder).css('position', 'absolute');
				$(div_holder).draggable({
					containment: 'parent',
					scroll: false
				}).resizable();
				
				$(this).append(div_holder);
				
				$('.close_border').on('click', function() {
					$(this).parent().remove();
				});
			}
		}
	});
});

function readURL(input) {
	
	//사진 테두리 div
	var target = $(input).parent().parent(); 
	
	$(target).append('<img src="" style="width:100%; height:100%;" class="img">');
	
	if (input.files && input.files[0]) {
		$(target).children('label').hide();
		
		var reader = new FileReader();
		 
		reader.onload = function (e) {
			$(target).append('<a class="close_picture">');
			$(target).children('.img').attr('src', e.target.result );
			/* $(target).css('background-image', "url(" + e.target.result + ")"); */
			
			$(target).children().children().attr('data',$(target).attr('id'));
			
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
$(document).ready(function(){
		
  $('input').iCheck({
    radioClass: 'iradio_square-green',
   // increaseArea: '20%' // optional  
   
  });	
});



function checkRadioButton(iCheck)
{	
	
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
	
	}
	else{
	alert('체크된거없음');
	}
}
	// 좋아요
	function likes(){
		
		var num = 1;
		
		$.ajax({
			url:'likes',
			type: 'POST',		
			data: {
				"likeit_albumnum": num
			},
			dataType: 'text',
			success: function(a){
				if(a == 'success'){
					alert("좋아요!");	
					
				}
				else{
					alert(a);
				}
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
	}
	// 좋아요 취소
	function deletelikes(){

		var num = 1;
		
		$.ajax({
			url:'deleteLikes',
			type: 'POST',		
			data: {
				"likeit_albumnum": num
			},
			dataType: 'text',
			success: function(a){
				if(a == 'success'){
					alert("좋아요 취소");
					
				}
				else{
					alert(a);
				}
			},
			error:function(e){
				alert(JSON.stringify(e));
			}		
		});
	}
	// 댓글 창 이동
	function replyWin(){  
    window.open("albumReply", "댓글 창", "width=700, height=200, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
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
				<p>그룹3</p>		
				<p><button type="button" onclick="likes()">좋아요!</button></p>		
				<p><button type="button" onclick="deletelikes()">좋아요 취소!</button></p> 		
				<p><button type="button" onClick="javascript:replyWin();">댓글</button></p> 

        <footer class="probootstrap-aside-footer probootstrap-animate" data-animate-effect="fadeInLeft">
         
          <p>&copy; 2018 <a href="https://uicookies.com/" target="_blank">COOING</a>. <br> All Rights Reserved.</p>
        </footer>
      </div>
    </aside>

<main role="main" class="probootstrap-main2 js-probootstrap-main">
      <div class="probootstrap-bar">
      
        <a href="#" class="probootstrap-toggle js-probootstrap-toggle"><span class="oi oi-menu"></span></a>
        <div class="probootstrap-main-site-logo"><a href="index.html">COOING</a></div>
        
      </div>
      
      <div class="container-fluid">
        <div class="row justify-content-center">
       
          <div class="col-xl-8 col-lg-12">
            <div id="text_add" style= "z-index:99; float:left; width: 5%;"><i class="fas fa-align-justify"></i></div>
      		<div id="picture_add" style="z-index:99; float:left; width: 5%;"><i class="far fa-image"></i></div>
      		<div id="video_add" style="z-index:99; float:left; width: 5%;"><i class="fas fa-video"></i></div>
      		
      		
      		<!-- 배경변경버튼 -->
      		<!-- <form name = "form"> -->
      		<div style= "z-index:99; float:right;">
      		<input type="radio" name="iCheck"  value ="1" checked>Sakura 
      		<input type="radio" name="iCheck" value ="2" >Pink     		
			<input type="radio" name="iCheck"  value ="3">Vintage
			<!-- <input type=button onClick="checkRadioButton('iCheck')"> -->
			<div style= "z-index:99; float:right; padding-left : 10px;" onClick="checkRadioButton('iCheck')"><i class="far fa-check-circle"></i></div>
			</div>
			<!-- </form> -->
			
			
<!-- 	<button onclick = "bgchange(0)">SAKURA</button>
	<button onclick = "bgchange(1)">PINK</button>
	<button onclick = "bgchange(2)">VINTAGAE</button>  -->
          
           <!--  <p class="mb-5"><img src="images/img_bg_2.jpg" alt="Free Bootstrap 4 Template by uicookies.com" class="img-fluid"></p>
 -->
            	 <div class="row">
            	 
            		 <div class="col-xl-8 col-lg-12 mx-auto">
            		 
              
         <!--    <div id="edit_bar" style="z-index:100; width: 50%;"> -->
	<!-- <div id="picture_add" style="background-image: url(../resources/image_mj/photo.png); width : 50px; height: 50px; z-index:99; float:left; width: 10%;"></div>
	<div id="text_add" style="background-image: url(../resources/image_mj/text.png); width : 50px; height: 50px; z-index:99; float:left; width: 10%;"></div>
	<div id="video_add" style="background-image: url(../resources/image_mj/Video-5-icon.png); width : 50px; height: 50px; z-index:99; float:left; width: 10%;"></div> -->

	  

             
            	  </div>
             </div> 
            
          </div>
          <div class="flipbook" id="flipbook">
				<div class="page1" id="page1">
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
              <!--   <div class="flipbook" id="flipbook">
				<div class="page1" id="page1">
				 	 <input type="file" name="img1" accept="image/*" id="img1"> 
				 </div>
			</div> -->
			 <div style="width : 50px; height: 50px; z-index:99; float:left; width: 10%;"><input type="button" value="+" id="page_plus" name=""></div>

<div style="width : 50px; height: 50px; z-index:99; float:left; width: 10%;"><input type="button" value="저장" onClick="fileSubmit();"></div>
<div style="width : 50px; height: 50px; z-index:99; float:left; width: 10%;"><input type="button" value="전장" onClick="pageChange(true);"></div>
<div style="width : 50px; height: 50px; z-index:99; float:left; width: 10%;"><input type="button" value="뒷장" onClick="pageChange(false);"></div>


                  </div>
                </div>
                
              </div>
            </div>
        
           <!--  <div class="row mb-5">
              <div class="col-md-12">
               <div class="owl-carousel probootstrap-owl">
                </div> 
                 
           
                 
                </div>
              </div> -->
            </div>
            

            
          </div>
       <!--  </section> -->
        <!-- END section -->

      </div>

     

    </main>


<!-- 메인표지업로드 -->
<script type="text/javascript">
var file1 = document.querySelector('#img1');
file1.onchange = function () {
    var fileList = file1.files;
    var reader = new FileReader();
    reader.readAsDataURL(fileList [0]);
    reader.onload = function  () {
        document.querySelector('#preview1').src = reader.result ;
    };
};

var homePhoto = document.querySelector(".flipbook");

homePhoto.onchange = function(e) {

	var file = e.target.files[0];
	
	var reader = new FileReader();
	
	reader.addEventListener("load", function() {
	
		var container = e.target.parentNode;
		
		container.style.background = "url("+reader.result+") no-repeat center";
		container.style["background-size"] = "cover";
	
	}, false);
	
	if (file) {
		reader.readAsDataURL(file);
	}

}

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
	yep: ['./resources/album_page_js/lib/turn.js'],
	nope: ['./resources/album_page_js/lib/turn.html4.min.js'],
	both: ['./resources/album_css/basic.css'],
	complete: loadApp
});

</script>   


    <script src="./resources/aside_js/popper.min.js"></script>
    <script src="./resources/aside_js/owl.carousel.min.js"></script>
    <script src="./resources/aside_js/jquery.waypoints.min.js"></script>
    <script src="./resources/aside_js/imagesloaded.pkgd.min.js"></script>

    <script src="./resources/aside_js/main.js"></script>        

</body>
</html>  
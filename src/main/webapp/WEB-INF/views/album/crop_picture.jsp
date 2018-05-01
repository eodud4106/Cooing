<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사진 자르기</title>
<script src="resources/js_js/jquery-3.2.1.min.js"></script>

<link rel="stylesheet" href="resources/aside_css/bootstrap.min.css">
<link rel="stylesheet"
	href="resources/aside_css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/aside_css/owl.carousel.min.css">
<link rel="stylesheet"
	href="resources/aside_css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/aside_css/icomoon.css">
<link rel="stylesheet" href="resources/aside_css/animate.css">
<link rel="stylesheet" href="resources/aside_css/style.css">
<link rel="stylesheet" href="resources/button_css/style.css">
<script>
//부모창으로 값 넘기는 함수
function pass_parent() {
	
	var isDidCrop = $('#crop_result').width();
	var change_url;
	
	if(isDidCrop != 0){
	    change_url = $('#crop_result').attr('src');
	    opener.document.getElementById('${picture_id}').src = change_url;
		window.close();
		return true;
	} else {
		alert('crop버튼을 눌러주세요');
		return false;
	}
	//저장버튼 pass_parent
}


// variables
var canvas, ctx;
var image;
var iMouseX, iMouseY = 1;
var theSelection;

// define Selection constructor
function Selection(x, y, w, h){
    this.x = x; // initial positions
    this.y = y;
    this.w = w; // and size
    this.h = h;

    this.px = x; // extra variables to dragging calculations
    this.py = y;

    this.csize = 6; // resize cubes size
    this.csizeh = 10; // resize cubes size (on hover)

    this.bHow = [false, false, false, false]; // hover statuses
    this.iCSize = [this.csize, this.csize, this.csize, this.csize]; // resize cubes sizes
    this.bDrag = [false, false, false, false]; // drag statuses
    this.bDragAll = false; // drag whole selection
}

// define Selection draw method
Selection.prototype.draw = function(){

    ctx.strokeStyle = '#000';
    ctx.lineWidth = 2;
    ctx.strokeRect(this.x, this.y, this.w, this.h);

    // draw part of original image
    if (this.w > 0 && this.h > 0) {
        ctx.drawImage(image, this.x, this.y, this.w, this.h, this.x, this.y, this.w, this.h);
    }

    // draw resize cubes
    ctx.fillStyle = '#fff';
    ctx.fillRect(this.x - this.iCSize[0], this.y - this.iCSize[0], this.iCSize[0] * 2, this.iCSize[0] * 2);
    ctx.fillRect(this.x + this.w - this.iCSize[1], this.y - this.iCSize[1], this.iCSize[1] * 2, this.iCSize[1] * 2);
    ctx.fillRect(this.x + this.w - this.iCSize[2], this.y + this.h - this.iCSize[2], this.iCSize[2] * 2, this.iCSize[2] * 2);
    ctx.fillRect(this.x - this.iCSize[3], this.y + this.h - this.iCSize[3], this.iCSize[3] * 2, this.iCSize[3] * 2);
}

function drawScene() { // main drawScene function
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height); // clear canvas

    // draw source image
    ctx.drawImage(image, 0, 0, ctx.canvas.width, ctx.canvas.height);

    // and make it darker
    ctx.fillStyle = 'rgba(0, 0, 0, 0.5)';
    ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);

    // draw selection
    theSelection.draw();
}

$(function(){
	
	$('#crop_button').click(function() {
	    $('canvas').remove();
	});
    // loading source image
    // 부모창에서 받은 이미지 url
    var url_picture = '${new_url_picture}';
    
    image = new Image();
    image.onload = function () {
    }
    image.src = '' + url_picture + '';
	image.width = '800';
	image.height = '800';
    

    // creating canvas and context objects
    canvas = document.getElementById('panel');
    ctx = canvas.getContext('2d');

    // create initial selection
    theSelection = new Selection(100, 100, 100, 100);

    $('#panel').mousemove(function(e) { // binding mouse move event
        var canvasOffset = $(canvas).offset();
        iMouseX = Math.floor(e.pageX - canvasOffset.left);
        iMouseY = Math.floor(e.pageY - canvasOffset.top);

        // in case of drag of whole selector
        if (theSelection.bDragAll) {
            theSelection.x = iMouseX - theSelection.px;
            theSelection.y = iMouseY - theSelection.py;
        }

        for (i = 0; i < 4; i++) {
            theSelection.bHow[i] = false;
            theSelection.iCSize[i] = theSelection.csize;
        }

        // hovering over resize cubes
        if (iMouseX > theSelection.x - theSelection.csizeh && iMouseX < theSelection.x + theSelection.csizeh &&
            iMouseY > theSelection.y - theSelection.csizeh && iMouseY < theSelection.y + theSelection.csizeh) {

            theSelection.bHow[0] = true;
            theSelection.iCSize[0] = theSelection.csizeh;
        }
        if (iMouseX > theSelection.x + theSelection.w-theSelection.csizeh && iMouseX < theSelection.x + theSelection.w + theSelection.csizeh &&
            iMouseY > theSelection.y - theSelection.csizeh && iMouseY < theSelection.y + theSelection.csizeh) {

            theSelection.bHow[1] = true;
            theSelection.iCSize[1] = theSelection.csizeh;
        }
        if (iMouseX > theSelection.x + theSelection.w-theSelection.csizeh && iMouseX < theSelection.x + theSelection.w + theSelection.csizeh &&
            iMouseY > theSelection.y + theSelection.h-theSelection.csizeh && iMouseY < theSelection.y + theSelection.h + theSelection.csizeh) {

            theSelection.bHow[2] = true;
            theSelection.iCSize[2] = theSelection.csizeh;
        }
        if (iMouseX > theSelection.x - theSelection.csizeh && iMouseX < theSelection.x + theSelection.csizeh &&
            iMouseY > theSelection.y + theSelection.h-theSelection.csizeh && iMouseY < theSelection.y + theSelection.h + theSelection.csizeh) {

            theSelection.bHow[3] = true;
            theSelection.iCSize[3] = theSelection.csizeh;
        }

        // in case of dragging of resize cubes
        var iFW, iFH;
        if (theSelection.bDrag[0]) {
            var iFX = iMouseX - theSelection.px;
            var iFY = iMouseY - theSelection.py;
            iFW = theSelection.w + theSelection.x - iFX;
            iFH = theSelection.h + theSelection.y - iFY;
        }
        if (theSelection.bDrag[1]) {
            var iFX = theSelection.x;
            var iFY = iMouseY - theSelection.py;
            iFW = iMouseX - theSelection.px - iFX;
            iFH = theSelection.h + theSelection.y - iFY;
        }
        if (theSelection.bDrag[2]) {
            var iFX = theSelection.x;
            var iFY = theSelection.y;
            iFW = iMouseX - theSelection.px - iFX;
            iFH = iMouseY - theSelection.py - iFY;
        }
        if (theSelection.bDrag[3]) {
            var iFX = iMouseX - theSelection.px;
            var iFY = theSelection.y;
            iFW = theSelection.w + theSelection.x - iFX;
            iFH = iMouseY - theSelection.py - iFY;
        }

        if (iFW > theSelection.csizeh * 2 && iFH > theSelection.csizeh * 2) {
            theSelection.w = iFW;
            theSelection.h = iFH;

            theSelection.x = iFX;
            theSelection.y = iFY;
        }

        drawScene();
    });

    $('#panel').mousedown(function(e) { // binding mousedown event
        var canvasOffset = $(canvas).offset();
        iMouseX = Math.floor(e.pageX - canvasOffset.left);
        iMouseY = Math.floor(e.pageY - canvasOffset.top);

        theSelection.px = iMouseX - theSelection.x;
        theSelection.py = iMouseY - theSelection.y;

        if (theSelection.bHow[0]) {
            theSelection.px = iMouseX - theSelection.x;
            theSelection.py = iMouseY - theSelection.y;
        }
        if (theSelection.bHow[1]) {
            theSelection.px = iMouseX - theSelection.x - theSelection.w;
            theSelection.py = iMouseY - theSelection.y;
        }
        if (theSelection.bHow[2]) {
            theSelection.px = iMouseX - theSelection.x - theSelection.w;
            theSelection.py = iMouseY - theSelection.y - theSelection.h;
        }
        if (theSelection.bHow[3]) {
            theSelection.px = iMouseX - theSelection.x;
            theSelection.py = iMouseY - theSelection.y - theSelection.h;
        }
        

        if (iMouseX > theSelection.x + theSelection.csizeh && iMouseX < theSelection.x+theSelection.w - theSelection.csizeh &&
            iMouseY > theSelection.y + theSelection.csizeh && iMouseY < theSelection.y+theSelection.h - theSelection.csizeh) {

            theSelection.bDragAll = true;
        }

        for (i = 0; i < 4; i++) {
            if (theSelection.bHow[i]) {
                theSelection.bDrag[i] = true;
            }
        }
    });

    $('#panel').mouseup(function(e) { // binding mouseup event
        theSelection.bDragAll = false;

        for (i = 0; i < 4; i++) {
            theSelection.bDrag[i] = false;
        }
        theSelection.px = 0;
        theSelection.py = 0;
    });

    drawScene();
});

function getResults() {
    var temp_ctx, temp_canvas;
    temp_canvas = document.createElement('canvas');
    temp_ctx = temp_canvas.getContext('2d');
    temp_canvas.width = theSelection.w; //자른 이미지 넓이
    temp_canvas.height = theSelection.h; //자른 이미지 높이
    temp_ctx.drawImage(image, theSelection.x, theSelection.y, theSelection.w, theSelection.h, 0, 0, theSelection.w, theSelection.h);
    var vData = temp_canvas.toDataURL();
    $('#crop_result').attr('src', vData);
}

</script>

<style>
html, body { width: 100%; height: 100%;}
body {  background-size: 100% 100% }
#container{}
#results{}
#crop_button{}
h2{text-align: center;}
</style>

</head>
    <body onunload="opener.child_close()" style ="font-family: 'Nanum Gothic Coding', monospace;">
    
    <!-- 사이드 바 -->
	<aside class="probootstrap-aside js-probootstrap-aside" style = "background-color: aliceblue;">
		
		<div class="probootstrap-site-logo probootstrap-animate" 
			data-animate-effect="fadeInLeft" style="padding: 30px 30px 0px 30px; opacity: 1;">
			<p class="mb-2 d-block probootstrap-logo" >CROP PHOTO</p>
		</div>
		<div class="probootstrap-overflow">
			<div class="main">
			<button class = "button" style = "margin :auto; margin-top: 90px; width : 200px;"onclick="getResults()" id="crop_button">
				CROP
				<div class="button__horizontal"></div>
				<div class="button__vertical"></div>
			</button>
			
			<button class = "button" style = "margin :auto; margin-top: 70px; width : 200px;"onclick="location.reload()" id="restore_button">
				RESTORE
				<div class="button__horizontal"></div>
				<div class="button__vertical"></div>
			</button>
			
			<button class = "button" style = "margin :auto; margin-top: 70px; width : 200px;" onclick="pass_parent()" id="save_button">
				SAVE
				<div class="button__horizontal"></div>
				<div class="button__vertical"></div>
			</button>
			
			<button class = "button" style = "margin :auto; margin-top: 70px; width : 200px;" onclick="window.close()" id="exit_button">
				EXIT
				<div class="button__horizontal"></div>
				<div class="button__vertical"></div>
			</button>
			
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
			<div class="container" style ="text-align: center; padding : 20px; margin-right: 50px;">
            	<canvas id="panel" width="${picture_width}" height="${picture_height}"></canvas>
	            <div id="results">
	                <img id="crop_result"/>
	            </div>
        	</div>			
		</div>
		<!-- END row -->		
	</div>

	</main>

</body>
    
    
</html>
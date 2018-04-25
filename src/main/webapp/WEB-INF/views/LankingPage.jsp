<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>LankingPage</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Work+Sans">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/css/graph.css">
<link rel="stylesheet" href="resources/css/green.css">
<link rel="stylesheet" href="resources/css/icomoon.css">
<link rel="stylesheet" href="resources/css/animate.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/popper.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>
<script type="text/javascript" src="http://www.workshop.rs/jqbargraph/jqBarGraph.js"></script>
<script src="resources/js/icheck.js"></script>
<script src="resources/js/owl.carousel.min.js"></script>
<script src="resources/js/jquery.waypoints.min.js"></script>
<script src="resources/js/imagesloaded.pkgd.min.js"></script>
<script src="resources/js/main.js"></script>

<script>
$( function() {
    $( "#datepicker" ).datepicker({
    	 dateFormat: "yy-mm-dd",
    	 dayNamesShort: [ "일", "월", "화", "수", "목", "금", "토" ],
    	 dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
    	 dayNames: [ "일", "월", "화", "수", "목", "금", "토" ],
    	/*  changeYear: true,
    	 changeMonth: true,  // 편하기는 하겠으나 제공해줄 생각 없음*/
    	 maxDate: "-1",
    	 minDate: new Date(2010, 1 - 1, 1),
    	 showOtherMonths: true,
    	 selectOtherMonths:true,
    	 showAnim: "fadeIn",
    	 showMonthAfterYear: true
    	 /* monthNamesShort: [ "Jan", "Feb", "Mar", "Apr", "Maj", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dec" ] //바꿔봤지만 안이쁨*/
  	 });
});


function checkRadio(){
   var temp;   
   var radioObj = document.all('iCheck');   
   var isChecked;
   if(radioObj.length == null)
   { 
	   // 라디오버튼이 같은 name 으로 하나밖에 없다면
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
	   temp = radioObj[i].value; 	   
	   //value값
	   switch (temp) {
	      case '1':
	    	 categorysearch(); 
	         break;
	      case '2':
	    	  searchsearch();
	         break;
	      case '3':
	    	 likesearch();
	         break;    
	   }
   }else{
   }	 
}

$(document).ready(function() {
	 $('#datepicker').on('change' , function(){
		 checkRadio();
	});
	 $('.input').on('ifChanged' , function(){
		  checkRadio(); 
	 });
});
function likesearch(){
	var num = 0;
	//밑 에 부분은 좋아요에 관련된 부분
	if($('#datepicker').val() != null){
		$.ajax({
			url:'searchLike',
			type:'POST',		
			data:{searchdate:$('#datepicker').val()},
			dataType:"json",
			success: function(list){
				array = new Array();
				$.each(list,function(i,data){
					var count = 0;
					var word = '';	
					$.each(data,function(key,value){
						if(key == 'LIKEIT_ALBUMNUM'){
							word = value;
						}else if(key == 'COUNT'){
							count = value;
						}
					});
					num++;
					array[i] = [count , word , '#f3f3f3'];						
				});
				graphcreate(array , num);
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}
function searchsearch(){
	var num = 0;
	//밑 에 부분은 검색어에 관련된 부분
	if($('#datepicker').val() != null){
		$.ajax({
			url:'searchInformation',
			type:'POST',		
			data:{searchdate:$('#datepicker').val()},
			dataType:"json",
			success: function(list){
				array = new Array();
				$.each(list,function(i,data){
					var count = 0;
					var word = '';
					$.each(data,function(key,value){
						if(key == 'SEARCH_WORD'){
							word = value;
						}else if(key == 'COUNT'){
							count = value;
						}
					});	
					num++;
					array[i] = [count , word , '#f3f3f3'];		
				});
				graphcreate(array,num);				
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}
function categorysearch(){	
	var num = 0;
	//밑에 부분은 카테고리 검색에 관한 부분
	if($('#datepicker').val() != null){
		var vector = ['여행' , '음식'];
		$.ajax({
			url:'searchCategorypop',
			type:'POST',		
			data:{searchdate:$('#datepicker').val()},
			dataType:"json",
			success: function(list){
				array = new Array();
				$.each(list,function(i,data){
					var count = 0;
					var kind = 0;
					$.each(data,function(key,value){
						if(key == 'KIND'){
							kind = value;
						}else if(key == 'COUNT'){
							count = value;
						}
					});	
					num++;
					array[i] = [count ,vector[kind], '#f3f3f3'];		
				});
				graphcreate(array , num);
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}

function graphcreate(array , num){
	$('#graphdiv').html('');
	var width = 100 * num;
	if(width > 1000){
		width = 1000
	}else if(width < 150){
		width = 150;
	}
	$('#graphdiv').jqBarGraph({ 
		data: array,
		animate: false,
		width:width,
		height:550,
		sort:'desc',
		barSpace : 10
	});
}
</script>
<!-- 정렬순 라디오 버튼 -->
<script>
$(document).ready(function(){
  $('input').iCheck({
    checkboxClass: 'icheckbox_square-green',
    radioClass: 'iradio_square-green',
    increaseArea: '20%' // optional
  }); 
});
</script>
<style>
.img1 {
	width: 50px;
	height: 50px;
}

 @media screen and (max-width: 768px) {
   .probootstrap-main .search-bar{
      width: 100%;
      padding: 30px 15px; 
      padding-top: 30px;
	  padding-bottom: 30px;
      } }


select {
  width: 100px; 
  font-family: inherit;
  background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%;  
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  border: 1px solid #999;
  border-radius: 0px;
}

select::-ms-expand { /* for IE 11 */
    display: none;
}


</style>
</head>
<body>

	<aside class="probootstrap-aside js-probootstrap-aside">
		<a href="#" class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-left"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">

			<a href="/www" class="mb-2 d-block probootstrap-logo">COOING</a>

			<!-- 로그인되어있을 때 -->
			<c:if test="${Member ne null}">
				<p>
					<img src="<c:url value="/jinsu/img" />" class="img1">${Member.getMember_id()}
				</p>
			</c:if>
			<!-- 로그인 안되어있을 때 -->
			<c:if test="${Member eq null}">
				<p>
					<img class="img1" src="http://1.bp.blogspot.com/-t9dmAueNbW0/VQYvJX7kVrI/AAAAAAAAGYY/Ou05G2Vi2kw/s1600/1%2B(3).jpg">Please LOGIN
				</p>
			</c:if>

		</div>
		<div class="probootstrap-overflow">
			<nav class="probootstrap-nav">
				<p>LANKINGPAGE</p>
				<p>오늘의 랭킹</p>
				<p></p>
				<p>CATEGORY</p>
				<ul>

					<li class="category" data="0">여행</li>
					<li class="category" data="1">음식</li>
					<li><a href="<c:url value ="/"/>">MainPage</a></li>
					<li><a href="<c:url value ="/myPage"/>">myPage</a></li>
					<li><a href="<c:url value ="/jinsu/member_get"/>">회원가입...</a></li>
					<li><a href="<c:url value ="/jinsu/login_get"/>">로그인...</a></li>
					<li><a href="<c:url value ="/jinsu/logout_get"/>">로그아웃</a></li>
					
				</ul>				
				
			</nav>
		</div>		
	</aside>


	<main role="main" class="probootstrap-main js-probootstrap-main">
	<div class="probootstrap-bar">
		<a href="#" class="probootstrap-toggle js-probootstrap-toggle">
			<span class="oi oi-menu"></span>
		</a>
		<div class="probootstrap-main-site-logo">
			<a href="index.html">COOING</a>
		</div>
		<a href="#" class="probootstrap-toggle2 js-probootstrap-toggle2">
			<span class="oi oi-menu"></span>
		</a>	
	</div>		
		
	<div class ="search-bar">
		<br><br>
		<div style = "margin-left: 20px;">
       			 SEARCH &nbsp<img id='image_search' src="https://3.bp.blogspot.com/-2CWX7kIpob4/WZgVXt3yTQI/AAAAAAAAACM/N1eGT1OD7rklb4GtsadoxYRyWZoR_aI0gCLcBGAs/s1600/seo-1970475_960_720.png" style="width: 24px;
       			 height: 24px;margin-right: 5px;" onclick="var inputBox = document.getElementById('searchtx');
       			 inputBox.style.width = '200px';
        		 inputBox.style.paddingLeft='3px';
       			 inputBox.value='';
       			 inputBox.focus();">
     			 <input id='searchtx' type="text" onblur="this.style.width='0px';
             	  this.style.paddingLeft='0px';" style="  border: none;
              	 background-color: rgba(0,0,0,0);
              	 color: #666666;
               	 border-bottom: solid 2px #333;
               	 outline: none;
              	  width: 0px;
               	 transition: all 0.5s;" onkeydown="if(event.keyCode==13){searchfriend();}">		
		
	</div>
		<br>	
	
	
	<div class="card-columns" id="card-columns">
	
	<div align="center">
		날 짜 선 택 : <input type="text" id="datepicker">
		<!-- 정렬순서 -->		
		<form style = "float:right; padding-left : 10px;" id="radiobutton">
			<input type="radio" name="iCheck" class="input"value="1" checked>카테고리순 
			<input type="radio" name="iCheck" class="input"value="2">검색어순
			<input type="radio" name="iCheck" class="input"value="3">좋아요순
		</form>
	</div>	
		<!-- 그래프 출력될 곳 -->
		
		<!-- <div id="graphdiv" style="width:100%;height:100%"></div>	 -->	
	
	</div>
	
	
	
	<div id="graphdiv" style="width:100%;height:100%;margin:0 auto;"></div>
	

	<div class="container-fluid d-md-none">
	
		<div class="row">
		
			<div class="col-md-12">				
				<p>
					<!-- &copy; 2018<a href="https://uicookies.com/" target="_blank">COOING</a>.
					<br> All Rights Reserved. Designed by <a
						href="https://uicookies.com/" target="_blank">COOING</a> -->
							
				</p>
			</div>
		</div>
	</div>

	</main>


	<aside class="probootstrap-aside2 js-probootstrap-aside2">
		<a href="#"
			class="probootstrap-close-menu js-probootstrap-close-menu d-md-none">
			<span class="oi oi-arrow-right"></span> Close
		</a>
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="" class="mb-2 d-block probootstrap-logo">MY FRIEND</a>			
		</div>				
				 <form>
					<input type="text" placeholder="친구검색" id="friendsearch" class="search1" >
					<input type="button" id="friendsearchbt" value="s">
				</form>
			<div class = "friendList">
				<c:if test="${Member ne null}">
					<c:if test="${fn:length(friend) ne 0}">
						<c:forEach var="arrf" items="${friend }">
							<div name="friend">
								<p onclick="openChat('1', '${arrf}')">${arrf}</p>
							</div>
						</c:forEach>
					</c:if>
				</c:if>
			</div>
		
		<div class="probootstrap-site-logo probootstrap-animate" data-animate-effect="fadeInLeft">
			<a href="" class="mb-2 d-block probootstrap-logo">MY GROUP</a>				
		</div>				
		<!-- <div class="probootstrap-overflow"> -->
		<input type="button" value="그룹생성"
					onclick="window.open('./groupcreate_get?','','width=500 height=1000 left=50% top=50% fullscreen=no,scrollbars=no,location=no,resizeable=no,toolbar=no')">
			<div class = "groupList">
				<c:if test="${Member ne null}">
					<c:if test="${fn:length(group) ne 0}">
						<c:forEach var="party" items="${group}">
							<div name="group">
								<p onclick="openGUpdate('${party.party_name}')"
									partynum="${party.party_num}">${party.party_name}</p>
								<input type="button" value="채팅"
									onclick="openChat('0', '${party.party_num}', '')" />
							</div>
						</c:forEach>
					</c:if>
				</c:if>				
			<!-- </div> -->
		</div>

	</aside>
	<div id="div_chat" 
		style="width: 500px; height: 500px; position: absolute; padding: 0px; opacity: 1; background-color: rgb(240, 240, 240); display: none;">
		<p>
			<button id="button_close" onclick="closePChat()">닫기</button>
		</p>
		<div id="data" 
			style="height: 350px; width: 100%; overflow-y: scroll; margin: auto; display: block; padding: 0px"></div>

		<div id="div_send">
			<input type="text" id="message" autocomplete="off" />
			<input type="button" id="sendBtn" value="전송" />
		</div>
	</div>

</body>
</html>
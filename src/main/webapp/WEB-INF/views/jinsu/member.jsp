 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입</title>
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
	checkcount();
});
function readURL(input){ 
	if(input.files[0]){
		if(input.files[0].size < 3000000){
			if ((/png|jpe?g|gif/i).test(input.files[0].name)) {
				var reader = new FileReader();
				reader.onload = function(e){			
					$('#preview').attr('src' , e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
			else{
				alert('png,jpg,gif만 가능합니다.');
			}
		}	
		else{
			alert('이미지의 용량은 3MB를 초과할 수 없습니다.');
		}
	}
}
function initialize(){
	$('#idcheck').on('click' , idcheck);
	$('#upload').on('change',function(){
		readURL(this);
	});
}

function idcheck(){
	if($('#id').val().legnth == 0){
		alert('ID를 입력해 주세요.');
		return false;
	}
	
	$.ajax({
		url:'id_check',
		type:'POST',		
		data:{id:$('#id').val()},
		dataType:'text',
		success: function(a){
			if(a == 'success'){
				$('#join').on('click' , joinmember);
				alert('사용 가능한 ID입니다.');
			}
			else{
				alert('이미 사용중인 ID입니다.');
			}		
		},
		error:function(e){alert(JSON.stringify(e));}		
	});	
}

function joinmember(){
	if(!member_check())
		return false;
	
	var checkArr = new Array;
	$('input[type="checkbox"]:checked').each(function(){
	      checkArr.push($(this).val());
	  });
	
	$.ajax({
		url:'member_check',
		type:'POST',		
		data:{member_id:$('#id').val() , member_pw:$('#password').val()},
		dataType:"text",
		success: function(a){
			if(a == 'success'){
				$('#member_form').submit();
			}
			else{
				alert('형식을 다시 한번 입력해 주세요.');
			}		
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
	
}
function checkcount(){
	$('input[type="checkbox"]').on('click' , function(){
		var count = 0;
		$('input[type="checkbox"]:checked').each(function(){
			count++;
		});
		if(count > 3){
			$(this).prop('checked' , false);
			alert('3개 이상 선택할 수 없습니다.'); 				
		}			
	});
}
function member_check(){	
	if($('#id').val().legnth == 0){
		alert('ID를 입력해 주세요.');
		return false;
	}
	if($('#password').val().length == 0){
		alert('비밀번호를 입력 해주세요.');
		return false;
	}
	if($('#password2').val().length == 0){
		alert('비밀번호를 입력 해주세요.');
		return false;
	}
	if($('#password').val() != $('#password2').val()){
		alert('비밀번호를 다르게 입력하셨습니다.');
		return false;
	}
	
	return true;
}
</script>
</head>
<body>

<a>MemberPage</a>

<fieldset>
	<legend><strong>회 원 가 입</strong></legend>	
	<form action="member_post" method="POST" id="member_form" enctype="multipart/form-data">
		<table>
			<tr><th>IMAGE : </th><td><img src="" height="200" width="200" alt="main image.." id="preview"></td></tr>
			<tr><th>ID : </th>	<td><input type="text" id="id" name="member_id" maxlength="10" required autofocus></td>
								<td><input type="button" id="idcheck" value="id중복체크"></td></tr>
			<tr></tr>
			<tr><th rowspan="3"> 비밀번호 : </th>	<td><input type="password" id="password" name="member_pw" maxlength="12" required></td></tr>
											<tr><td><input type="password" id="password2" maxlength="12" required></td></tr>
			<tr><td height="5" colspan="2"><font size="1px"><span style="color:red;">※</span>비밀번호는 6~12글자  /, &, \<, >, | 를 제외한 문자 사용 가능합니다.  </font></td></tr>
			<tr></tr>
			<tr><th rowspan="5">좋아하는 장르</th><td colspan="2">
					여행<input type="checkbox" name="hobby" value="0">
					스포츠 및 레저<input type="checkbox" name="hobby" value="1">
					동물<input type="checkbox" name="hobby" value="2">
					음악<input type="checkbox" name="hobby" value="3">
					음식 및 요리<input type="checkbox" name="hobby" value="4">
					<tr><td colspan="2">
					패션 및 뷰티<input type="checkbox" name="hobby" value="5">
					연예 및 TV<input type="checkbox" name="hobby" value="6">
					게임<input type="checkbox" name="hobby" value="7">
					영화<input type="checkbox" name="hobby" value="8">
					도서<input type="checkbox" name="hobby" value="9">
					</td></tr><tr><td colspan="2">
					공연 및 전시<input type="checkbox" name="hobby" value="10">
					외국어<input type="checkbox" name="hobby" value="11">
					전문지식<input type="checkbox" name="hobby" value="12">
					수집 및 제작<input type="checkbox" name="hobby" value="13">
					자기계발<input type="checkbox" name="hobby" value="14">
					</td></tr><tr><td colspan="2">
					육아<input type="checkbox" name="hobby" value="15">
					일상생활<input type="checkbox" name="hobby" value="16">
					자동차<input type="checkbox" name="hobby" value="17">
					낚시<input type="checkbox" name="hobby" value="18">
					건강<input type="checkbox" name="hobby" value="19">	
				</td></tr>
			<tr><td height="5" colspan="2"><font size="1px"><span style="color:red;">※</span>최대 3개까지만 선택</font></td></tr>
			<tr><th>FILE</th><td><input type="file" id="upload" name="upload" accept="image/*"></td></tr>
			<tr align="right"><td colspan="3"><input type="button" id="join" value="가입">
							<input type="button" onclick="javascript:location.href='<c:url value="/"/>';" value="취소"></td></tr>
		</table> 
	</form>
</fieldset>


</body>
</html> --%>


<head>
    <meta charset="utf-8">
    <title>회원가입</title>
<style>
  html,body{width:100%;height:100%}
    body,p,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,table,th,td,form,fieldset,legend,input,textarea,button,select{margin:0;padding:0}
    body,input,textarea,select,button,table{font-family:'돋움',Dotum,AppleGothic,sans-serif;font-size:12px}
    img,fieldset{border:0}
    img{vertical-align:top}
    ul,ol{list-style:none}
    em,address{font-style:normal}
    .blind,legend{display:block;position:absolute;left:0;top:-9999em;overflow:hidden}
    hr{display:none}
    a{text-decoration:none}
    a:hover,a:active,a:focus{text-decoration:underline}

body{
	width : 900px;
	margin : 0 auto;
	background-color: #f5f6f7;	
}
div {
	border: 1px solid #ccc; /* 모든 영역에 테두리 표시 */
	padding : 20px;
}
#header {
	padding:10px;  /* 패딩 */
	margin:0 0 10px 0;			
	width:900px;
	position: fixed;
	background-color:#FFB2F5;
	color: #F6F6F6;
	text-align: center;
}
#content {
	padding: 10px;  /* 패딩 */
	width : 900px;
	margin-top:110px;
	float: left;  /* 왼쪽으로 플로팅 */			
}		
.img {
	border: 1px solid #ccc;
}
#content fieldset {
        border: 1px solid #dadada;
        margin-bottom: 10px;
        background-color: #fff;
    }
    #content fieldset .field {
        position: relative;
        border-bottom: 1px solid #f0f0f0;
    }
    #content fieldset .field.btn-radio {
        height: 49px;
    }
    #content fieldset .field:last-of-type {
        border-bottom: 0;
    }
    #content fieldset .field .inp-field {
        width: 350px;
        height: 49px;
        border: 0 none;
        color: #999;
        font-size: 14px;
        text-indent: 12px;
        line-height: 49px;
    }
    #content fieldset .field .ico {
        position: absolute;
        top: 0;
        right: 11px;
        display: block;
        width: 97px;
        height: 48px;
        background: url(img/ico_join3_20170202.png) no-repeat;
        text-indent: -9999em;
    }
    #content fieldset .field .ico.mail {
        background-position: 0 -47px;
    }
    #content fieldset .field .ico.pass {
        background-position: 0 -466px;
    }
    #content fieldset .field .ico.pass2 {
        background-position: 0 -515px;
    }
    #content fieldset .field .btn-label {
        position: absolute;
        top: 8px;
        z-index: 10;
        display: block;
        width: 212px;
        height: 31px;
        border: 1px solid #dcdcdc;
        background-color: #fff;
        color: #999;
        text-align: center;
        line-height: 31px;
        cursor: pointer;
    }
    #content fieldset .field .btn-label.on {
        z-index: 15;
        border-color: #2eaa08;
        color: #2eaa08;
    }
    #content fieldset .field .btn-label.male {
        left: 15px;
    }
    #content fieldset .field .btn-label.female {
        left: 228px;
    }
    #content fieldset .field.btn-radio input {
        position: relative;
        left: 50px;
        top: 14px;
    }
    #content fieldset .field.birth:after,
    #content fieldset .field.confirm:after {
        content: '';
        display: block;
        clear: both;
    }
    #content fieldset .field.birth label {
        float: left;
        width: 53px;
        height: 49px;
        border-right: 1px solid #efefef;
        background-color: #f7f7f7;
        color: #999;
        text-align: center;
        line-height: 49px;
    }
    #content fieldset .field.birth input {
        float: left;
    }
    #content fieldset .field.birth select,
    #content fieldset .field.confirm select {
        float: left;
        margin-top: 10px;
        margin-left: 17px;
        width: 110px;
        height: 29px;
        background: url(img/sel_arr.gif) no-repeat 100% 50%;
        border: 0 none;
        font-size: 15px;
        font-weight: bold;
        line-height: 29px;
        -webkit-appearance: none;
    }
    #content fieldset .field.birth .field-wall,
    #content fieldset .field.confirm .field-wall {
        float: left;
        width: 0;
        height: 29px;
        margin-top: 10px;
        border-right: 1px solid #f0f0f0;
        text-indent: -9999em
    }
    #content fieldset .field.confirm input {
        float: left;
    }
    #content fieldset .field.confirm .btn-click {
        position: absolute;
        top: 9px;
        right: 15px;
        width: 99px;
        height: 31px;
        border: 1px solid #dcdcdc;
        background-color: #fff;
        color: #333;
        text-align: center;
        line-height: 31px;
        cursor: pointer;
    }

    #content .join .btn-area {
        padding-top: 43px;
    }
    #content .join .btn-area .btn-submit {
        width: 100%;
        border: 1px solid #1eb702;
        height: 59px;
        background: #1fbc02 url(img/btn_join2.gif) no-repeat 50% -1px;
        text-indent: -9999em;
        cursor: pointer;
    }





</style>
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
	checkcount();
});
function readURL(input){ 
	if(input.files[0]){
		if(input.files[0].size < 3000000){
			if ((/png|jpe?g|gif/i).test(input.files[0].name)) {
				var reader = new FileReader();
				reader.onload = function(e){			
					$('#preview').attr('src' , e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
			else{
				alert('png,jpg,gif만 가능합니다.');
			}
		}	
		else{
			alert('이미지의 용량은 3MB를 초과할 수 없습니다.');
		}
	}
}
function initialize(){
	$('#idcheck').on('click' , idcheck);
	$('#upload').on('change',function(){
		readURL(this);
	});
}

function idcheck(){
	if($('#id').val().legnth == 0){
		alert('ID를 입력해 주세요.');
		return false;
	}
	
	$.ajax({
		url:'id_check',
		type:'POST',		
		data:{id:$('#id').val()},
		dataType:'text',
		success: function(a){
			if(a == 'success'){
				$('#join').on('click' , joinmember);
				alert('사용 가능한 ID입니다.');
			}
			else{
				alert('이미 사용중인 ID입니다.');
			}		
		},
		error:function(e){alert(JSON.stringify(e));}		
	});	
}

function joinmember(){
	if(!member_check())
		return false;
	
	var checkArr = new Array;
	$('input[type="checkbox"]:checked').each(function(){
	      checkArr.push($(this).val());
	  });
	
	$.ajax({
		url:'member_check',
		type:'POST',		
		data:{member_id:$('#id').val() , member_pw:$('#password').val()},
		dataType:"text",
		success: function(a){
			if(a == 'success'){
				$('#member_form').submit();
			}
			else{
				alert('형식을 다시 한번 입력해 주세요.');
			}		
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
	
}
function checkcount(){
	$('input[type="checkbox"]').on('click' , function(){
		var count = 0;
		$('input[type="checkbox"]:checked').each(function(){
			count++;
		});
		if(count > 3){
			$(this).prop('checked' , false);
			alert('3개 이상 선택할 수 없습니다.'); 				
		}			
	});
}
function member_check(){	
	if($('#id').val().legnth == 0){
		alert('ID를 입력해 주세요.');
		return false;
	}
	if($('#password').val().length == 0){
		alert('비밀번호를 입력 해주세요.');
		return false;
	}
	if($('#password2').val().length == 0){
		alert('비밀번호를 입력 해주세요.');
		return false;
	}
	if($('#password').val() != $('#password2').val()){
		alert('비밀번호를 다르게 입력하셨습니다.');
		return false;
	}
	
	return true;
}
</script>
</head>
<body>
        <div id="header">
			<h1>COOING</h1>
		</div>
				
		<div id="content">			

            <div class="join">
            <form action="member_post" method="POST" id="member_form" enctype="multipart/form-data">	
            
            <fieldset>
                    <legend>IMAGE</legend>
                    <p class="field">
                        <img src="" height="200" width="200" alt="main image.." id="preview" class = "img">
                    </p>
                    <p class="field btn-radio">
                        <label for="male" class="btn-label male on">남자</label>
                        <input type="radio" id="male" name="user-s" value="male">
                        <label for="female" class="btn-label female">여자</label>
                        <input type="radio" id="female" name="user-s" value="female">
                    </p>
                   
                </fieldset>
                <fieldset>
                    <legend>아이디, 비밀번호</legend>
                    <p class="field">
                        <label for="user-id" class="blind">아이디</label>
                        <input type="text" id="user-id" placeholder="아이디" class="inp-field">
                        <span class="ico mail">@naver.com</span>
                    </p>
                    <p class="field">
                        <label for="user-pass" class="blind">비밀번호</label>
                        <input type="password" id="user-pass" placeholder="비밀번호" class="inp-field">
                        <span class="ico pass"></span>
                    </p>
                    <p class="field">
                        <label for="user-pass2" class="blind">비밀번호 재확인</label>
                        <input type="password" id="user-pass2" placeholder="비밀번호 재확인" class="inp-field">
                        <span class="ico pass2"></span>
                    </p>
                </fieldset>
                
                <fieldset>
                    <legend>전화번호인증</legend>
                    <p class="field confirm">
                        <label for="user-num" class="blind">인증번호받기</label>
                        <select id="user-num" title="국가번호를 선택하세요">
                            <option value="+82">+82</option>                            
                        </select>
                        <span class="field-wall">|</span>
                        <input type="text" placeholder="휴대전화번호" title="휴대전화번호를 입력하세요" class="inp-field w205">
                        <button type="button" class="btn-click">인증</button>
                    </p>
                    <p class="field confirm">
                        <label for="user-confirm" class="blind">인증번호입력</label>
                        <input type="text" id="user-confirm" placeholder="인증번호" class="inp-field w330">
                        <button type="button" class="btn-click">확인</button>
                    </p>
                </fieldset>
                <div class="btn-area">
                    <input type="submit" value="가입하기" class="btn-submit">
                </div>
            </form>
            </div>
        </div>




		</div>
		
  
</body>
</html>
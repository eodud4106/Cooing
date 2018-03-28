<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MemberPage</title>
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
		dataType:"text",
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
</html>
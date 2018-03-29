<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
});
function initialize(){
	$('#join').on('click' , joinmember);
}
function joinmember(){
	if(!member_check())
		return false;
	
	$.ajax({
		url:'login_post',
		type:'POST',		
		data:{member_id:$('#id').val() , member_pw:$('#password').val()},
		dataType:"text",
		success: function(a){
			if(a == 'success'){
				//상대 주소로 되어있기에 나중에 절대주소로 바뀌어야 할 듯 하다.
				location.href="../";		
			}
			else{
				alert('ID 혹은 비밀버호가 틀렸습니다.');
			}		
		},
		error:function(e){alert(JSON.stringify(e));}		
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
	
	return true;
}
</script>
</head>
<body>

<fieldset>
	<legend><strong>로그인</strong></legend>
	<table>
		<tr><th>ID : </th>	<td><input type="text" id="id" maxlength="10" required autofocus></td></tr>
		<tr><th> 비밀번호 : </th>	<td><input type="password" id="password" maxlength="12" required></td></tr>
		<tr align="right"><td colspan="2"><input type="button" id="join" value="가입">
							<input type="button" onclick="javascript:location.href='<c:url value="/"/>';" value="취소"></td></tr>
	</table>	
</fieldset>

</body>
</html>
/**
 * 로그인 관련 메소드 모음
 */

function loginmember(toRoot){
	if(!member_check()) return false;
	
	$.ajax({
		url: toRoot + 'login_post',
		type:'POST',		
		data:{
			member_id: $('#id').val(),
			member_pw: $('#password').val()
		},
		dataType:"text",
		success: function(a){
			if(a == 'success'){
				//상대 주소로 되어있기에 나중에 절대주소로 바뀌어야 할 듯 하다.
				location.href=toRoot;
			}
			else{
				alert('ID 혹은 비밀번호가 틀렸습니다.');
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
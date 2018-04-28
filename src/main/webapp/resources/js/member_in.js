/**
 *  회원가입 관련 
 */



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

//아마 사진 때문에 오류인듯...
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
	
	var checkArr = new Array;
	$('input[type="checkbox"]:checked').each(function(){
	      checkArr.push($(this).val());
	});
	
	if(member_check() == false) {return false;}
	
	$.ajax({
		url:'member_check',
		type:'POST',		
		data:{member_id:$('#id').val() , member_pw:$('#password').val()},
		dataType:"text",
		success: function(a){
			if(a == 'success'){
				alert('회원가입에 성공하였습니다. 로그인 창으로 이동합니다.');
				$('#member_form').submit();
			}
			else{
				alert('회원가입 형식을 위배하였습니다. 다시 확인해주세요.');
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
	if($('#id').val().length < 5 || $('#id').val().length > 12){
		alert('※아이디는 5~12글자 /, &, \<, >, | 를 제외한 문자 사용 가능합니다.');
		return false;
	}
	if($('#password').val().length < 6 || $('#password').val().length > 12){
		alert('※비밀번호는 6~12글자 /, &, \<, >, | 를 제외한 문자 사용 가능합니다.');
		return false;
	}
	if($('#password').val() != $('#password2').val()){
		alert('입력하신 비밀번호가 다릅니다. 다시 입력해주세요.');
		return false;
	}
	
	return true;
}
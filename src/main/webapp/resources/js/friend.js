/**
 *  친구 페이지 관련 js
 */

function initialize(){
	$('#friendbt').on('click',fiendplus);
}
function fiendplus(){
	var friendid = $('#friendid').val();
	var data = $('#friendbt').attr('data');
	if(data == 0){
		$.ajax({
			url:'friend_plus',
			type:'POST',		
			data:{friendid:friendid},
			dataType:'text',
			success: function(a){
				if(a=='success'){
					$('#friendbt').val('친구삭제');
					$('#friendbt').attr('data' , '1');
				}
				else{
					alert(a);
				}
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}else if(data == 1){
		$.ajax({
			url:'friend_delete',
			type:'POST',		
			data:{friendid:friendid},
			dataType:'text',
			success: function(a){
				if(a=='success'){
					$('#friendbt').val('친구추가');
					$('#friendbt').attr('data' , '0');
				}
				else{
					alert(a);
				}
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}
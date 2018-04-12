/**
 * home관련 js
 * 
 */

function initialize(){
	$('#searchbt').on('click', function() {
		searchfriend();
	});
	$('#searchtx').keyup(function() {
		searchword();
	});
	$('#login').on('click', function() {
		loginmember('');
	});
}
function openGUpdate(group_name) {
	var url = "groupPage?group_name=" + group_name;  
	location.href=url;
}
function searchfriend(){
	var text = $('#searchtx').val();
	$.ajax({
		url:'friend_check',
		type:'POST',		
		data:{id:text},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				location.href='./friend_get?id='+text;
			}
			else{
				alert('찾으시는 친구 ID가 없습니다.');
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function searchword(){
	var text = $('#searchtx').val();
	if(text.length >= 2){
		$.ajax({
			url:'jinsu/search_id',
			type:'POST',		
			data:{text:text},
			dataType:'json',
			success: function(array){
				$('#searchtx').autocomplete({
					source:array
				});
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}
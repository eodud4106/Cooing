/**
 *  친구 페이지 관련 js
 */

function initialize(){
	$('#friendbt').on('click',fiendplus);
	
	$('window').click(function(event) {
		if (event.target == $('#myModal')) {
			$('#myModal').css('display', 'none');
	    }
	});
	
	$('#myBtn').click(function() {
		$('#myModal').css('display', 'block');
	});
	
	$('#myBtn_close').click(function() {
		$('#myModal').css('display', 'none');
	});
	
	$('#createBtn').click(function() {
		$('#album_create_modal').css({
			'display': 'block',
			'z-index': '10000'
		});
	});
	
	$('#friendsearchbt').on('click', function() {
		searchfriend();
	});
	//초기 친구 찾을 때만 사용했었음
	$('#friendsearch').keyup(function() {
		searchword();
	});
	
	$('#searchbt').on('click' , function(){
		location.href = './search_other?search=' + $('#searchtx').val() + '';
	});
	
	$('.category').on('click' , function(){
		searchCategory($(this).attr('data'));
		location.href = './category_other?categorynum=' + $(this).attr('data') + '';
	});
	
	$('#createBtn_close').click(function() {
		$('#album_create_frame').attr('src', '/AlbumNameCreate');
		$('#album_create_modal').css({
			'display': 'none',
			'z-index': '0'
		});
	});
}

function fiendplus(){
	var friendid = $('#friendid').val();
	var data = $('#friendbt').attr('data');
	alert(friendid +  ',' + data);
	if(data == 0){
		$.ajax({
			url:'friend_plus',
			type:'POST',		
			data:{friendid:friendid},
			dataType:'text',
			success: function(a){
				if(a=='success'){
					$('#friendbt').html('<i class="fas fa-user-times"></i>');
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
					$('#friendbt').html('<i class="fas fa-user-plus"></i>');
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
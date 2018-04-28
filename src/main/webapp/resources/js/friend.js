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
	
	//초기 친구 찾을 때만 사용했었음
	$('#friendsearch').keyup(function() {
		searchword();
	});
	
	$('#searchtx').keydown(function(event){
		if(event.keyCode == 13){
			pagenum = 0;
			getIDAlbumList();
		}
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
	
	searchword();
}

function fiendplus(){
	var friendid = $('#friendidval').val();
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

//앨범 리스트 Ajax로 받는 코드
function getIDAlbumList() {
	var check  = false;
	if(pagenum == 0)
		check  = true;
	var searchtx = $('#searchtx').val();
	var albumwriter = $('#friendidval').val();
	$.ajax({
		url: 'album/getIDAlbumList',
		type: 'post',
		data:{albumwriter:albumwriter,
				pagenum:++pagenum,
				search:searchtx
				},
		dataType: 'json',
		success: function(result) {
			AlbumListPaging(check , result);
			$.ajax({
				url: 'album/getIDAlbumCount',
				type: 'post',
				data:{albumwriter:albumwriter,
						search:searchtx
						},
				dataType: 'text',
				success: function(count) {
					//total count 변경 부분
					$('#totalpage').val(count);
				},
				error: function(e) {
					alert(JSON.stringify(e));	
				}
			});
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}












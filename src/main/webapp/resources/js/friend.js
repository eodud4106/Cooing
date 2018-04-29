/**
 *  친구 페이지 관련 js
 */

function initialize(){
	$('#friendbt').on('click',fiendplus);
	
	//초기 친구 찾을 때만 사용했었음
	$('#friendsearch').keyup(function() {
		searchword();
	});
	
	$('#searchtx').keydown(function(event){
		if(event.keyCode == 13){
			searchcheck = 99;
			getIDAlbumList();
		}
	});	
	
	$('.category').on('click' , function(){
		searchcheck = 99;
		$('#searchtx').val('');
		$('#categorynum').val($(this).attr('data'));
		getIDCategoryAlbumList();
	});
	
	searchword();
}

function fiendplus(){
	var friendid = $('#friendidval').val();
	var data = $('#friendbt').attr('data');
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

//카테고리 앨범 리스트 Ajax로 받는 코드
function getIDCategoryAlbumList() {
	var check  = false;
	if(searchcheck != 1){
		searchcheck = 1;
		pagenum = 0;
	}
	if(pagenum == 0)
		check  = true;
	var catgorynum = $('#categorynum').val();
	var albumwriter = $('#friendidval').val();
	$.ajax({
		url: 'album/getIDCategoryAlbumList',
		type: 'post',
		data:{
			categorynum:catgorynum,
			albumwriter:albumwriter,
			pagenum:++pagenum
		},
		dataType: 'json',
		success: function(result) {
				AlbumListPaging(check , result);
				$.ajax({
					url: 'album/getIDCategoryAlbumCount',
					type: 'post',
					data:{
						categorynum:catgorynum,
						albumwriter:albumwriter
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

//앨범 리스트 Ajax로 받는 코드
function getIDAlbumList() {
	var check  = false;
	if(searchcheck != 0){
		searchcheck = 0;
		pagenum = 0;
	}
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












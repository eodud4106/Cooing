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
			get_friend_album_list('writer','friend','date', ++pagenum , 0);
		}
	});	
	
	$('.category').on('click' , function(){
		searchcheck = 99;
		$('#searchtx').val('');
		$('#categorynum').val($(this).attr('data'));
		get_friend_album_list('category','friend','date', ++pagenum , 1);
	});
	
	searchword();
	searchgroup();
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
					searchword();
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
					searchword();
				}
				else{
					alert(a);
				}
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}	
}

//검색 타입, 검색 키워드, 정렬 순서, 페이지를 받아 albumlist 조회
function get_friend_album_list(type , writer_type , order, page , checknum) {
	var check  = false;
	if(searchcheck != check){ 
		searchcheck = check;
		page = 0;
	}

	if(page == 0){ 
		check  = true;
		total = true;
	}
	
	var keyword;
	if(checknum == 1)
		keyword = $('#categorynum').val();
	else if(checknum == 0)
		keyword = $('#searchtx').val();
	$.ajax({
		url: 'album/get_album_list',
		type: 'post',
		data:{
			friendId:$('#friendidval').val(),
			type:type,
			writer_type: writer_type,
			keyword: keyword,
			order: order,
			page: page
		}, 
		dataType: 'json',
		success: function(result) {
			if(JSON.stringify(result) == '[]') {
				total = false;
			} else {
				total = true;
			}
			// 앨범 스크롤 페이징 처리...
			AlbumListPaging_hindoong(check , result);			
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}












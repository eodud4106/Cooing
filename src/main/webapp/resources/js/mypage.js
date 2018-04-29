/**
 * 
 */

function initialize(){
	//초기 친구 찾을 때만 사용했었음
	$('#friendsearch').keyup(function() {
		searchword();
	});
	
	$('.category').on('click' , function(){
		searchcheck = 99;
		$('#searchtx').val('');
		$('#categorynum').val($(this).attr('data'));
		getMyCategoryAlbumList();
	});

	getMyAlbumList();
	
	$('#searchtx').keydown(function(event){
		if(event.keyCode == 13){
			searchcheck = 99;
			getMyAlbumList();
		}
	});	
}

//앨범 리스트 Ajax로 받는 코드
function getMyAlbumList() {
	var check  = false;
	if(searchcheck != 0){
		searchcheck = 0;
		pagenum = 0;
	}
	if(pagenum == 0)
		check  = true;
	var searchtx = $('#searchtx').val();
	$.ajax({
		url: 'album/getMyAlbumList',
		type: 'post',
		data:{
			search:searchtx,
			pagenum:++pagenum
		},
		dataType: 'json',
		success: function(result) {
				AlbumListPaging(check , result);
				$.ajax({
					url: 'album/getMyAlbumCount',
					type: 'post',
					data:{
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

//카테고리 앨범 리스트 Ajax로 받는 코드
function getMyCategoryAlbumList() {
	var check  = false;
	if(searchcheck != 1){
		searchcheck = 1;
		pagenum = 0;
	}
	if(pagenum == 0)
		check  = true;
	var catgorynum = $('#categorynum').val();
	$.ajax({
		url: 'album/getMyCategoryAlbumList',
		type: 'post',
		data:{
			categorynum:catgorynum,
			pagenum:++pagenum
		},
		dataType: 'json',
		success: function(result) {
				AlbumListPaging(check , result);
				$.ajax({
					url: 'album/getMyCategoryAlbumCount',
					type: 'post',
					data:{
						categorynum:catgorynum
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

/**
 * 앨범 생성
 */
function create_personal_album() {
	$.ajax({
		url: 'create_album',
		type: 'post',
		data: {
			isPersonal: 1
		},
		dataType: 'json',
		success: function(result) {
			if(result == 'user null') {
				alert('로그인 정보 없음!');
			} else if(result == 'fail') {
				alert('오류 발생!!');
			} else {
				 //TODO 앨범 편집창으로 이동
				 location.href="edit_album?album_num=" + result;
			}
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}









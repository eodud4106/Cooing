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
		category_save($(this).attr('data'));
		$('#categorynum').val($(this).attr('data'));
		get_album_list('category','personal', 'date', pagenum++ , 1);
	});

	get_album_list('writer','personal', 'date', pagenum++ , 0);
	
	$('#searchtx').keydown(function(event){
		if(event.keyCode == 13){
			searchcheck = 99;
			search_save($('#searchtx').val());
			get_album_list('writer','personal', 'date', pagenum++ , 0);
		}
	});	
	
	searchword();
	searchgroup();
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
			/*alert(JSON.stringify(e));*/	
		}
	});
}









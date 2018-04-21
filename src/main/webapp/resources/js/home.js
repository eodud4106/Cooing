/**
 * home관련 js
 * 
 */

function initialize(){
	$('#friendsearchbt').on('click', function() {
		searchfriend();
	});
	//초기 친구 찾을 때만 사용했었음
	$('#friendsearch').keyup(function() {
		searchword();
	});
	$('#login').on('click', function() {
		loginmember('');
	});
	$('#searchbt').on('click' , function(){
		search();
	});	
	$('.category').on('click' , function(){
		searchCategory($(this).attr('data'));
	});
}

function openGUpdate(group_name) {
	var url = "groupPage?group_name=" + group_name;  
	location.href=url;
}

//앨범 리스트 Ajax로 받는 코드
function getTotalAlbumList(pagenum) {
	$.ajax({
		url: 'getTotalAlbumList',
		type: 'post',
		data:{pagenum:pagenum}, 
		dataType: 'json',
		success: function(result) {
			totalAlbumList(false , result);
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}







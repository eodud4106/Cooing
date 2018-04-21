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
			AlbumListPaging(false , result);
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

function searchCategory(categorynum){
	$.ajax({
		url:'searchCategory',
		type:'POST',		
		data:{searchtext:categorynum},
		dataType:'json',
		success: function(list){
			//list 받아오면 리스트 돌려서 처리할 부분
			alert(JSON.stringify(list));
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}

function search(){
	var searchtext = $('#searchtx').val();
	$.ajax({
		url:'searchWord',
		type:'POST',		
		data:{searchtext:searchtext},
		dataType:'json',
		success: function(list){
			//list 받아오면 리스트 돌려서 처리할 부분
			AlbumListPaging(true , list);
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}







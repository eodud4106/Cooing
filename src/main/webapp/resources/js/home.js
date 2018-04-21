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

function openGUpdate(group_name) {
	var url = "groupPage?group_name=" + group_name;  
	location.href=url;
}

function searchfriend(){
	//초기 친구찾아서 친구페이지 가는  코드 
	var text = $('#friendsearch').val();
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
				$('#friendsearch').val('');
				alert('찾으시는 친구 ID가 없습니다.');
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function searchword(){
	//친구 찾아서 검색창 밑에 띄워주는 코드
	var text = $('#friendsearch').val();
	if(text.length >= 2){
		$.ajax({
			url:'jinsu/search_id',
			type:'POST',		
			data:{text:text},
			dataType:'json',
			success: function(array){
				$('#friendsearch').autocomplete({
					source:array
				});
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
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







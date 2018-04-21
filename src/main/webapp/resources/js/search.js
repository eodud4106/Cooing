/**
 * 
 */

//앨범 리스트 출력
function AlbumListPaging(check , result) {
	if(check)
		$('.card-columns').html('');
	$(result).each(function(i, album) {	
		var div_card = document.createElement('div'); //카드 클래스 div
		var a_read_album = document.createElement('a'); //a태그
		var img = document.createElement("img"); // 이미지 생성
		$(img).attr('src' ,'./albumEdit/thumbnail?filePath='+album.album_thumbnail+'' );
		$(img).attr('style' ,'width:100%;height:100%');
		$(a_read_album).attr('href', 'albumView?album_num=' + album.album_num + '');
		$(a_read_album).append(img);
		$(div_card).addClass('card img-loaded').append(a_read_album);
		//a태그 링크 걸어주기
		$('.card-columns').append(div_card);				
	});
	pagingcheck = false;
}

//home이 아닌곳에서 search를 할경우 메인으로 보내서 검색을 해야한다.
function search_other(){
	location.href('./search_other?search=' + $('#searchtx').val() + '');
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










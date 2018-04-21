/**
 * 
 */

//앨범 리스트 출력
function totalAlbumList(check , result) {	
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

function search(){
	var searchtext = $('#searchtx').val();
	$.ajax({
		url:'searchWord',
		type:'POST',		
		data:{searchtext:searchtext},
		dataType:'json',
		success: function(list){
			//list 받아오면 리스트 돌려서 처리할 부분
			totalAlbumList(true , list);
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
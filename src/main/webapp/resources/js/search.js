/**
 * 
 */

//앨범 리스트 출력
function AlbumListPaging(check, result) {
	if (check)
		$('.card-columns').html('');
	$(result).each(function(i, album) {
		
		console.log(JSON.stringify(album))
		
		var div_card = document.createElement('div'); //카드 클래스 div
		var ul_card = document.createElement('ul');
		var li_card = document.createElement('li');
		var div_inner = document.createElement('div');
		var a_read_album = document.createElement('a'); //a태그
		var p_tag = document.createElement("p"); // p태그
		
		var $img = $('<img />', {
			"src": 'thumbnail?filePath=' + album.album_thumbnail,
			"class": "card-img-top probootstrap-animate"
		}).css({
			"width": "100%",
			"height": "100%"
		})
		
		//여기에 추가해서 정보 넣어주면 됨
		var album_infomation_html = '앨범 번호 : ' + album.album_num + '';

		$(a_read_album).attr('href', 'albumView?album_num=' + album.album_num + '');
		//a태그 사이에 p태그를 넣어주기
		$(p_tag).html(album_infomation_html);
		$(a_read_album).append(p_tag);
		
		$(div_inner).addClass('inner').append(a_read_album);
		$(div_inner).append($img);
		$(li_card).append(div_inner);
		$(ul_card).append(li_card);

		$(div_card).addClass('card img-loaded').append(ul_card);
		//a태그 링크 걸어주기
		$('.card-columns').append(div_card);
	});
	pagingcheck = false;
}
//home이 아닌곳에서 search를 할경우 메인으로 보내서 검색을 해야한다.
function search_other() {
	location.href='./search_other?search=' + $('#searchtx').val() + '';
}

function searchfriend() {
	var text = $('#friendsearch').val();
	if ('${Member.member_id}' == text) {
		location.href = './myPage';
		return false;
	}
	//초기 친구찾아서 친구페이지 가는  코드 	
	$.ajax({
		url : 'friend_check',
		type : 'POST',
		data : {
			id : text
		},
		dataType : 'text',
		success : function(a) {
			if (a == 'success') {
				location.href = './friend_get?id=' + text;
			} else {
				$('#friendsearch').val('');
				alert('찾으시는 친구 ID가 없습니다.');
			}
		},
		error : function(e) {
			alert(JSON.stringify(e));
		}
	});
}

function searchword() {
	//친구 찾아서 검색창 밑에 띄워주는 코드
	var text = $('#friendsearch').val();
	if (text.length >= 2) {
		$.ajax({
			url : 'search_friend_id',
			type : 'POST',
			data : {
				text : text
			},
			dataType : 'json',
			success : function(array) {
				$('#friend').html('');
				$('#friend').text('<친구들>');
				print_search_result(array, $('#friend'), 'friend');
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
		$.ajax({
			url : 'search_user_id',
			type : 'POST',
			data : {
				text : text
			},
			dataType : 'json',
			success : function(array) {
				$('#user').html('');
				$('#user').text('<유저>');
				print_search_result(array, $('#user'), 'user');
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	} else {
		$.ajax({
			url : 'select_friend',
			type : 'POST',
			dataType : 'json',
			success : function(array) {
				$('#friend').html('')
				$('#user').html('')
				$('#friend').text('친구들')
				print_search_result(array, $('#friend'), 'friend');
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}
}

function friendclickevent(){
	/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어 생성. */
	$('.friendclick').click(function(e) {
		var sWidth = window.innerWidth;
		var sHeight = window.innerHeight;

		var oWidth = $('.popuplayer').width();
		var oHeight = $('.popuplayer').height();

		// 레이어가 나타날 위치를 셋팅.
		var divLeft = e.clientX + 10;
		var divTop = e.clientY + 5;

		// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치.
		if (divLeft + oWidth > sWidth)
			divLeft -= oWidth;
		if (divTop + oHeight > sHeight)
			divTop -= oHeight;

		// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치.
		if (divLeft < 0)
			divLeft = 0;
		if (divTop < 0)
			divTop = 0;
		// 사이드 쪽 zindex가 10이라 11로 설정.
		$('.popuplayer').css({
			"z-index" : 11,
			"top" : divTop,
			"left" : divLeft,
			"position" : "absolute"
		}).show();
	});
}

// 검색 결과 출력하는 함수
function print_search_result(result, $destination, type) {
	
	if(type == 'friend') {
	
		$(result).each(function(i, data) {
			
			// 검색 결과를 각각 감쌀 div
			var $div_wrapper = $('<div />', {
				"class": "div_search_result arr_friend",
				"friend_id": data.member_id
			}).appendTo($destination);
			
			// 프로필 사진..
			var $img_profile = $('<img />', {
				"class": "img_profile arr_friend",
				"src": "./memberimg?strurl=" + data.member_picture,
				"friend_id": data.member_id
			}).css({
				"width": "40px",
				"height": "40px"
			}).appendTo($div_wrapper);
			
			// 친구 아이디
			var $friend_id = $('<span />', {
				"class": "span_friend_id arr_friend",
				"text": data.member_id,
				"friend_id": data.member_id
			}).appendTo($div_wrapper);
			
		})
		
	} else if (type == 'user') {
		
		$(result).each(function(i, data) {
			
			// 검색 결과를 각각 감쌀 div
			var $div_wrapper = $('<div />', {
				"class": "div_search_result arr_user",
				"user_id": data.member_id
			}).appendTo($destination);
			
			// 프로필 사진..
			var $img_profile = $('<img />', {
				"class": "img_profile arr_user",
				"src": "./memberimg?strurl=" + data.member_picture,
				"user_id": data.member_id
			}).css({
				"width": "40px",
				"height": "40px"
			}).appendTo($div_wrapper);
			
			// 친구 아이디
			var $user_id = $('<span />', {
				"class": "span_friend_id arr_user",
				"text": data.member_id,
				"user_id": data.member_id
			}).appendTo($div_wrapper);
			
		})
	}
	
	
}
/**
 * 
 */

//앨범 리스트 출력
function AlbumListPaging(check, result) {
	if (check)
		$('.card-columns').html('');
	$(result).each(function(i, album) {
		var div_card = document.createElement('div'); //카드 클래스 div
		var a_read_album = document.createElement('a'); //a태그
		var img = document.createElement("img"); // 이미지 생성
		$(img).attr('src', './thumbnail?filePath=' + album.album_thumbnail + '');
		$(img).attr('style', 'width:100%;height:100%');
		$(a_read_album).attr('href', 'albumView?album_num=' + album.album_num + '');
		$(a_read_album).append(img);
		$(div_card).addClass('card img-loaded').append(a_read_album);
		//a태그 링크 걸어주기
		$('.card-columns').append(div_card);
	});
	pagingcheck = false;
}

//home이 아닌곳에서 search를 할경우 메인으로 보내서 검색을 해야한다.
function search_other() {
	location.href('./search_other?search=' + $('#searchtx').val() + '');
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
			url : 'jinsu/search_friend_id',
			type : 'POST',
			data : {
				text : text
			},
			dataType : 'json',
			success : function(array) {
				$('#friend').html('');
				/*var str = '';*/
				$.each(array, function(i, data) {
					/*str += '<p class="friendclick"  onClick="popupvalue(\'' + data.member_id + '\')"><img src="./jinsu/memberimg?strurl=' + data.member_picture + '" style="width:40px;height:40px;">' + data.member_id + '</p>';*/
					/*var p_tag = document.createElement('p');
					$(p_tag).click(popupvalue(data.member_id));
					$(p_tag).attr('class' , 'friendclick');
					$(p_tag).append('<img src="./jinsu/memberimg?strurl=' + data.member_picture + '" style="width:40px;height:40px;">');
					$(p_tag).append(data.member_id);*/
					var $p = $('<p />',{
						"class": "friendclick"
					}).click(function(e) {
						popupvalue(data.member_id);
					});
					$p.append('<img src="./jinsu/memberimg?strurl=' + data.member_picture + '" style="width:40px;height:40px;">');
					$p.append(data.member_id);		
					$('#friend').append($p);
				});
				/*$('#friend').html(str);*/
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
		$.ajax({
			url : 'jinsu/search_user_id',
			type : 'POST',
			data : {
				text : text
			},
			dataType : 'json',
			success : function(array) {
				var str = '';
				$.each(array, function(i, data) {
					
					str += '<p class="friendclick" onClick="popupvalue(\'' + data.member_id + '\')"><img src="./jinsu/memberimg?strurl=' + data.member_picture + '" style="width:40px;height:40px;">' + data.member_id + '</p>';
				});
				$('#user').html(str);
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	} else {
		$.ajax({
			url : 'jinsu/select_friend',
			type : 'POST',
			dataType : 'json',
			success : function(array) {
				var str = '';
				$.each(array, function(i, data) {
					str += '<p class="friendclick" onClick="popupvalue(\'' + data.member_id + '\')"><img src="./jinsu/memberimg?strurl=' + data.member_picture + '" style="width:40px;height:40px;">' + data.member_id + '</p>';
				});
				$('#friend').html(str);
				$('#user').html('');
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}
	friendclickevent();
}

function friendclickevent() {
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

function popupvalue(click) {
	$('.popuplayer').val(click);
}

function friendpage() {
	location.href = './friend_get?id=' + $('.popuplayer').val() + '';
}

function chatpage() {
	$('.popuplayer').hide();
	openChat(1, $('.popuplayer').val());
}
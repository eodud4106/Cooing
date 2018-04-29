/**
 * 
 */
//검색창 줄였다 늘렸다 
function inputbox_focus(){
	if($('#searchtx').css('width') == '0px'){
		$('#searchtx').val('');
		$('#searchtx').css('width' , '200px');
		$('#searchtx').css('paddingLeft' , '3px');
		$('#searchtx').focus();
	}else if($('#searchtx').css('width') != '0px'){
		$('#searchtx').val('');
		$('#searchtx').css('width' , '0px');
		$('#searchtx').css('paddingLeft' , '0px');
	}
}

function search_bar(search){
	if($('#searchtx').val().length == 0){
		$(search).css('width' , '0px');
		$(search).css('paddingLeft' , '0px');
	}
}

//앨범 리스트 출력
function AlbumListPaging(check, result) {
	if (check)
		$('.card-columns').html('');
	$(result).each(function(i, album) {
		
		var $div_card = $('<div />', {
			"class":'card img-loaded div_card',
			"album_num": album.album_num
		}); //카드 클래스 div

		var $img = $('<img />', {
			"src": 'thumbnail?filePath=' + album.album_thumbnail,
			"class": "card-img-top probootstrap-animate div_card",
			"album_num": album.album_num
		}).css({
			"width": "100%",
			"height": "100%",
			"opacity": "1"
		}).appendTo($div_card);
		
		var $info_div = $('<div />', {
			"class": "div_info hidden_info div_card",
			"album_num": album.album_num
		}).appendTo($div_card);
		
		var $p_name = $('<p />', {
			"text": /*"ALBUM " +*/ album.album_name,
			"class": "card_album_name"
		}).appendTo($info_div);
		var $p_writer = $('<p />', {
			"text": /*"ID: " + */album.album_writer,
			"class": "card_album_writer"
		}).appendTo($info_div);
		var $p_contents = $('<p />', {
			"html": /*"<CONTENT><br>" +*/ album.album_contents + "<br>",
			"class": "card_album_contents"
		}).appendTo($info_div);
		if(album.album_contents == null) {
			$p_contents.html("<CONTENT><br>없음<br>")
		}		
		var $span_like = $('<sapn />', {
			"html": "❤",
			"class": "card_album_likes"
		}).css({
			"color":"#FF0000"			
		}).appendTo($info_div);
		
		var $span_likecount = $('<sapn />', {
			"html": likecount(album.album_num) + "<br>",
			"class": "card_album_likes"
		}).appendTo($info_div);
		
		var $p_reply = $('<p />', {
			"html": "댓글 :" + replycount(album.album_num),
			"class": "card_album_contents"
		}).appendTo($info_div);
		
		// 마우스 엔터
		$div_card.mouseenter(function(e) {
			var $div_overlay = $('<div />', {
				"class": "go_back"
			}).appendTo($(this));
			$info_div.removeClass('hidden_info').addClass('go_front');
		}).mouseleave(function(e) {
			$('.go_back').remove();
			$info_div.removeClass('go_front').addClass('hidden_info');
		})
		
		$('.card-columns').append($div_card);
	});
	
	$('.div_card').click(function(e) {
		location.href = 'albumView?album_num='+$(this).attr('album_num');
	});
	pagingcheck = false;
}

function likecount(albumnum){
	var count = 0;
	$.ajax({
		url : 'count_like',
		type : 'POST',
		async:false,
		data : {
			likeit_albumnum : albumnum
		},
		dataType : 'text',
		success : function(a) {
			count = a;
		},
		error : function(e) {
			alert(JSON.stringify(e));
		}
	});
	return count;
}

function replycount(albumnum){
	var count = 0;
	$.ajax({
		url : 'countReply',
		type : 'POST',
		async:false,
		data : {
			reply_albumnum : albumnum
		},
		dataType : 'text',
		success : function(a) {
			count = a;
		},
		error : function(e) {
			alert(JSON.stringify(e));
		}
	});
	return count;
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


//검색 타입, 검색 키워드, 정렬 순서, 페이지를 받아 albumlist 조회
function get_album_list(type, keyword, order, page) {
	var check  = false;

	if(page == 0) check  = true;
	
	$.ajax({
		url: 'album/get_album_list',
		type: 'post',
		data:{
			type: type,
			keyword: keyword,
			order: order,
			page: page
		}, 
		dataType: 'json',
		success: function(result) {
			
			// 앨범 스크롤 페이징 처리...
			AlbumListPaging_hindoong(check , result);
			
			if(check){
				$.ajax({
					url:'searchTotalCount',
					type:'POST',		
					data:{
						checknum: 3
					}, 
					dataType:'text',
					success: function(list){
						//total count 변경 부분
						$('#totalpage').val(list);
					},
					error:function(e){alert(JSON.stringify(e));}	
				});
			}			
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

//앨범 리스트 출력
function AlbumListPaging_hindoong(check, result) {
	if (check)
		$('.card-columns').html('');
	$(result).each(function(i, album) {
		
		var $div_card = $('<div />', {
			"class":'card img-loaded div_card',
			"album_num": album.album_num
		}); //카드 클래스 div

		var $img = $('<img />', {
			"src": 'thumbnail?filePath=' + album.album_thumbnail,
			"class": "card-img-top probootstrap-animate div_card",
			"album_num": album.album_num
		}).css({
			"width": "100%",
			"height": "100%",
			"opacity": "1"
		}).appendTo($div_card);
		
		var $info_div = $('<div />', {
			"class": "div_info hidden_info div_card",
			"album_num": album.album_num
		}).appendTo($div_card);
		
		var $p_name = $('<p />', {
			"text": /*"ALBUM " +*/ album.album_name,
			"class": "card_album_name"
		}).appendTo($info_div);
		var $p_writer = $('<p />', {
			"text": /*"ID: " + */album.album_writer,
			"class": "card_album_writer"
		}).appendTo($info_div);
		var $p_contents = $('<p />', {
			"html": /*"<CONTENT><br>" +*/ album.album_contents + "<br>",
			"class": "card_album_contents"
		}).appendTo($info_div);
		if(album.album_contents == null) {
			$p_contents.html("<CONTENT><br>없음<br>")
		}		
		var $span_like = $('<sapn />', {
			"html": "❤",
			"class": "card_album_likes"
		}).css({
			"color":"#FF0000"			
		}).appendTo($info_div);
		
		var $span_likecount = $('<sapn />', {
			"html": album.like_count + "<br>",
			"class": "card_album_likes"
		}).appendTo($info_div);
		
		var $p_reply = $('<p />', {
			"html": "댓글 :" + album.reply_count,
			"class": "card_album_contents"
		}).appendTo($info_div);
		
		// 마우스 엔터
		$div_card.mouseenter(function(e) {
			var $div_overlay = $('<div />', {
				"class": "go_back"
			}).appendTo($(this));
			$info_div.removeClass('hidden_info').addClass('go_front');
		}).mouseleave(function(e) {
			$('.go_back').remove();
			$info_div.removeClass('go_front').addClass('hidden_info');
		})
		
		$('.card-columns').append($div_card);
	});
	
	$('.div_card').click(function(e) {
		location.href = 'albumView?album_num='+$(this).attr('album_num');
	});
	pagingcheck = false;
}

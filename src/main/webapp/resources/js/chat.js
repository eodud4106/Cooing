/**
 * 채팅 관련 메소드 모음
 */

 // 채팅에 쓸 웹소켓과 위치
var websocket_chat;
var wsUri_chat = "ws://cooing.site/www/chat/echo.do";

var userId;
var counterpart;
var is1to1;
var goRoot;

// 자주 사용할 div들
var $div_chat;
var $title;
var $message_list;
var $message;

/*
 *	로그인 상태일 경우 채팅 준비
 *	@param (로그인 아이디, home으로 가기 위한 경로)
 */ 
function readyChat (userId, goRoot) {

	console.log('채팅 준비!, userId-> ' + userId);

	// 로그인 정보 확인 후 전역변수에 저장
	if(userId == '') {
		// 로그인 정보 없음
		return;
	} else {
		this.userId = userId;
	}

	// 루트(홈)으로 가는 경로 저장...
	this.goRoot = goRoot;

	// 웹소켓 연결
	websocket_chat = new WebSocket(wsUri_chat);
 	
 	// 웹소켓 이벤트 별 함수 연결

 	// 채팅 연결
	websocket_chat.onopen = function(evt) {
   		onOpen(evt)
   	};

   	// 메세지 수신
   	websocket_chat.onmessage = function(evt) {
   		onMessage(evt)
   	};

   	// 에러 수신
   	websocket_chat.onerror = function(evt) {
   		//onError(evt)
   	};

   	// 웹소켓 종료
   	websocket_chat.onclose = function(evt) {
   		closeChat(evt)
   	};

   	// 채팅창 생성, 채팅창 스타일 적용, 드래그 온(window를 벗어나지 못하게 제한)
   	$div_chat = $('<div />', {
   		"id": "div_chat",
   		"class": "div_chat"
   	}).appendTo('body').draggable({
		containment: "window",
		cancel: '.div_chat_under'
	})
		


	/*
	 *	상단바 div 디자인
	 */ 
	// 전체 div
	var $div_chat_top = $('<div />', {
		"class": "div_chat_top"
	});
	// 제목 부분
	$title = $('<div />', {
		"class": "div_chat_top_title"
	})
	// 닫기 부분
	var $div_chat_top_close = $('<div />', {
		"class": "div_chat_top_close"
	}).click(function(e) {
		// 버블 제거
		e.stopPropagation();


		// TODO 대화창 닫기 시 코드
		// 대화창 안 보이게..
		//$div_chat.css("display", "none");
		closeChat();
	})
	// 닫기 버튼
	var $bt_chat_top_close = $('<i class="fas fa-times"></i>').css({
		"width": "100%",
		"height": "100%"
	}).appendTo($div_chat_top_close);

	// 상단바 div 부착
	$div_chat_top.append($title).append($div_chat_top_close);

	/*
	 *	채팅 내용 div 디자인
	 */ 
	// 전체 div
	$message_list = $('<div />', {
		"class": "div_chat_content"
	});

	/*
	 *	메시지 입력 div 디자인
	 */
	// 전체 div
	var $div_chat_under = $('<div />', {
		"class": "div_chat_under"
	});
	// 입력 영역
	var $div_chat_under_input = $('<div />', {
		"class": "div_chat_under_input"
	});
	// 입력칸
	$message = $('<div />', {
		"class": "div_chat_under_input_box",
		"contentEditable": true
	}).appendTo($div_chat_under_input).keydown(function(evt) {
		if (evt.keyCode == 13) {
			evt.preventDefault();
			sendMessage();
			return;
		}
	});;
	// 전송 버튼 영역
	var $div_chat_under_send = $('<div />', {
		"class": "div_chat_under_send"
	}).click(function(e) {
		// 버블 제거
		e.stopPropagation();

		// TODO send....
		sendMessage();
	});
	// 전송 버튼
	var bt_chat_send = $('<i class="fas fa-paper-plane"></i>').css({
		"width": "100%",
		"height": "100%"
	}).appendTo($div_chat_under_send);
	$div_chat_under.append($div_chat_under_input).append($div_chat_under_send);

	// div_chat에 각 부분 부착..
	$div_chat.append($div_chat_top).append($message_list).append($div_chat_under);
	
	// 메세지 도착 시 탭 색깔 바꾸기....
	$('#msg_list').bind("DOMSubtreeModified", function(e){

		if($('#msg_list').children().length > 0) {
			$('label[for=tab3]').css({
				"background-color": "rgba(250,200,200,.5)"
			});
		} else {
			$('label[for=tab3]').css({
				"background-color": "rgba(255,255,255,1)"
			});
		}
	})
   	
}

//웹소켓 연결 성공
function onOpen(evt) {
	// 접속한 멤버의 아이디를 보낸다. 웹소켓 세션의 아이디와 1:1 매칭시키기 위함.
	var sendMessage = {
		type: "login",
		sender: userId
	}
	websocket_chat.send(JSON.stringify(sendMessage));
	console.log('웹소켓 연결됨..')
	
	// 대화 상대 별 안 읽은 메세지 개수를 조회함.
	$.ajax({
		type: "POST",
		url: "chat/get_unread_chat_count",
		success : function(result) {
			//console.log(JSON.stringify(result));
			// 카드 형태로 news 탭에 뿌리기 위해 호출
			show_unread_msg_count(result);
        }, 
        error : function(e) { 
            alert(JSON.stringify(e)); 
        } 
	});
	
}

/**
 * 채팅창 오픈
 * @param is1to1 1 = 1:1, 0 = 그룹
 * @param counterpart 상대
 * @returns
 */
function openChat(is1to1, counterpart) {
	
	// 기존 채팅창이 열려 있는 경우 닫는다.
	closeChat();
	
	// 상대와 상대의 타입을 저장한다.
	this.is1to1 = is1to1;
	this.counterpart = counterpart;
    
	// 채팅창을 열기 전 이전 대화 목록을 불러온다.
	$.ajax({
		url: goRoot + 'chat/getChat',
		type: 'post',
		data: {
			counterpart: this.counterpart,
			is1to1: this.is1to1
		},
		dataType: 'text',
		success: function(result) {
			printChat(result);
		},
		error: function(e) {
			alert('오류 발생, 코드 ->' + e.status);
		}
	});
	

	$div_chat.css('display', 'block');
	
	if(is1to1 == 1) {
		// 1 대 1 대화이면 상대방 아이디를 제목으로
		$title.text(counterpart);	
	} else {
		// 그룹 대화면 그룹 이름을 제목으로
		$title.text('그룹)' + counterpart);
	}
	
	$message.focus();

}

//채팅창 닫힘
function closeChat() {
	
	$div_chat.css('display', 'none');
	counterpart = '';
	is1to1 = '';

	// 이전 채팅창의 정보를 지운다..
	$title.html('');
	$message_list.html('');
	$message.html('');
}

// 서버로 메시지 발신
function sendMessage() {

	// 빈 메세지는 보내지 않는다...
	if($message.text() == '') {
		return;
	}
	
    var sendMessage = {
		type: "message",
		sender: userId,
		addressee: counterpart,
		is1to1: is1to1,
		message: $message.text()
	}

    websocket_chat.send(JSON.stringify(sendMessage));

    $message.text('').focus();

}

//메시지 수신
function onMessage(evt) {
    
    var chatData = JSON.parse(evt.data);
    var is1to1 = chatData.is1to1;		// 1 = 1to1, 0 = 그룹
    
    if (chatData.type == 'read') {

		if(chatData.ids) {

			var reg = /\d{1,10}/g;
			var arr_id = chatData.ids.match(reg);
			
			for(var i = 0; i < arr_id.length; i++) {
			
				var id = arr_id[i];
				var $unread = $('.msg[message_id=' + id + ']').find('.msg_unread');
				$unread.text(($unread.text()-1));
				if($unread.text() == 0) $unread.text('');

			}
		}

		return;
	}
    
    // 메시지를 보낸 사람이 현재 대화 중인 상대 또는 자신인지 판별한다.
    if (chatData.sender == counterpart || chatData.sender == userId
    		|| chatData.addressee == counterpart) {
		// 현재 대화 중인 상대 또는 자신 -> 대화창에 메시지 출력
    		printChat(evt.data);	
    		
	} else {
		// 대화 중인 상대가 아님 -> 수신 알림
		console.log('대화 중인 상대가 아닙니다. is1to1 = ' + chatData.is1to1 + ' // 발신자: ' + chatData.sender + ' //수신자' + chatData.addressee);
		chatData.sender = chatData.is1to1 == 1? chatData.sender : chatData.addressee;
		var $target = $('.msg_list').find('.news_card[who=' + chatData.sender + ']');
		
		if($target.length > 0) {
			// 메세지 함에 이미 있는 카드
			var $clone = $target.clone();
			var unread =Number($clone.find('.news_content').attr('unread'));
			
			$clone.find('.news_content').text('안 읽은 메세지 ' + (unread + 1) + '건');
			$clone.find('.news_content').attr('unread', (unread + 1));
			$target.remove();
			$clone.prependTo('#msg_list').click(function(e) {
			
				openChat($(this).attr('is1to1'), $(this).attr('who'));
				$(this).remove();
			});
			
		} else {
			// 메세지 함에 없는 카드
			show_unread_msg_count(chatData);
		}
		
	}
    
}

// 메시지를 대화창에 출력
function printChat(chatData) {
	
	// json 형식으로 받기 때문에... 일단 parse...
	var arr_chat = JSON.parse(chatData);
	
	// 상대가 보낸 메세지인지 저장할 변수
	var isReceive = false;

	// parse 후 each...
	$(arr_chat).each(function(i, chat) {
		
		/*
		 *	메세지를 담을 div들...	
		 */
		var $div_message = $('<div />');

		var $msg = $('<div />', {
			"class": "msg",
			"message_id": chat.message_id
		});

		var $msg_user = $('<div />', {
			"class": "msg_user"
		});

		var $msg_text = $('<div />', {
			"class": "msg_text"
		});

		var $msg_date = $('<div />', {
			"class": "msg_date"
		})

		var $msg_unread = $('<div />' , {
			"class": "msg_unread"
		})

		var $date_unread_wrapper = $('<div />', {
			"class": "date_unread_wrapper"
		})

		// unread가 0이면 쓰지 않는다..
		if(chat.unread == 0) chat.unread = '';
		
		// 자기가 보낸 메세지
		if (chat.sender == userId) {
			//자기가 보낸 메시지

			$msg_text.text(chat.message).css({
				"float": "right",
				"background-color": "#81DAF5"
			}).appendTo($msg);
			$date_unread_wrapper.css({
				"left": "-80px"
			});
			$msg_unread.text(chat.unread).appendTo($date_unread_wrapper);
			$msg_date.text(chat.send_date.substring(5,16)).appendTo($date_unread_wrapper);
			
			$date_unread_wrapper.appendTo($msg_text);
		} 

		// 상대가 보낸 메세지
		else {
			
			// 상대가 보냈음..
			isReceive = true;

			// 일대일 대화라면 상대 메세지의 안 읽음은 당연히 0...
			if(chat.is1to1 == 1) chat.unread = '';

			$msg_user.text(chat.sender).css("float", "left").appendTo($msg);
			$msg_text.text(chat.message).css({
				"float": "left",
				"background-color": "white"
			}).appendTo($msg);
			$date_unread_wrapper.css({
				"right": "-80px"
			});
			$msg_unread.text(chat.unread).appendTo($date_unread_wrapper);
			$msg_date.text(chat.send_date.substring(5,16)).appendTo($date_unread_wrapper);
			
			$date_unread_wrapper.appendTo($msg_text);
		}
		
		$message_list.append($msg);
		
	});

	// 상대가 보낸 메세지일 경우는... 읽었다고 상대에게 알려주어야 한다...
	if(isReceive) readMessage();
	
	// 가장 아래로 스크롤...
	$message_list.scrollTop($message_list[0].scrollHeight);
	
}

//웹 소켓 연결 종료
function onClose(evt) {
	
}

/**
 *	상대가 보낸 메시지를 읽었다는 내용의 메시지를 서버로 발신
 * @returns
 */
function readMessage() {
    //웹소켓 서버로 메시지를 읽었다는 내용의 메시지를 전송
    var sendMessage = {
		type: "read",
		is1to1: is1to1,
		sender: counterpart,
		addressee: userId,
		unread: userId
	}
    websocket_chat.send(JSON.stringify(sendMessage));
}

function show_unread_msg_count(result) {
	
	var $target = $('#msg_list');
	
	
	$(result).each(function(i, unread) {
		
		console.log('보낸이-> ' + unread.sender);
		console.log('is1to1-> ' + unread.is1to1);

		var $card = $('<div />', {
			"class": "news_card",
			"role": "msg",
			"who": unread.sender,
			"is1to1": unread.is1to1
		}).css({
			"width": "100%",
			"height": "50px",
			"background-color": "#D2FFD2",
			"margin-bottom": "5px",
			"text-align": "center"
		}).click(function(e) {
			
			openChat($(this).attr('is1to1'), $(this).attr('who'));
			$(this).remove();
		}).appendTo($target);
		
		var $role = $('<div />', {
			"class": "news_card news_head",
			"role": "head",
			"text": "msg"
		}).css({
			"width": "50%",
			"height": "25px",
			"float": "left",
			"display": "inline-block"
		}).appendTo($card);
		
		var $sender = $('<div />', {
			"class": "news_card news_sender",
			"role": "sender",
			"text": unread.sender,
			"sender": unread.sender
		}).css({
			"width": "50%",
			"height": "25px",
			"float": "left",
			"display": "inline-block"
		}).appendTo($card);
		
		var $content = $('<div />', {
			"class": "news_card news_content",
			"role": "content",
			"text": "안 읽은 메세지 " + unread.unread + "건",
			"unread": unread.unread
		}).css({
			"width": "100%",
			"height": "20px",
			"float": "left",
			"display": "inline-block"
		}).appendTo($card);
		
	})
	
}

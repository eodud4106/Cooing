/**
 * 채팅 관련 메소드 모음
 */

 // 채팅에 쓸 웹소켓과 위치
var websocket;
var wsUri = "ws://localhost:8888/www/chat/echo.do";

var userId;
var counterpart;
var is1to1;
var goRoot;

// 자주 사용할 div들
var $div_chat;
var $title;
var $message_list;
var $message;

/**
 *	TODO
 *	1. 모든 페이지에서 div_chat 기준으로 채팅창 열 수 있도록 js 내부에서 동적 생성
 *	2. 스타일은 css로
 *	3. 디자인 개선...
 *	4. 창이 넘어갈 때는 채팅창 어떻게 할 것인지?
 */

/*
 *	로그인 상태일 경우 채팅 준비
 *	@param (로그인 아이디, chat창이 될 빈 div)
 */ 
function readyChat (userId, goRoot) {

	console.log('채팅 준비!');

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
 	websocket = new WebSocket(wsUri);
 	
 	// 웹소켓 이벤트 별 함수 연결

 	// 채팅 연결
 	websocket.onopen = function(evt) {
   		onOpen(evt)
   	};

   	// 메세지 수신
 	websocket.onmessage = function(evt) {
   		onMessage(evt)
   	};

   	// 에러 수신
   	websocket.onerror = function(evt) {
   		//onError(evt)
   	};

   	// 웹소켓 종료
   	websocket.onclose = function(evt) {
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
		if (evt.which == 13) {
			console.log('엔터 눌림. 전송..');
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




	// // 채팅창이 꺼진 경우 세션 스토리지에서 채팅 상대를 제거한다.
 //   	if($('#div_chat').css('display') == 'none') {
 //   		sessionStorage.removeItem('counterpart');
 //   	}

   	
   	
}

//웹소켓 연결 성공
function onOpen(evt) {
	// 접속한 멤버의 아이디를 보낸다. 웹소켓 세션의 아이디와 1:1 매칭시키기 위함.
	var sendMessage = {
		type: "login",
		sender: userId
	}
	websocket.send(JSON.stringify(sendMessage));
	console.log('웹소켓 연결됨..')
	
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
	if($message.html() == '') return;
	
    var sendMessage = {
		type: "message",
		sender: userId,
		addressee: counterpart,
		is1to1: is1to1,
		message: $message.text()
	}

    websocket.send(JSON.stringify(sendMessage));

    $message.html('').focus();

}

//메시지 수신
function onMessage(evt) {
    
    var chatData = JSON.parse(evt.data);
    var is1to1 = chatData.is1to1;		// 1 = 1to1, 0 = 그룹
    
    // TODO	상대가 메시지를 읽었을 경우 채팅창에서 1을 지운다.
    if (chatData.type == 'read') {

		//TODO

		// $('.unread').each(function(i, unread) {
		// 	var read_count = $(unread).html();
		// 	if (read_count != '') {
		// 		$(unread).html(read_count-1);
		// 		if ($(unread).html() < 1) {
		// 			$(unread).html('');
		// 		}
		// 	}
		// });
		return;
	}
    
    // 메시지를 보낸 사람이 현재 대화 중인 상대 또는 자신인지 판별한다.
    if (chatData.sender == counterpart || chatData.sender == userId
    		|| chatData.addressee == counterpart) {
		// 현재 대화 중인 상대 또는 자신 -> 대화창에 메시지 출력
    		printChat(evt.data);	
    		
	} else {
		// 대화 중인 상대가 아님 -> 수신 알림
		
		// 알림1. 팝업 알림
		alert(from + '님으로부터 메시지가 왔습니다!');
		
		// 알림2. 대화창 빨간색 표시
		if (is1to1 == 1) {
			// 1:1
			$('p:contains(' + sender + ')').css('color', 'red');
		} else {
			// 그룹
			$('p[partynum = "' + addressee + '"]').css('color', 'red');
		}
	}
    
}

// 메시지를 대화창에 출력
function printChat(chatData) {
	
	// json 형식으로 받기 때문에... 일단 parse...
	var arr_chat = JSON.parse(chatData);
	
	// parse 후 each...
	$(arr_chat).each(function(i, chat) {
		
		var $div_message = $('<div />');
		var html = "";
		
		if (chat.sender == userId) {
			//자기가 보낸 메시지
			$div_message.css('text-align', 'right');
			if (chat.unread > 0) {
				// 1. 읽지 않음이 있는 경우
				html += "<span class='unread' style='font-size: 6pt'>" + chat.unread + "</span>";
			}
			html += chat.send_date.substring(0,16) + " / " + chat.message + " < <br>";
			$div_message.html(html);
	
		} else {
			//받은 메시지
			$div_message.css('text-align', 'left');
			html += chat.sender + " > " + chat.message + " / " + chat.send_date.substring(0,16);
			if (chat.unread > 0) {
				// 1. 읽지 않음이 있는 경우
				if (chat.is1to1 == 0) {
					html += "<span class='unread' style='font-size: 8pt'>" + chat.unread + "</span>";
				}
			}
			html += "<br>";
			$div_message.html(html);
		}
		
		$message_list.append($div_message);
		
	});
	
	// 메시지를 읽었다고 알려준다..
	readMessage();
	
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
   	websocket.send(JSON.stringify(sendMessage));
}
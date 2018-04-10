/**
 * 채팅 관련 메소드 모음
 */
var websocket;
var wsUri = "ws://localhost:8080/www/chat/echo.do";

// 로그인 상태일 경우 채팅 준비
function readyChat () {
	
	// 채팅창을 드래그로 위치 이동가능하게 만듦
	$('#div_chat').draggable();
	
	// 전송 버튼을 클릭할 경우 메시지 발송
 	$("#sendBtn").on('click', function() {
		sendMessage();
	});
 	$("#message").keydown(function(evt) {
		if (evt.which == 13) {
			sendMessage();
			return;
		}
	});

 	// 채팅창 닫기 버튼 클릭 이벤트
 	$('#button_close').on('click', function() {
 		closePChat();
 	});
 	
	// 채팅창이 꺼진 경우 세션 스토리지에서 채팅 상대를 제거한다.
   	if($('#div_chat').css('display') == 'none') {
   		sessionStorage.removeItem('counterpart');
   	}

   	// 웹소켓 연결
 	websocket = new WebSocket(wsUri);
 	
 	// 웹소켓 이벤트 별 함수 연결
 	websocket.onopen = function(evt) {
   		onOpen(evt)
   	};
 	websocket.onmessage = function(evt) {
   		onMessage(evt)
   	};
   	websocket.onerror = function(evt) {
   		onError(evt)
   	};
   	websocket.onclose = function(evt) {
   		closePChat(evt)
   	};
   	
}

//웹소켓 연결 성공
function onOpen(evt) {
	// 접속한 멤버의 아이디를 보낸다. 웹소켓 세션의 아이디와 1:1 매칭시키기 위함.
	var sendMessage = {
		type: "login",
		id: sessionStorage.getItem('id')
	}
	websocket.send(JSON.stringify(sendMessage));
	
}

/**
 * 채팅창 오픈
 * @param is1to1 1 = 1:1, 0 = 그룹
 * @param counterpart 상대
 * @param goRoot 최상위 디렉토리까지의 경로
 * @returns
 */
function openChat(is1to1, counterpart, goRoot) {
	
	// 기존 채팅창이 열려 있는 경우 닫는다.
	if ($('#div_chat').css('display') == 'block') {
		closePChat();
	}
	
	// session에 상대와 상대의 타입을 저장한다.
	sessionStorage.setItem('counterpart', counterpart);
	sessionStorage.setItem('is1to1', is1to1);
    
	// 채팅창을 열기 전 이전 대화 목록을 불러온다.
	$.ajax({
		url: goRoot + 'chat/getChat',
		type: 'post',
		data: {
			counterpart: counterpart,
			is1to1: is1to1
		},
		dataType: 'text',
		success: function(result) {
			printChat(result);
			readMessage();
		},
		error: function(e) {
			alert('오류 발생, 코드 ->' + e.status);
		}
	});
	
	$('#div_chat').css('display', 'block');

}

//채팅창 닫힘
function closePChat() {
	
	$('#div_chat').css('display', 'none');
	sessionStorage.removeItem('counterpart');
	sessionStorage.removeItem('is1to1');
	$('#data').html('');
}

// 서버로 메시지 발신
function sendMessage() {
	
    var sendMessage = {
			type: "message",
			from: sessionStorage.getItem('id'),
			to: sessionStorage.getItem('counterpart'),
			is1to1: sessionStorage.getItem('is1to1'),
			message: $('#message').val()
		}

    websocket.send(JSON.stringify(sendMessage));
    $('#message').val('').focus();

}

//메시지 수신
function onMessage(evt) {
    
    var chatData = JSON.parse(evt.data);
    var is1to1 = chatData.is1to1;		// 1 = 1to1, 0 = 그룹
    var from = chatData.message_from;
    var to = chatData.message_to;
    
    // TODO	상대가 메시지를 읽었을 경우 채팅창에서 1을 지운다.
    if (chatData.type == 'read') {
    	
		$('.read').each(function(i, span) {
			var read_count = $(span).html();
			if (read_count != '') {
				$(span).html(read_count-1);
				if ($(span).html() < 1) {
					$(span).html('');
				}
			}
		});
		return;
	}
    
    // 메시지를 보낸 사람이 현재 대화 중인 상대 또는 자신인지 판별한다.
    if (from == sessionStorage.getItem("counterpart") || from == sessionStorage.getItem("id")
    		|| to == sessionStorage.getItem("counterpart")) {
		// 현재 대화 중인 상대 또는 자신 -> 대화창에 메시지 출력
    		printChat(evt.data);	
    		
	} else {
		// 대화 중인 상대가 아님 -> 수신 알림
		
		// 알림1. 팝업 알림
		alert(from + '님으로부터 메시지가 왔습니다!');
		
		// 알림2. 대화창 빨간색 표시
		if (is1to1 == 1) {
			// 1:1
			$('p:contains(' + from + ')').css('color', 'red');
		} else {
			// 그룹
			$('p[partynum = "' + to + '"]').css('color', 'red');
		}
	}
    
}

// 메시지를 대화창에 출력
function printChat(chatData) {
	
	var arr_chat = JSON.parse(chatData);
	
	$(arr_chat).each(function(i, chat) {
		
		var div_message = document.createElement('div');
		var html = "";
		
		if (chat.message_from == sessionStorage.getItem('id')) {
			//자기가 보낸 메시지
			$(div_message).css('text-align', 'right');
			if (chat.message_read > 0) {
				// 1. 읽지 않음이 있는 경우
				html += "<span class='read' style='font-size: 6pt'>" + chat.message_read + "</span>";
			}
			html += chat.message_date.substring(0,16) + " / " + chat.message_message + " < <br>";
			$(div_message).html(html);
	
		} else {
			//받은 메시지
			$(div_message).css('text-align', 'left');
			html += chat.message_from + " > " + chat.message_message + " / " + chat.message_date.substring(0,16);
			if (chat.message_read > 0) {
				// 1. 읽지 않음이 있는 경우
				if (chat.is1to1 == 0) {
					html += "<span class='read' style='font-size: 6pt'>" + chat.message_read + "</span>";
				}
			}
			html += "<br>";
			$(div_message).html(html);
		}
		
		$("#data").append(div_message);
		
	});
	
	readMessage();
	
	$("#data").scrollTop($("#data")[0].scrollHeight);
	
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
		id: sessionStorage.getItem('id'),
		counterpart: sessionStorage.getItem('counterpart'),
		is1to1: sessionStorage.getItem('is1to1')
	}
   	websocket.send(JSON.stringify(sendMessage));
}
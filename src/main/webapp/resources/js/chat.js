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
		type: "loginId",
		id: sessionStorage.getItem('id')
	}
	websocket.send(JSON.stringify(sendMessage));
	
}

/**
 * 채팅창 오픈
 * @param type p=1:1, g=그룹
 * @param counterpart 상대
 * @param goRoot 최상위 디렉토리까지의 경로
 * @returns
 */
function openChat(type , counterpart, goRoot) {
	
	// 기존 채팅창이 열려 있는 경우 닫는다.
	if ($('#div_chat').css('display') == 'block') {
		$('#div_chat').css('display', 'none');
	};
	
	sessionStorage.setItem('counterpart', counterpart);
    
	$.ajax({
		url: goRoot + 'chat/getChat',
		type: 'post',
		data: {
			type: type,
			counterpart: counterpart
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
}

// 서버로 메시지 발신
function sendMessage() {
	
    var sendMessage = {
			type: "message",
			from: sessionStorage.getItem('id'),
			to: sessionStorage.getItem('counterpart'),
			message: $('#message').val()
		}

    websocket.send(JSON.stringify(sendMessage));
    $('#message').val('').focus();

}

//메시지 수신
function onMessage(evt) {
    
    var chatData = JSON.parse(evt.data);
    
    var from = chatData.p_message_from;
    
    // 	상대가 메시지가 읽었을 경우 채팅창에서 1을 지운다.
    if (chatData.type == 'read') {
		$('span[tag="read"]').remove();
		return;
	}
    
    // 메시지를 보낸 사람이 현재 대화 중인 상대 또는 자신인지 판별한다.
    if (from == sessionStorage.getItem("counterpart") || from == sessionStorage.getItem("id")) {
		// 현재 대화 중인 상대 또는 자신 -> 대화창에 메시지 출력
    		printChat(evt.data);	
    		
	} else {
		// 대화 중인 상대가 아님 -> 수신 알림
		
		// 알림1. 팝업 알림
		alert(from + '님으로부터 메시지가 왔습니다!');
		
		// 알림2. 친구 이름 옆에 빨간색 표시
		var message_num = document.createElement('span');
		$(message_num).html('*').css('color', 'red');
		$('p:contains(' + from + ')').append(message_num);
	}
    
}

// 메시지를 대화창에 출력
function printChat(chatData) {
	
	var arr_chat = JSON.parse(chatData);
	
	$(arr_chat).each(function(i, chat) {
		
		var div_message = document.createElement('div');
		if (chat.p_message_from == sessionStorage.getItem('id')) {
			//자기가 보낸 메시지
			$(div_message).css('text-align', 'right');
			if (chat.p_message_read == 1) {
				$(div_message).html("<span tag='read' style='font-size: 6pt' >1 </span>" + 
						chat.p_message_date.substring(0,16) + " / " + chat.p_message_message + " < <br>");
			} else {
				$(div_message).html( chat.p_message_date.substring(0,16) + " / " + chat.p_message_message + " < <br>");
			}
			
		} else {
			//받은 메시지
			$(div_message).css('text-align', 'left').html(chat.p_message_from + " > " + chat.p_message_message + " / " + chat.p_message_date.substring(0,16) + "<br>");
		}
		
		$("#data").append(div_message);
		
	});
	
	$("#data").scrollTop($("#data")[0].scrollHeight);
	
}

//웹 소켓 연결 종료
function onClose(evt) {
	
}

//상대가 보낸 메시지를 읽었다는 내용의 메시지를 서버로 발신
function readMessage() {
    //메시지를 수신 받았다면.. 채팅방에 접속한 상태이고 따라서 메시지를 읽은 것으로 본다..
    var sendMessage = {
		type: "read",
		to: sessionStorage.getItem('id'),
		from: sessionStorage.getItem('counterpart')
	}
   	websocket.send(JSON.stringify(sendMessage));
}
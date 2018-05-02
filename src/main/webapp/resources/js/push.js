/**
 * push 관련된 함수 (웹소켓..)
 */

 // 에 쓸 웹소켓과 위치
var ws_push;
var wsUri_push = "ws://cooing.site/www/push/echo.do";

var userId;
var sender;
var addressee;
var goRoot;

var $div_push;

/*
 *	로그인 상태일 경우 채팅 준비
 *	@param (로그인 아이디, home으로 가기 위한 경로)
 */ 
function readyPush(userId, goRoot) {

	console.log('push 준비!, userId-> ' + userId);

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
	ws_push = new WebSocket(wsUri_push);
 	
 	// 웹소켓 이벤트 별 함수 연결

 	// 연결
	ws_push.onopen = function(evt) {
   		onOpen_push(evt)
   	};

   	// 메세지 수신
   	ws_push.onmessage = function(evt) {
   		onMessage_push(evt)
   	};

   	// 에러 수신
   	ws_push.onerror = function(evt) {
   		//onError(evt)
   	};

   	// 웹소켓 종료
   	ws_push.onclose = function(evt) {
   		//closeChat_push(evt)
   	};
   	
	// invite 도착 시 탭 색깔 바꾸기....
	$('#invite_list').bind("DOMSubtreeModified", function(e){

		if($('#invite_list').children().length > 0) {
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
function onOpen_push(evt) {
	// 접속한 멤버의 아이디를 보낸다. 웹소켓 세션의 아이디와 1:1 매칭시키기 위함.
	var sendPush = {
		type: "0",
		sender: userId
	}
	ws_push.send(JSON.stringify(sendPush));
	console.log('push 웹소켓 연결됨..');
	
	// 안 읽은 push를 조회함.
	$.ajax({
		type: "POST",
		url: "push/get_unread_push",
		success : function(result) {
			console.log("안 읽은 초대 -> " + JSON.stringify(result));
			// 카드 형태로 news 탭에 뿌리기 위해 호출
			show_unread_push(result);
        }, 
        error : function(e) { 
            alert(JSON.stringify(e)); 
        } 
	});
	
}

// 서버로 메시지 발신
/*
 * @param
 * sender: 보낸사람(또는 파티)
 * addressee: 받는 사람(또는 파티)
 * type: 1-친구요청, 2-파티초대, 3-수락, 4-거절
 * msg: 받는 사람에게 보낼 메세지
 * push_id: 요청에 대한 대답 시에만 사용
 * push_id: 요청에 대한 대답 시에만 사용
 */
function sendPush(sender, addressee, type, msg) {
	
    var sendPush = {
		type: type,
		sender: sender,
		addressee: addressee,
		msg: msg
	}
    
    console.log('push를 서버로 보냅니다! -> ' + JSON.stringify(sendPush))

    ws_push.send(JSON.stringify(sendPush));

}

//서버로 메시지 발신
/*
 * @param
 * push_id: push 아이디
 * type: 3
 * msg: 받는 사람에게 보낼 메세지
 * agree: 요청에 대한 응답
 */
function sendResponse(push_id, type, msg, agree) {
	
    var sendPush = {
    	push_id: push_id,
		type: type,
		msg: msg,
		agree: agree
	}

    ws_push.send(JSON.stringify(sendPush));

}

//메시지 수신
function onMessage_push(evt) {
    
    var pushData = JSON.parse(evt.data);
    
    console.log('push서버에서 메세지옴 -> ' + JSON.stringify(evt.data));
    
    if(pushData.type == 1 || pushData.type == 2) {
    	// 내가 푸쉬를 보내는 것!!
    	show_unread_push(pushData);
    } else if(pushData.type == 3 || pushData.type == 4) {
    	// 상대방이 수락했는지를 응답한 것!!
    	show_unread_push(pushData)
    }
    
}

function show_unread_push(push) {
	
	var $target = $('#invite_list');
	
	$(push).each(function(i, unread) {
		
		var head_text;
		
		if (unread.type == 1) {
			head_text = "친구 요청";
		} else if (unread.type == 2) {
			head_text = "파티 초대";
		} else if (unread.type == 3) {
			
			unread.sender = unread.addressee;
			
			if (unread.agree == 1) {
				head_text = "요청  승낙";
				unread.msg = "친구가 되었습니다.";
				searchword();
			} else {
				head_text = "요청  거절";
				unread.msg = "친구 요청을 거절했습니다."
			}
		} else if (unread.type == 4) {
			
			unread.sender = unread.addressee;
			
			if (unread.agree == 1) {
				head_text = "가입 승낙";
				unread.msg = "파티원이 되었습니다."
				print_party_member($('#desolve').attr('data'));
				searchgroup();
			} else {
				head_text = "가입 거절";
				unread.msg = "파티 가입을 거절했습니다."
			}
		}

		var $card = $('<div />', {
			"class": "news_card",
			"role": "invite",
			"who": unread.sender,
			"type": unread.type,
			"push_id": unread.push_id
		}).css({
			"width": "100%",
			"height": "100px",
			"background-color": "white",
			"margin-bottom": "5px",
			"text-align": "center"
		}).prependTo($target);
		
		var $head = $('<div />', {
			"class": "news_card news_head",
			"role": "head",
			"text": head_text
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
			"text": unread.msg
		}).css({
			"width": "100%",
			"height": "20px",
			"float": "left",
			"display": "inline-block"
		}).appendTo($card);
		
		var $date = $('<div />', {
			"class": "news_card news_date",
			"role": "date",
			"text": unread.send_date
		}).css({
			"width": "100%",
			"height": "10px",
			"float": "left",
			"display": "inline-block"
		}).appendTo($card);
		
		var $container = $('<div />', {
			"class": "news_card news_button_container",
			"role": "container"
		}).css({
			"width": "100%",
			"height": "20px",
			"float": "left",
			"display": "inline-block"
		}).appendTo($card);
		
		if(unread.type < 3) {
		
			var $ok = $('<div />', {
				"class": "news_card news_button",
				"role": "ok",
				"text": "YES"
			}).css({
				"width": "25%",
				"height": "14px",
				"float": "left",
				"display": "inline-block",
				"margin": "3px"
			}).appendTo($container).click(function(e){
				sendResponse($(this).parent().parent().attr('push_id'), (Number($(this).parent().parent().attr('type'))+2), "좋아요", 1);
				$(this).parent().parent().remove();
				alert("승낙했습니다.");
				searchword();
				searchgroup();
				print_party_member($('#desolve').attr('data'));
			});
			
			var $no = $('<div />', {
				"class": "news_card news_button",
				"role": "no",
				"text": "NO" /*왜 적용안되냐고*/
			}).css({
				"width": "25%",
				"height": "14px",
				"float": "left",
				"display": "inline-block",
				"margin": "3px"
			}).appendTo($container).click(function(e){
				sendResponse($(this).parent().parent().attr('push_id'), (Number($(this).parent().parent().attr('type'))+2), "싫어요!", 0);
				$(this).parent().parent().remove();
				alert("거절했습니다.");
				
			});
		
		}
		
		var $close = $('<div />', {
			"class": "news_card news_button",
			"role": "close",
			"text": "CLOSE"
		}).css({
			"width": "25%",
			"height": "14px",
			"float": "left",
			"display": "inline-block",
			"margin": "3px"
		}).appendTo($container).click(function(e) {
			$(this).parent().parent().remove();
		});
		
	})
	
}

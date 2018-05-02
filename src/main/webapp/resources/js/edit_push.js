/**
 * 채팅 관련 메소드 모음
 */

 // 채팅에 쓸 웹소켓과 위치
var websocket_edit;
var wsUri_edit = "ws://cooing.site/www/edit/echo.do";

var member_id;
var party_name;

/*
 *	로그인 상태일 경우 채팅 준비
 *	@param (로그인 아이디, 파티명)
 */ 
function readyEdit (member_id, party_name) {

	console.log('edit 준비!, userId-> ' + userId);

	// 로그인 정보 확인 후 전역변수에 저장
	if(member_id == '') {
		// 로그인 정보 없음
		return;
	} else {
		this.member_id = member_id;
		this.party_name = party_name;
	}

	// 웹소켓 연결
	websocket_edit = new WebSocket(wsUri_edit);
 	
 	// 웹소켓 이벤트 별 함수 연결

 	// 채팅 연결
	websocket_edit.onopen = function(evt) {
   		onOpen_edit(evt)
   	};

   	// 메세지 수신
   	websocket_edit.onmessage = function(evt) {
   		onMessage_edit(evt)
   	};

   	// 에러 수신
   	websocket_edit.onerror = function(evt) {
   		//onError(evt)
   	};

   	// 웹소켓 종료
   	websocket_edit.onclose = function(evt) {
   		//onClose_edit(evt)
   	};
   	
	$(window).bind("beforeunload", function (e){
		console.log('윈도우 언로드 -> 편집을 종료합니다.')
		end_edit()
	});

   	
}

//편집 시작
function onOpen_edit(evt) {
	
	var msg = {
		type: "open",
		party_name: party_name,
		member_id: member_id
	}
	websocket_edit.send(JSON.stringify(msg));
	
}



//편집 종료
function end_edit() {
	
	var msg = {
		type: "end",
		party_name: party_name,
		member_id: member_id
	}
	websocket_edit.send(JSON.stringify(msg));
	
}

//메시지 수신
function onMessage_edit(evt) {
    
    var pushData = JSON.parse(evt.data);
    
    console.log('push서버에서 메세지옴 -> ' + JSON.stringify(evt.data));
    
    
    if(pushData.type == 'open') {
    	
    	
    	// 편집 가능
    	if (pushData.editable == 'true') {
    		
    		editable_switch('disable');
    		
    		$('#i_edit').attr('role', '편집하기').off('click').on('click', function(e) {
    			e.stopPropagation();
    			isEditable();
        	}).css({
    			"color": "blue"
    		});
    		
		} else if(pushData.editable == 'false') {
			if(pushData.curr_edit == this.member_id) {
				// 현재 편집 중인 유저이므로.. 아무 말 않는다..

			} else {
				
				editable_switch('disable');
				
				// 현재 편집 중인 유저가 아니므로... 편집 중이라고 알려준다...
				$('#i_edit').attr('role', '편집 중').off('click').on('click', function(e) {
					e.stopPropagation();
					return;
	        	}).css({
	    			"color": "red"
	    		});
			}
			
		}
    	
    } else if(pushData.type == 'start') {
    	// 편집 가능
    	if (pushData.editable == 'true') {
    		
    		if (pushData.member_id == this.member_id) {
				// 편집 요청한 사람
    			
    			editable_switch('enable');
    			
    			$('#i_edit').attr('role', '편집 그만하기').off('click').on('click', function(e) {
    				e.stopPropagation();
            		end_edit();
            	}).css({
        			"color": "black"
        		});
    			
			} else {
				
				editable_switch('disable');
				
				$('#i_edit').attr('role', '편집 중').off('click').on('click', function(e) {
					e.stopPropagation();
					return;
	        	}).css({
	    			"color": "red"
	    		});
			}
    		
		} else if(pushData.editable == 'false') {
			// 이 때는 변동사항이 없을 걸...?
			
		}
    	
    } else if(pushData.type == 'end') {
    	// 편집 끝남
    	editable_switch('disable');
    	
    	//reload 말고 더 좋은 방법은...?
    	if(pushData.member_id != this.member_id) {
    		$.ajax({
    			url : 'get_pages',
    			type : 'POST',
    			data : {
    				album_num: $('#hidden_album_num').val()
    			},
    			success : function(result) {
    				$('#album').turn('destroy');
    				console.log('답변 옴. 길이는 ->' + result.length);
    				$(result).each(function(i, page){
    					console.log(JSON.stringify(page));
    					var $page = $('<div />', {
    						"id": "page"+page.page_num,
    						"class": "page hard"
    					}).html(page.page_html).css({
    						"background-color": page.page_color,
    						"background-image": page.page_background
    					}).appendTo('#album');
    				});
    				ready_album('edit');
    			},
    			error : function(e) {
    				console.log('에러 -> ' + JSON.stringify(e));
    			}
    		});
    	}
    	
		$('#i_edit').attr('role', '편집하기').off('click').on('click', function(e) {
			e.stopPropagation();
    		isEditable();
    	}).css({
			"color": "blue"
		});
    	
    }
    
}

//메시지 발신
function isEditable() {
	
	var msg = {
		type: "start",
		party_name: party_name,
		member_id: member_id
	}
	websocket_edit.send(JSON.stringify(msg));
	
}

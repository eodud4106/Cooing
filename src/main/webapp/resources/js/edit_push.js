/**
 * 채팅 관련 메소드 모음
 */

 // 채팅에 쓸 웹소켓과 위치
var websocket_edit;
var wsUri_edit = "ws://cooing.site/www/edit/echo.do";

var userId;
var counterpart;
var is1to1;
var goRoot;

/*
 *	로그인 상태일 경우 채팅 준비
 *	@param (로그인 아이디)
 */ 
function readyEdit (userId) {

	console.log('edit 준비!, userId-> ' + userId);

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
   		onClose_edit(evt)
   	};

   	
}

//웹소켓 연결 성공
function onOpen_edit(evt) {

	
}

//채팅창 닫힘
function onClose_edit() {
	

}

//메시지 수신
function onMessage_edit(evt) {
    
    
}

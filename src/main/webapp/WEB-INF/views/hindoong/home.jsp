<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>채팅 테스트</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

    $(document).ready(function() {

        $("#sendBtn").click(function() {
            sendMessage();
        });
        
        var wsUri = "ws://localhost:8080/www/chat/echo.do";
        websocket = new WebSocket(wsUri);
	   	websocket.onmessage = function(evt) {
	   		onMessage(evt)
	   	};
	   	websocket.onopen = function(evt) {
	   		onOpen(evt)
	   	};
	   	websocket.onerror = function(evt) {
	   		onError(evt)
	   	};

    });
    
    /* 메시지 발신 */
    function sendMessage() {
    	
    	//TODO 수신자, 발신자를 잘....
        var sendMessage = {
				from: "test",
				to: "test1",
				message: $('#message').val()
			}

        websocket.send(JSON.stringify(sendMessage));
        $('#message').val('');

    }
    
	function onOpen(evt) {
		//TODO 채팅창 열렸을 때 모든 메시지를 핸들러가 보낸다. 여기서는 그 메시지를 차곡차곡 잘 보여주자...
	}
    
	//서버로부터 메시지를 받으면 호출됨.
    function onMessage(evt) {

        var data = evt.data;
        $("#data").append(data + "<br/>");

    }


    function onClose(evt) {

        $("#data").append("연결 끊김");

    }

</script>
</head>
<body>
	
	
	<h1 style="text-align: center;">흰둥이 채팅방</h1>
	<br>
	<div style="text-align: center;">
	
		<a href="/www">홈으로 돌아가기...</a>
	
		<p>입장 시각 -> ${serverTime }</p>	

		<input type="text" id="message" />

	    <input type="button" id="sendBtn" value="전송" />
	
	    <div id="data"></div>
	</div>
	<div id="output"></div>
</body>
</html>
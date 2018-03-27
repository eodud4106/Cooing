<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>테스트 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="resources/js_js/jquery-3.2.1.min.js"></script>

</head>
<body>
	현재 시각 -> ${serverTime }
	<script type="text/javascript">
		var wsUri = "ws://localhost:8080/www/chat/echo.do";

		function init() {
			output = document.getElementById("output");
		}
		function send_message() {
			websocket = new WebSocket(wsUri);
			websocket.onopen = function(evt) {
				onOpen(evt)
			};
			websocket.onmessage = function(evt) {
				onMessage(evt)
			};
			websocket.onerror = function(evt) {
				onError(evt)
			};
		}

		function onOpen(evt) {
			writeToScreen("Connected to Endpoint!");
			doSend(textID.value);
		}
		
		//서버로부터 메세지를 받고 출력하는 함수.
		function onMessage(evt) {
			writeToScreen("Message Received: " + evt.data);
		}
		
		//에러 발생 시 출력
		function onError(evt) {
			writeToScreen('ERROR: ' + evt.data);
		}
		
		//메세지 보낼 시 호출.
		function doSend(message) {
			writeToScreen("Message Sent: " + message);
			
			var send = {
				from: "test",
				to: "test1",
				message: message
			}
			
			websocket.send(JSON.stringify(send));
			
			textID.value='';
			
			//websocket.close();
		}
		
		// 뷰에 innerHTML로 텍스트 출력.
		function writeToScreen(message) {
			var pre = document.createElement("p");
			pre.style.wordWrap = "break-word";
			pre.innerHTML = message;

			output.appendChild(pre);
		}
		window.addEventListener("load", init, false);
		
	</script>
	<h1 style="text-align: center;">Hello World WebSocket Client</h1>
	<br>
	<div style="text-align: center;">
		<form action="">
			<input onclick="send_message()" value="Send" type="button">
			<input id="textID" name="message" value="Hello WebSocket!" type="text"><br>
		</form>
	</div>
	<div id="output"></div>
</body>
</html>
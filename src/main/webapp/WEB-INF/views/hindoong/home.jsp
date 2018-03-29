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

	var wsUri = "ws://localhost:8080/www/chat/echo.do";
	var websocket;

    $(document).ready(function() {

        $("#sendBtn").click(function() {
            sendMessage();
        });

    });
    
    /* 메시지 발신 */
    function sendMessage() {
    	
    	//TODO 수신자, 발신자를 잘....
        var sendMessage = {
    				type: "message",
				from: sessionStorage.getItem('loginId'),
				to: sessionStorage.getItem('to'),
				message: $('#message').val()
			}

        websocket.send(JSON.stringify(sendMessage));
        $('#message').val('').focus();

    }
    
	function onOpen(evt) {
		//TODO 채팅창 열렸을 때 모든 메시지를 핸들러가 보낸다. 여기서는 그 메시지를 차곡차곡 잘 보여주자...
		//open할 때... 현재 유저의 아이디를 서버로 보내자...
		var sendMessage = {
			type: "loginId",
			id: sessionStorage.getItem('loginId'),
			to: sessionStorage.getItem('to'),
		}

   		websocket.send(JSON.stringify(sendMessage));
	}
    
	//서버로부터 메시지를 받으면 호출됨.
    function onMessage(evt) {

        var data = evt.data;
        
        var chatData = JSON.parse(data);
        
        var from = chatData.p_message_from;
        var message = chatData.p_message_message;
        var m_date = chatData.p_message_date.substring(0,16);
        
        var div_message = document.createElement('div');
        
        if (from == sessionStorage.getItem('loginId')) {
			//자기가 보낸 메시지
			$(div_message).css('text-align', 'right').html(m_date + "/" + message + " < <br>");
			
		} else {
			//다른 사람이 보낸 메시지
			$(div_message).css('text-align', 'left').html(from + " > " + message + "/" + m_date + "<br>");
			
		}
        
        $("#data").append(div_message);
        
        $("#data").scrollTop($("#data")[0].scrollHeight);
       
    }


    function onClose(evt) {

        $("#data").append("연결 끊김");

    }
    
    function setLoginId() {
    		var id = $('#loginId').val();
    		sessionStorage.setItem('loginId', id);
    		sessionStorage.setItem('to', $('#select_friend').val());
    		$('#span_loginId').text(id);
    	
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
    }
    
    //TODO 페이지 로딩 시 친구 목록 가져오는 ajax... 를 여기 작성할 예정임...

</script>
</head>
<body>
	
	<h1 style="text-align: center;">흰둥이 채팅방</h1>
	<br>
	<div style="text-align: center;">
	
		<a href="/www">홈으로 돌아가기...</a>
	
		<p>입장 시각 -> ${serverTime }</p>	
		<p>로그인 아이디 -> <span id="span_loginId"></span></p>	
		<select id="select_friend">
			<option>보낼 친구 선택</option>
			<option value="test1">test1</option>
			<option value="test2">test2</option>
			<option value="test3">test3</option>
		</select>
		<input type="text" id="loginId" placeholder="아이디 입력...">
		<input type="button" value="확인" onclick="setLoginId()">
	
	    <div id="data" style="height: 300px; width: 80%; overflow-y: scroll; margin: auto"></div>
	    
	    <div id="div_send">
			<input type="text" id="message" autocomplete="off"/>
			<input type="button" id="sendBtn" value="전송" />
	    </div>
	    
	</div>
	<div id="output"></div>
</body>
</html>
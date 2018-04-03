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

//TODO 내 아이디와 친구 아이디를 태그 속성 값이 넣어두는 건 위험할 것 같으니... 다른 방법을 생각해보자...

	var wsUri = "ws://localhost:8080/www/chat/echo.do";
	var websocket;

    $(document).ready(function() {
    	
   	 	$("#message").keydown(function (key) {
            if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
            		sendMessage();
            		return false;
            }
        });
   	 	
        $("#sendBtn").click(function() {
            sendMessage();
        });
        
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
	   	
	   	$("#data").scrollTop($("#data")[0].scrollHeight);

    });
    
    /* 메시지 발신 */
    function sendMessage() {
    	
    	//TODO 수신자, 발신자를 잘....
        var sendMessage = {
    				type: "message",
				from: $('#span_loginId').attr('loginId'),
				to: $('#friend_id').attr('friend_id'),
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
			id: $('#span_loginId').attr('loginId')
		}

   		websocket.send(JSON.stringify(sendMessage));
		
		readMessage();
	}
    
	//서버로부터 메시지를 받으면 호출됨.
    function onMessage(evt) {

        var data = evt.data;
        
        var chatData = JSON.parse(data);
        
        if (chatData.type != null && chatData.type == 'read') {
			$('span[tag="read"]').remove();
			return;
		}
        
        var from = chatData.p_message_from;
        var message = chatData.p_message_message;
        var m_date = chatData.p_message_date.substring(0,16);
 		//일대일 채팅이므로.. 메세지를 수신받았다면 당연히 읽은 것으로 본다.. 따라서
        
        var div_message = document.createElement('div');
        
        if (from == $('#span_loginId').attr('loginId')) {
			//자기가 보낸 메시지
			var span_read = document.createElement('span');
			$(div_message).css('text-align', 'right').html("<span tag='read' style='font-size: 6pt' >1 </span>" + 
					m_date + " / " + message + " < <br>");
		} else {
			//다른 사람이 보낸 메시지
			$(div_message).css('text-align', 'left').html(from + " > " + message + " / " + m_date + "<br>");
			readMessage();
		}
        
        $("#data").append(div_message);
        
        $("#data").scrollTop($("#data")[0].scrollHeight);
       
    }


    function onClose(evt) {

        $("#data").append("연결 끊김");

    }
    
    function readMessage() {
        //메시지를 수신 받았다면.. 채팅방에 접속한 상태이고 따라서 메시지를 읽은 것으로 본다..
        var sendMessage = {
			type: "read",
			to: '${sessionScope.Member.member_id}',
			from: '${friend_id}'
		}
       	websocket.send(JSON.stringify(sendMessage));
    }
    
    function setTo() {
    		
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
		<p>로그인 아이디 -> <span id="span_loginId" loginId="${sessionScope.Member.member_id}">${sessionScope.Member.member_id}</span></p>
		<p>대화 상대 -> <span id="friend_id" friend_id="${friend_id}">${friend_id}</span></p>
	
	    <div id="data" style="height: 300px; width: 80%; overflow-y: scroll; margin: auto; display: block;">
			<c:if test="${arr_pm != null }">
				<c:forEach items="${arr_pm }" var="pm">
					<c:if test="${pm.p_message_from == sessionScope.Member.member_id }">
					<!-- 자기가 보낸 메세지 -->
						<div style="text-align: right">
							<c:if test="${pm.p_message_read != 0}">
								<span tag="read" style="font-size: 6pt">${pm.p_message_read } </span>
							</c:if>
							<span>${pm.p_message_date.substring(0, 16) } / </span>
							<span>${pm.p_message_message } < </span>
						</div>
					</c:if>
					<c:if test="${pm.p_message_from != sessionScope.Member.member_id }">
					<!-- 상대가 보낸 메세지 -->
						<div style="text-align: left">
							<span> > ${pm.p_message_from } > </span>
							<span>${pm.p_message_message } / </span>
							<span>${pm.p_message_date.substring(0, 16) }</span>
						</div>
					</c:if>
				</c:forEach>	
			</c:if>
	    </div>
	    
	    <div id="div_send">
			<input type="text" id="message" autocomplete="off"/>
			<input type="button" id="sendBtn" value="전송" />
	    </div>
	    
	</div>
	<div id="output"></div>
</body>
</html>
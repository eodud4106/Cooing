<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<title>albumReply</title>
<script type="text/javascript" src="./resources/js/jquery-3.3.1.min.js"></script>
<script>
// 댓글 쓰기
function writereply(){

	var str = $('#reply').val();
	var num = 15;
	
	$.ajax({
		url:'writeReply',
		type: 'POST',		
		data: {
			"reply_albumnum": num,
			"reply_contents": str 
		},
		dataType: 'text',
		success: function(a){
			
			if(a == 'success'){
				alert("댓글 등록");
				
			}
			else{
				alert(a);
			}
		},
		error:function(e){
			alert(JSON.stringify(e));
		}		
	});
}
// 댓글 삭제
function deletereply(){

	var num = 15;
	
	$.ajax({
		url:'deleteReply',
		type: 'POST',		
		data: {
			"reply_albumnum": num,
		},
		dataType: 'text',
		success: function(a){
			
			if(a == 'success'){
				alert("댓글 삭제");
				
			}
			else{
				alert(a);
			}
		},
		error:function(e){
			alert(JSON.stringify(e));
		}		
	});
}
</script>
<body>
<form>
댓글 내용
&nbsp;<input type="text" id="reply" name="reply" size="70">
&nbsp;<input type="submit" onclick="writereply()" value="저장">
&nbsp;<button type="button" onClick="deletereply();">삭제</button>
</form>

</body>
</html>


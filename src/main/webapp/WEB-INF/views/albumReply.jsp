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
	var num = 1;
	
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

	var num = 1;
	
	if(confirm("댓글을 삭제 하시겠습니까?")){
		 	
		$.ajax({
			url:'deleteReply',
			type: 'POST',		
			data: {
				"reply_albumnum": num
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
}
</script>
<body>
<form>
내용
&nbsp;<input type="text" id="reply" name="reply" size="70">
&nbsp;<button type="button" onclick="writereply()">저장</button>
</form>
<form>
<c:forEach var="reply" items="${list}">
<table>
	<tr>
		<td><input type="hidden" value="${reply.reply_num }"></td>
	</tr>
	<tr>
		<td> 작성자 </td>
		<td>${reply.reply_memberid}</td>
	</tr>
	<tr>
		<td> 작성일 </td>
		<td>${reply.reply_date}</td>
	</tr>
	<tr>
		<td> 내용 </td>
		<td>${reply.reply_contents}</td>
	</tr>
		<td>
<button type="button" onClick="deletereply()">삭제</button>
		</td>
	</tr>
</table>

=====================================
</c:forEach>
</form>

</body>
</html>


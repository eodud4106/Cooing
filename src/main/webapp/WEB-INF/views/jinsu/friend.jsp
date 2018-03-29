<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>friend</title>
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
});
function initialize(){
	$('#friendbt').on('click',fiendplus);
}
function fiendplus(){
	var friendid = $('#friendid').val();
	var data = $('#friendbt').attr('data');
	if(data == 0){
		$.ajax({
			url:'friend_plus',
			type:'POST',		
			data:{friendid:friendid},
			dataType:'text',
			success: function(a){
				if(a=='success'){
					$('#friendbt').val('친구삭제');
					$('#friendbt').attr('data' , '1');
				}
				else{
					alert('친구 추가가 되지 않았습니다.ERROR');
				}
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}else if(data == 1){
		$.ajax({
			url:'friend_delete',
			type:'POST',		
			data:{friendid:friendid},
			dataType:'text',
			success: function(a){
				if(a=='success'){
					$('#friendbt').val('친구추가');
					$('#friendbt').attr('data' , '0');
				}
				else{
					alert('친구 삭제가 되지 않았습니다.ERROR');
				}
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}
</script>
</head>
<body>
	<table>
		<tr><th>친구</th><td>친구추가</td></tr>
		<tr><th>${friend.getMember_id()}</th><td>
			<c:if test="${check ne true }">
				<input type="button" id="friendbt" value="친구추가" data="0">
			</c:if>
			<c:if test="${check eq true }">
				<input type="button" id="friendbt" value="친구삭제" data="1">
			</c:if>
			<input type="hidden" value="${friend.getMember_id()}" id="friendid">
			</td></tr>
	</table>
</body>
</html>
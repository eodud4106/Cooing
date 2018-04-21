<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<title>albumReply</title>
<script type="text/javascript" src="./resources/js/jquery-3.3.1.min.js"></script>
<script>
$( document ).ready(function() {
	replyList();
});
// 댓글 쓰기
function writereply(){

	var conents = $('#contents').val();
	var albumnum = 1;
	
	$.ajax({
		url:'writeReply',
		type: 'POST',		
		data: {
			"reply_albumnum": albumnum,
			"reply_contents": conents 
			
		},
		dataType: 'text',
		success: function(a){
			
			if(a == 'success'){
				// alert("댓글 등록");	
				replyList();		
			}
			else{
				alert('실패');
			}
		},
		error:function(e){
			alert(JSON.stringify(e));
		}		
	});
}
//댓글 목록
function replyList(){
	
	var albumnum = 1;
	
	$.ajax({
		url:'listReply',
		type: 'get',		
		data: {
			"reply_albumnum": albumnum		
		},
		dataType: 'json',
		success: function(list){
			viewResult(list);
		},
		error:function(e){
			alert(JSON.stringify(e));
		}		
	});
}
// 댓글 목록
function viewResult(list){
	
	var str = '';
	
	str += '<table>';
	$(list).each(function(i, vo){
		str += '<tr>';
		str += '<td>';
		str += ' ' + vo.reply_memberid;
		str += ' ' + vo.reply_contents;
		str += ' ' + vo.reply_date;
		if (vo.reply_memberid == '${Member.member_id}') {
		str += ' ' + "<input type='button' value='삭제' onclick='deletereply("+vo.reply_num+")'>";
		}
		str += '</td>';
		str += '</tr>';
	});
	str += '</table>';
	$("#resultDiv").html(str);
}

// 댓글 삭제
function deletereply(replynum){

	// alert(replynum);
	
	if(confirm("댓글을 삭제 하시겠습니까?")){
		 	
		$.ajax({
			url:'deleteReply',
			type: 'POST',		
			data: {
				"reply_num": replynum
			},
			dataType: 'text',
			success: function(a){
				if(a == 'success'){
					// alert("댓글 삭제");	
					replyList();
				}
				else{
					alert("본인 글이 아닙니다.");
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
&nbsp;<input type="text" id="contents" name="contents" size="70">
&nbsp;<button type="button" onclick="writereply()">저장</button>
<input type="hidden" name="reply_albumnum" value="11">
</form>

<div id="resultDiv">

</div>

</body>
</html>


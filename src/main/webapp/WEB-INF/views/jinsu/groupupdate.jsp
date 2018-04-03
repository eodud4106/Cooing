<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gruop Update</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(document).ready(function () {
	initialize();
});
function initialize(){
	$('#findid').keyup(searchword);
	$('#gmemberplus').on('click',memberplus);
	$('input[name=gmemberdelete]').on('click',memberdelete);
	$('#desolve').on('click',deleteparty);
}
function deleteparty(){
	var party_num = $('#desolve').attr('data');
	$.ajax({
		url:'delete_party',
		type:'POST',		
		data:{partynum:party_num},
		dataType:'text',
		success: function(list){
			if(list=='success'){
				location.href="../";
			}else{
				alert(list);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function memberdelete(){
	var member_id = $(this).attr('data');
	var party_num = $(this).attr('data2');
	$.ajax({
		url:'delete_member',
		type:'POST',		
		data:{memberid:member_id,partynum:party_num},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				$.ajax({
					url:'member_list_post',
					type:'POST',		
					data:{partynum:party_num},
					dataType:'json',
					success: function(list){
						var strmember = '<tr><td colspan="2"><input type="button" id="desolve" value="그룹해체" data="'+party_num+'"></td></tr>';
						$.each(list,function(i,data){
							strmember += '<tr><td>'+data.g_member_memberid+'</td><td><input type="button" name="gmemberdelete" value="멤버강퇴" data="'+data.g_member_memberid+'" data2="'+party_num+'"></td></tr>';
						});
						strmember += '<tr><td><input type="text" id="findid"></td><td><input type="button" id="gmemberplus" value="그룹원 추가" data="'+party_num+'"></td></tr>'
						$('#membertable').html(strmember);
						$('#findid').val('');
						$('#findid').keyup(searchword);
						$('#gmemberplus').on('click',memberplus);
						$('input[name=gmemberdelete]').on('click',memberdelete);
						$('#desolve').on('click',deleteparty);
					},
					error:function(e){alert(JSON.stringify(e));}		
				});
			}else{
				alert(a);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function memberplus(){
	var member_id = $('#findid').val();
	var party_num = $('#gmemberplus').attr('data');
	$.ajax({
		url:'party_member_input',
		type:'POST',		
		data:{groupmember:member_id,partynum:party_num},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				$.ajax({
					url:'member_list_post',
					type:'POST',		
					data:{partynum:party_num},
					dataType:'json',
					success: function(list){
						var strmember = '<tr><td colspan="2"><input type="button" id="desolve" value="그룹해체" data="'+party_num+'"></td></tr>';
						$.each(list,function(i,data){
							strmember += '<tr><td>'+data.g_member_memberid+'</td><td><input type="button" name="gmemberdelete" value="멤버강퇴" data="'+data.g_member_memberid+'" data2="'+party_num+'"></td></tr>';
						});
						strmember += '<tr><td><input type="text" id="findid"></td><td><input type="button" id="gmemberplus" value="그룹원 추가" data="'+party_num+'"></td></tr>'
						$('#membertable').html(strmember);
						$('#findid').val('');
						$('#findid').keyup(searchword);
						$('#gmemberplus').on('click',memberplus);
						$('input[name=gmemberdelete]').on('click',memberdelete);
						$('#desolve').on('click',deleteparty);
					},
					error:function(e){alert(JSON.stringify(e));}		
				});				
			}else{
				alert(a);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function searchword(){
	var text = $('#findid').val();
	if(text.length >= 1){
		$.ajax({
			url:'search_id',
			type:'POST',		
			data:{text:text},
			dataType:'json',
			success: function(array){
				$('#findid').autocomplete({
					source:array 
				});
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}
</script>
</head>
<body>
<H1>Group Update</H1>
<table id="membertable">
<tr>
<td colspan="2">
<input type="button" id="desolve" value="그룹해체" data="${partyinfo.getParty_num()}">
</td>
</tr>
<c:if test="${Member ne null}">
	<c:if test="${fn:length(memberlist) ne 0}">
		<c:forEach var="arrml" items="${memberlist}">
			<tr><td>${arrml.getG_member_memberid()}</td><td><input type="button" name="gmemberdelete" value="멤버강퇴" data="${arrml.getG_member_memberid()}" data2="${partyinfo.getParty_num()}"></td></tr>
		</c:forEach>
	</c:if>
</c:if>

<tr><td><input type="text" id="findid"></td>
<td><input type="button" id="gmemberplus" value="그룹원 추가" data="${partyinfo.getParty_num()}"></td></tr>
</table>

</body>
</html>
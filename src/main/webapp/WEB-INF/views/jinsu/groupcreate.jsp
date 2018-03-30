<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GroupCreate</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(document).ready(function () {
	initialize();
});
function initialize(){
	$('#searchidbt').on('click' ,searchfriend);
	$('#groupid').keyup(searchword);
	$('#createbt').on('click' , creategroup);
}
//여기서 부터 제작해야 함 일반 멤버 부분에 partynum 구해와서 넣어줘야 됨 partyname이 unique니까 그걸로 찾아서 넣어주면 될듯 거의 다함.
function creategroup(){
	if($('#groupname').val().length > 0){
		alert('groupcreate');
		$.ajax({
			url:'party_create',
			type:'POST',		
			data:{groupname:$('#groupname').val()},
			dataType:'text',
			success: function(a){
				if(a=='success'){
					var num = 0;
					if($('#idlist').val().length > 0){
						var idlist = $('#idlist').val();
						$.ajax({
							url:'party_member_create',
							type:'POST',		
							data:{groupmember:idlist,partynum:num},
							dataType:'text',
							success: function(a){
								if(a=='success'){
									location.href="../";
								}
								else{
									alert('파티 멤버 추가에 실패 했습니다.Error');
								}
							},
							error:function(e){alert(JSON.stringify(e));}		
						});
					}
				}
				else{
					alert('파티 생성에 실패 했습니다.Error');
				}
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}	
}
function searchfriend(){
	var text = $('#groupid').val();
	$.ajax({
		url:'friend_check',
		type:'POST',		
		data:{id:text},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				$('#idlist').append(text + '<br>');
			}
			else{
				alert('찾으시는 친구 ID가 없습니다.');
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function searchword(){
	var text = $('#groupid').val();
	if(text.length >= 1){
		$.ajax({
			url:'search_id',
			type:'POST',		
			data:{text:text},
			dataType:'json',
			success: function(array){
				$('#groupid').autocomplete({
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

<h1>GroupCreate</h1>
<table>
<tr><th><input type="text" id="groupname" placeholder="GroupName" maxlength="10"></th></tr>
<tr><th><input type="text" id="groupid" placeholder="ID검색"><input type="button" id="searchidbt" value="검색"></th></tr>
<tr><th><div id="idlist"></div></th></tr>
<tr><th><input type="button" id="createbt" value="그룹 생성"></th></tr>
</table>
</body>
</html>
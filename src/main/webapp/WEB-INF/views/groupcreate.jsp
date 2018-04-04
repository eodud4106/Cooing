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
function creategroup(){
	var name = $('#groupname').val();
	if(name.length > 0){
		$.ajax({
			url:'party_create',
			type:'POST',		
			data:{groupname:name},
			dataType:'text',
			success: function(a){
				if(a != '-1'){
					var idlist = $('#idlist').html();
					if(idlist.length > 0){
						$.ajax({
							url:'party_member_create',
							type:'POST',		
							data:{groupmember:idlist,partynum:a},
							dataType:'text',
							success: function(a){
								if(a=='success'){									
									opener.location.href="./groupPage?group_name="+name;
									window.close();
								}
								else{
									alert(a);
								}
							},
							error:function(e){alert(JSON.stringify(e));}		
						});
					}
				}
				else{
					alert('그룹 생성을 실패 했습니다. 잠시 후 다시 시도해 주십시오.');
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
				$('#groupid').val('');
			}
			else{
				alert(a);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function searchword(){
	var text = $('#groupid').val();
	if(text.length >= 1){
		$.ajax({
			url:'jinsu/search_id',
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
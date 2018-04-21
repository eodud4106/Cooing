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
<script src="<c:url value="/resources/js/group.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
});
</script>
</head>
<body id="groupbody">

<h1>GroupCreate</h1>
<table>
<tr><th><input type="text" id="groupname" placeholder="GroupName" maxlength="10"></th></tr>
<tr><th><input type="text" id="groupid" placeholder="ID검색"><input type="button" id="searchidbt" value="검색" data="${Member.getMember_id()}"></th></tr>
<tr><th><div id="idlist"></div></th></tr>
<tr><th><input type="button" id="createbt" value="그룹 생성"></th></tr>
</table>
</body>
</html>
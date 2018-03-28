<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	<meta charset="UTF-8">
</head>
<body>
<h1>
	쿠잉 관문  
</h1>

<a href="<c:url value ="/albumList"/>">MainPage</a><br>
<a href="<c:url value ="/albumView"/>">albumView</a><br>
<a href="<c:url value ="/chat"/>">흰둥이 채팅방 입장</a><br>
</body>
</html>

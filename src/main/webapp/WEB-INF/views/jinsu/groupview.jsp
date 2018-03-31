<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GroupView</title>
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
</head>
<body>
<h1>LeaderList</h1>
<c:if test="${Member ne null}">
	<c:if test="${fn:length(leaderlist) ne 0}">
		<c:forEach var="arrll" items="${leaderlist}">
			<div name="leaderlist">
				<p>${arrll}</p>
			</div>
		</c:forEach>
	</c:if>
</c:if>

<h1>MemberList</h1>
<c:if test="${Member ne null}">
	<c:if test="${fn:length(memberlist) ne 0}">
		<c:forEach var="arrml" items="${memberlist}">
			<div name="memberlist">
				<p>${arrml}</p>
			</div>
		</c:forEach>
	</c:if>
</c:if>


</body>
</html>
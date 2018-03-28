<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<p><a href="<c:url value ="/albumList"/>">MainPage</a>
<p><a href="<c:url value ="/albumView"/>">albumView</a>
</body>
</html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<script>
function OpenAlbum(theURL,winName,features) { //v2.0
	window.open('album','album',"width=800,height=550,resizeable=yes ,menubar=yes,toolbar=yes,location=yes,scrollbars=yes,status=yes");
}

</script>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  11
</h1>
<p>test....</p>
<p>from web</p>
<p>from eclipse</p>
<p>develop....</p>
<p>rebase..........</p>
<P>  The time on the server is ${serverTime}. </P>
<a href = "albumDrag/drag">123</a>
<a href="javascript:OpenAlbum();">
<img src="<c:url value="/resources/joon_image/digital-art-398342__340.png" />"width="200" height="150"></a>
</body>
</html>

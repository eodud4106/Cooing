<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head><title></title>
<script language="JavaScript">
function OpenAlbum(theURL,winName,features) { //v2.0
	window.open('album','album',"width=800,height=550,resizeable=yes ,menubar=yes,toolbar=yes,location=yes,scrollbars=yes,status=yes");
}

</script>
</head>
<body>


<a href="javascript:OpenAlbum();">
<img src="<c:url value="/resources/joon_image/digital-art-398342__340.png" />"width="200" height="150"></a>
</body>
</html>
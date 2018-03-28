<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Resizable - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script language="JavaScript">
   $( function() {
    $( "#photo" ).resizable();
  } ); 
  $( function() {
	$( "#photo" ).draggable();
	} );
  function OpenAlbum(theURL,winName,features) { //v2.0
		window.open('album','album',"width=800,height=550,resizeable=yes,menubar=yes,toolbar=yes,location=yes,scrollbars=yes,status=yes,channelmode=yes");
	}
  </script>
</head>
<body>
 

<a href="javascript:OpenAlbum();">
<img src="<c:url value="/resources/joon_image/digital-art-398342__340.png" />"width="300" height="200" id="photo"></a> 
 
</body>
</html>


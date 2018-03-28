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
  <title>jQuery UI Draggable - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
 <style>
  #draggable { width: 150px; height: 150px; padding: 0.5em; }
  #textarea.hover {background-color:black;}
		#image { resize: both; }
</style>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#textarea" ).draggable();
  
    $( "#image" ).resizable();
    $( "#image" ).draggable();
  } );
  </script>
</head>
<body>

<table id ="textarea" style="border: 1px solid; border-collapse: collapse;">   
      
<tr style="border: solid 1px ;">      
<td style="border: 1px solid;">       
<textarea style= "border: 0;"></textarea>  
</td></tr></table>  

<div id="image" class="ui-widget-content" style="width:200px;height:160px;	border: 0px solid #c5c5c5;">
	<img src="<c:url value="/resources/image/cooing5.jpg" />" style="width:100%;height:100%">
</div>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login</title>

<script src="<c:url value="../resources/js_js/jquery-3.2.1.min.js"/>"></script>
<script>
function formCheck() {
	var album_name = $('#album_name').val();
	if(album_name.val.length < 1) {
		alert('앨범명을 입력하세요.');
		return false;
	}
}

</script>
<style>

</style>

</head>
<body class="bodys">

<form method="POST" action="AlbumFirstCreate">
	<div id="entry">
		<h3 style="color: white;">앨범 이름</h3><input type="text" id="album_name" name="album_name">
		<h3 style="color: white;">앨범 내용</h3><input type="text" id="album_contents" name="album_contents">
		<input type="hidden" name="album_party" value="1">
		<input type="hidden" name="album_version" value="1">
		<input type="submit" onsubmit="formCheck()">
	</div>
</form>

</body>
</html>
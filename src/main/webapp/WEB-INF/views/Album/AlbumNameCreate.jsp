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

<script src="<c:url value="../resources/js/jquery-3.3.1.min.js"/>"></script>
<script>
$(document).ready(function () {
	$('#hashtagbt').on('click' , function(){
		hashtagCheck();
	});
});

function byteCheck(chaval){
	var char_val = "";
	var total_byte = 0;
	for(var i = 0; i < chaval.length; i++){
		char_val = chaval.charAt(i);
		if(escape(char_val).length > 4)
			total_byte += 3;
		else
			total_byte++;
	}
	return total_byte;
}

function hashtagCheck(){
	var strhashtag = $('#hashtagtx').val();
	var strhashtaglist = $('#hashtagvw').html();  
	
	  var tags = [];
	  strhashtag = strhashtag.replace(/#[^#\s,;]+/gm, function(tag) {
	    if(byteCheck(tag) <= 60)
		  	tags.push(tag);
	    else
	    	alert('너무 길게 입력하신 단어는 출력되지 않습니다.');
	  });
	  $('#hashtagvw').html(tags.join(','));	
	  $('#hashtag').val($('#hashtagvw').html());
}

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
		<h3 style="color: white;">앨범 카테고리</h3>
		<select name="album_category">		
			<option value="0">여행</option>
		    <option value="1">스포츠/래저</option>
		    <option value="2">동물</option>
		    <option value="3">음악</option>
		    <option value="4">요리/음식</option>
		    <option value="5">패션/뷰티</option>
		    <option value="6">연예/TV</option>
		    <option value="7">게임</option>
		    <option value="8">영화</option>
		    <option value="9">도서</option>
		    <option value="10">공연/전시</option>
		    <option value="11">외국어</option>
		    <option value="12">전문지식</option>
		    <option value="13">수집/제작</option>
		    <option value="14">자기계발</option>
		    <option value="15">육아</option>
		    <option value="16">일상생활</option>
		    <option value="17">자동차</option>
		    <option value="18">낚시</option>
		    <option value="19">건강</option>
		    <option value="20" selected="selected">기타</option>
		</select>
		<br>
		<input type="text" id="hashtagtx" placeholder="해쉬태그"><input type="button" id="hashtagbt" value="추가">
		<div id="hashtagvw"></div>
		<br><br>
		<input type="hidden" name="album_party" value="1">
		<input type="hidden" name="album_version" value="1">
		<input type="hidden" id="hashtag" name="hashtag">
		<input type="submit" onsubmit="formCheck()">
	</div>
</form>

</body>
</html>

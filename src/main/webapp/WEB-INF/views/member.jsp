 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
	<title>JOIN</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="resources/js/jquery-3.3.1.min.js"/></script>
<script src="resources/js/member_in.js"></script>
<script src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>
<script>
var isDuplicated; //지우지마...
$(document).ready(function () {
initialize();
checkcount();
});

</script>
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="resources/assets/images/cooing_logo.png"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/group_fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/group_fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/group_css/util.css">
	<link rel="stylesheet" type="text/css" href="resources/group_css/main.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/css/join.css">
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-85 p-b-20">
				<form class="login100-form validate-form" action ="member_post" method = "POST" id="member_form" enctype = "multipart/form-data">
					<!-- <span class="login100-form-title p-b-70">
						JOIN
					</span> -->
					<div class="div_profile_image">
						프로필 사진 등록
						<span class="login100-form-avatar">
							<img src="" id="preview" >
						</span>
						<div>
							<i class="fas fa-plus" style="width: 50px; height: 50px"></i>
							<input type="file" id="upload" class="input_prifile_image" name="upload" accept="image/*">
						</div>
					</div>
					<div class="wrap-input100 validate-input m-t-85 m-b-35" data-validate = "Enter ID">
						<input id = "id" mexlength="10" class="input100" type="text"name="member_id" >
						<span class="focus-input100" data-placeholder="ID"></span>						
					<div id="idcheck" role="ID중복체크" style = "float : right; margin-top : -40px; cursor: pointer;">ID 중복확인</div>
					</div>

					<div class="wrap-input100 validate-input m-b-50" data-validate="Enter password">
						<input id = "password"class="input100" name="member_pw" maxlength="12" type="password" name="pass">
						<span class="focus-input100" data-placeholder="PASSWORD"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-50" data-validate="Enter password">
						<input id="password2" class="input100"  maxlength="12" type="password" name="pass">
						<span class="focus-input100" data-placeholder="PASSWORD CHECK"></span>
						<font size="1px " style = "float :right; margin-top:10px;"><span style="color:red;">※</span>비밀번호는 6~12글자  /, &, \<, >, | 를 제외한 문자 사용 가능합니다.  </font>
					</div>
					
					<p class="field confirm">
					 <table>
               		 <tr><th rowspan="5" style = "padding-right: 10px;">LIKE						
					</th><td colspan="2">
					여행<input type="checkbox" name="hobby" value="0">
					스포츠 및 레저<input type="checkbox" name="hobby" value="1">
					동물<input type="checkbox" name="hobby" value="2">
					음악<input type="checkbox" name="hobby" value="3">
					<tr><td colspan="2">
					음식 및 요리<input type="checkbox" name="hobby" value="4">					
					패션 및 뷰티<input type="checkbox" name="hobby" value="5">
					연예 및 TV<input type="checkbox" name="hobby" value="6">
					</td></tr><tr><td colspan="2">
					게임<input type="checkbox" name="hobby" value="7">
					
					영화<input type="checkbox" name="hobby" value="8">
					도서<input type="checkbox" name="hobby" value="9">					
					공연 및 전시<input type="checkbox" name="hobby" value="10">
					외국어<input type="checkbox" name="hobby" value="11">
					</td></tr><tr><td colspan="2">
					전문지식<input type="checkbox" name="hobby" value="12">
					수집 및 제작<input type="checkbox" name="hobby" value="13">
					자기계발<input type="checkbox" name="hobby" value="14">
					
					육아<input type="checkbox" name="hobby" value="15">
					<br>
					일상생활<input type="checkbox" name="hobby" value="16">
					
					자동차<input type="checkbox" name="hobby" value="17">
					낚시<input type="checkbox" name="hobby" value="18">
					건강<input type="checkbox" name="hobby" value="19">	
				</td></tr>
			<tr><td height="5" colspan="2"><font size="1px" style = "float: right; padding-bottom: 50px;"><span style="color:red;">※</span>최대 3개까지만 선택</font></td></tr>
                  </table>  </p>
            </form>
					

			<div class="container-login100-form-btn">
				<button class="login100-form-btn" id="join" onclick="return joinmember();">
					JOIN
				</button>
			</div>					

			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
	<script src="resources/group_vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="resources/group_vendor/bootstrap/js/popper.js"></script>
	<script src="resources/group_vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="resources/group_vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="resources/group_vendor/daterangepicker/moment.min.js"></script>
	<script src="resources/group_vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="resources/group_vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="resources/group_js/main.js"></script>
	

</body>
</html>

  
</body>
</html> 
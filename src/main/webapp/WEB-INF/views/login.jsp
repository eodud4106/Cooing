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

<!-- favicon icon -->
<link rel="shortcut icon" href="resources/img/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="resources/img/ico/apple-icon-144x144.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="resources/img/ico/apple-icon-114x114.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="resources/img/ico/apple-icon-72x72.png">
<link rel="apple-touch-icon-precomposed" sizes="57x57" href="resources/img/ico/apple-icon-57x57.png">

<!-- common css -->
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/css/login.css">
<link rel="stylesheet" href="resources/css/responsive.css">

<script src="resources/js/jquery-3.3.1.min.js"/></script>
<script src="resources/js/jquery-ui.min.js"/></script>


<script src="resources/js/member.js"></script>
<script type="text/javascript" src="resources/js/popper.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.js"></script>
<script type="text/javascript" src="resources/js/jquery.ajaxchimp.js"></script>
<script type="text/javascript" src="resources/js/pulgins.js"></script>
<script type="text/javascript" src="resources/js/scripts.js"></script>
<script>
	$(document).ready(function() {
		initialize();
		set_bg();
	});
	function initialize() {
		$('#join').on('click', function () {
			loginmember('./');
		});
		$('#id').keydown(function (evt) {
			if (evt.which == 13) {
				loginmember('./');
			}
		});
		$('#member').on('click' , function(){
			location.href='./member_get';
		});
	}

	function member_check() {
		if ($('#id').val().legnth == 0) {
			alert('ID를 입력해 주세요.');
			return false;
		}
		if ($('#password').val().length == 0) {
			alert('비밀번호를 입력 해주세요.');
			return false;
		}

		return true;
	}
	
	function set_bg() {
		
	}
</script>
<style>
.tb1 {
	margin: auto;
}

.button-login {
	margin: 10px;
	background-color: rgba(0,0,0,.2);
}
body {
	background-image: url(resources/img/travel1.jpg);
	background-repeat: no-repeat;
	background-size: cover;
}

.button-login {
	color: white;
}
</style>

</head>
<body class="img-bg">

	<!-- home section -->
	<section id="home" class="section player">
		<div class="section-container">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2 text-center">
						<div class="content">
							<div class="main-content">
								<h1 class="text-uppercase">COOING</h1>

								<div class="subscribe-area text-center">
									<h3>please login</h3>
								</div>

								<table class="tb1">
									<tr>
										<th>ID</th>
										<td><input type="text" id="id" maxlength="10" required
											autofocus class="form-control"></td>
									</tr>
									<tr>
										<th>PW</th>
										<td><input type="password" id="password" maxlength="12"
											required class="form-control"></td>
									</tr>

									<tr align="center">
										<td colspan="2">
											<input type="button" id="join" value="로그인" class="button-login">
											<input type="button" onclick="javascript:location.href='<c:url value="/"/>';"value="취소"
											class="button-login">
											<input type="button" id="member" value="회원가입" class="button-login">
										</td>
									</tr>
								</table>
							</div>
							<div class="footer">

								<div class="footer-right">
									<p>
										&copy; 2018 - Maintenance by <a href="cooing.site"> Cooing</a>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>



</body>
</html>
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

<title>COOING</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">
<!-- favicon icon --> 
<link rel="shortcut icon" 
  href="resources/assets/images/cooing_logo.png"> 
<link rel="apple-touch-icon-precomposed" sizes="144x144" 
  href="resources/assets/images/ico/apple-icon-144x144.png"> 
<link rel="apple-touch-icon-precomposed" sizes="114x114" 
  href="resources/assets/images/ico/apple-icon-114x114.png"> 
<link rel="apple-touch-icon-precomposed" sizes="72x72" 
  href="resources/assets/images/ico/apple-icon-72x72.png"> 
<link rel="apple-touch-icon-precomposed" sizes="57x57" 
  href="resources/assets/images/ico/apple-icon-57x57.png"> 

<!-- common css -->
<link rel="stylesheet" href="resources/assets/css/bootstrap.min.css"> 
<link rel="stylesheet" href="resources/assets/css/font-awesome.min.css"> 
<link rel="stylesheet" href="resources/css/login.css"> 
<link rel="stylesheet" href="resources/assets/css/responsive.css"> 
 
<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Titan+One" rel="stylesheet"> 
<script src="resources/js_js/jquery-3.2.1.min.js"></script> 
<script src="resources/js/member.js"></script> 
<script>
	$(document).ready(function() {
		initialize();
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
</script>
<style>
.tb1 {
	margin: auto;
}

.button-login {
	margin: 10px;
	background-color: rgba(0,0,0,.2);
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
								
								 <h1 class="text-uppercase" style = "font-family: 'Nanum Gothic Coding', monospace; margin-top: 100px;">COOING</h1> 

								<div class="subscribe-area text-center">
									<!-- <h3>please login</h3> -->
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
											<input type="button" id="join" value="LOGIN" class="button-login">
											<input type="button" onclick="javascript:location.href='<c:url value="/"/>';"value="CANCEL"
											class="button-login">
											<input type="button" id="member" value="JOIN" class="button-login">
										</td>
									</tr>
								</table>
								<p></p> 
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
  <!-- js files --> 
  <script type="text/javascript" 
    src="resources/assets/js/jquery-1.11.3.min.js"></script> 
  <script type="text/javascript" 
    src="resources/assets/js/bootstrap.js"></script> 
  <script type="text/javascript" 
    src="resources/assets/js/jquery.ajaxchimp.js"></script> 
  <script type="text/javascript" src="resources/assets/js/pulgins.js"></script> 
  <script type="text/javascript" 
    src="resources/assets/js/youtube-bg.js"></script> 
  <script type="text/javascript" src="resources/assets/js/scripts.js"></script> 


</body>
</html>
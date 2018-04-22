<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GroupCreate</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<c:url value="/resources/js/group.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
});
</script>
	

	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="resources/group_images/icons/favicon.ico"/>
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
</head>
<body id="groupbody">
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-85 p-b-20">
				<form class="login100-form validate-form">
					<span class="login100-form-title p-b-70">
						GROUP CREATE
					</span>					

					<div class="wrap-input100 validate-input m-t-85 m-b-35" data-validate = "Enter groupname">
						<input input id = "groupname" mexlength="10"class="input100" type="text" name="username">
						<span class="focus-input100" data-placeholder="GroupName"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-50" data-validate="No Member">
						<input class="input100" type="text" name="pass" id = "groupid">
						<span class="focus-input100" data-placeholder="Invite Member"></span>
						<input type="button" id="searchidbt" value="Search ID" data="${Member.getMember_id()}">
						<div id="idlist"></div>
					</div>

					<div class="container-login100-form-btn">
						<button class="login100-form-btn" id="createbt">
							GROUP CREATE
						</button>
					</div>
			
				</form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<!-- <script src="vendor/jquery/jquery-3.2.1.min.js"></script> -->
<!--===============================================================================================-->
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
</html> --%>

 <%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GroupCreate</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<c:url value="/resources/js/group.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
});
</script>
</head>
<body id="groupbody">

<h1>GroupCreate</h1>
<table>
<tr><th><input type="text" id="groupname" placeholder="GroupName" maxlength="10"></th></tr>
<tr><th><input type="text" id="groupid" placeholder="ID검색"><input type="button" id="searchidbt" value="검색" data="${Member.getMember_id()}"></th></tr>
<tr><th><div id="idlist"></div></th></tr>
<tr><th><input type="button" id="createbt" value="그룹 생성"></th></tr>
</table>
</body>
</html>    --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GroupCreate</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<c:url value="/resources/js/group.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
});
</script>
 
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- =============================================================================================== -->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!-- =============================================================================================== -->
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/bootstrap/css/bootstrap.min.css">
<!-- =============================================================================================== -->
	<link rel="stylesheet" type="text/css" href="resources/group_fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!-- =============================================================================================== -->
	<link rel="stylesheet" type="text/css" href="resources/group_fonts/iconic/css/material-design-iconic-font.min.css">
<!-- =============================================================================================== -->
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/animate/animate.css">
<!-- =============================================================================================== -->	
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/css-hamburgers/hamburgers.min.css">
<!-- =============================================================================================== -->
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/animsition/css/animsition.min.css">
<!-- =============================================================================================== -->
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/select2/select2.min.css">
<!-- =============================================================================================== -->	
	<link rel="stylesheet" type="text/css" href="resources/group_vendor/daterangepicker/daterangepicker.css">
<!-- =============================================================================================== -->
	<link rel="stylesheet" type="text/css" href="resources/group_css/util.css">
	<link rel="stylesheet" type="text/css" href="resources/group_css/main.css">
<!-- =============================================================================================== -->



</head>
<body id="groupbody">

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-85 p-b-20">
				<form class="login100-form validate-form">				
					<span class="login100-form-title p-b-70">
						GROUP CREATE
					</span>
					
					<div class="wrap-input100 validate-input m-t-85 m-b-35" data-validate = "Enter groupname">
						<input id = "groupname" mexlength="10" class="input100" type="text" >
						<span class="focus-input100" data-placeholder="GroupName"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-50" data-validate="No Member">
						<input id = "groupid" class="input100" type="text" >
						<span class="focus-input100" data-placeholder="Invite Member"></span>
						<input type="button" id="searchidbt" value="Search ID" data="${Member.getMember_id()}">
						<div id="idlist"></div>						
					</div>
					

					<div class="container-login100-form-btn">
						 <!-- <input type="button" class="login100-form-btn" id="createbt"> 
						
							GROUP CREATE -->
							<input type="button" class="login100-form-btn" id="createbt" value="GROUP CREATE">
					</div>				
				</form>
				
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div> 


 	
<!-- =============================================================================================== -->
	<!-- <script src="resources/group_vendor/jquery/jquery-3.2.1.min.js"></script> -->
<!-- =============================================================================================== -->
	<script src="resources/group_vendor/animsition/js/animsition.min.js"></script>
<!-- =============================================================================================== -->
	<script src="resources/group_vendor/bootstrap/js/popper.js"></script>
	<script src="resources/group_vendor/bootstrap/js/bootstrap.min.js"></script>
<!-- =============================================================================================== -->
	<script src="resources/group_vendor/select2/select2.min.js"></script>
<!-- =============================================================================================== -->
	<script src="resources/group_vendor/daterangepicker/moment.min.js"></script>
	<script src="resources/group_vendor/daterangepicker/daterangepicker.js"></script>
<!-- =============================================================================================== -->
	<script src="resources/group_vendor/countdowntime/countdowntime.js"></script>
<!-- =============================================================================================== -->
	<script src="resources/group_js/main.js"></script>


</body>
</html>
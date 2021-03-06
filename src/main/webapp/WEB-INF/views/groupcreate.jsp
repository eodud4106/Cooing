<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GroupCreate</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="<c:url value="/resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<c:url value="/resources/js/group.js"/>" ></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"></script>

<script>
$(document).ready(function () {
	initialize();
	// 경고!! 절대 아래 코드를 옮기지 마시오!
	if ('${sessionScope.Member}' != '') {
		readyPush('${sessionScope.Member.member_id}', '');
	}
});

</script>
 
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- =============================================================================================== -->	
	<link rel="icon" type="image/png" href="resources/group_images/icons/favicon.ico"/>
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
<script src="resources/js/push.js"></script>
<link rel="stylesheet" href="resources/css/push.css">

</head>
<body id="groupbody">

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-85 p-b-20">
				<form class="login100-form validate-form">				
					<span class="login100-form-title p-b-70">
						GROUP CREATE
					</span>
					
					<div class="wrap-input100 validate-input m-t-85 m-b-35" data-validate = "동일한 그룹명이 존재합니다">
						<input id = "groupname" mexlength="10" class="input100" type="text" >
						<span class="focus-input100" data-placeholder="GroupName"></span>
					</div>

					<div class="wrap-input100  m-b-50" >
						<input id = "groupid" class="input100" type="text" >
						
						<span class="focus-input100" data-placeholder="Invite Member"></span>
						<%-- <input type="button" id="searchidbt" value="Search ID" data="${Member.getMember_id()}"> --%>
						<div style= "z-index:99; float:right;" id="searchidbt" data="${Member.getMember_id()}">
						<i class="fas fa-search" style = "margin-top: -25px; cursor: pointer;"></i></div>
						<div id="idlist"></div>					
					</div>	
												
					
					
					<div class="container-login100-form-btn">
						 <!-- <input type="button" class="login100-form-btn" id="createbt"> 
						
							GROUP CREATE -->
							<input type="button"class="login100-form-btn" id="createbt" value="GROUP CREATE" style="cursor: pointer;">
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
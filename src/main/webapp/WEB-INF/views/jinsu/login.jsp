<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="description"
      content="Maintenance Coming-Soon Page with beautiful and clean design. It's a coming soon HTML Template. Maintenance Coming-Soon Page built with bootstrap framework. It is fully-responsive and W3C Validated. Maintenance Coming-Soon Page come up with 10 ready to use demo">
<meta name="keywords"
      content="maintenance, maintenance mode, template, html template, shapedtheme, shapedplugin, coming-soon, bootstrap, youtube background, slideshow background, animation background, easy under construction page , maintenance coming soon page, kenburns, coming soon, under construction, under construction page, easy coming soon page, responsive coming soon page ">
<meta name="author" content="ShapedTheme">
   
<title>Login</title>

<!-- favicon icon -->
    <link rel="shortcut icon" href="./resources/assets/images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../resources/assets/images/ico/apple-icon-144x144.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../resources/assets/images/ico/apple-icon-114x114.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../resources/assets/images/ico/apple-icon-72x72.png">
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="../resources/assets/images/ico/apple-icon-57x57.png">

    <!-- common css -->
    <link rel="stylesheet" href="../resources/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="../resources/style.css">
    <link rel="stylesheet" href="../resources/assets/css/responsive.css">

    <!-- HTML5 shim and Respond.js IE9 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="assets/js/html5shiv.js"></script>
    <script src="assets/js/respond.js"></script>
    <![endif]-->

<script src="<c:url value="../resources/js_js/jquery-3.2.1.min.js"/>" ></script>
<script>
$(document).ready(function () {
	initialize();
});
function initialize(){
	$('#join').on('click' , joinmember);
}
function joinmember(){
	if(!member_check())
		return false;
	
	$.ajax({
		url:'login_post',
		type:'POST',		
		data:{member_id:$('#id').val() , member_pw:$('#password').val()},
		dataType:"text",
		success: function(a){
			if(a == 'success'){
				//상대 주소로 되어있기에 나중에 절대주소로 바뀌어야 할 듯 하다.
				location.href="../";		
			}
			else{
				alert('ID 혹은 비밀버호가 틀렸습니다.');
			}		
		},
		error:function(e){alert(JSON.stringify(e));}		
	});	
}

function member_check(){	
	if($('#id').val().legnth == 0){
		alert('ID를 입력해 주세요.');
		return false;
	}
	if($('#password').val().length == 0){
		alert('비밀번호를 입력 해주세요.');
		return false;
	}
	
	return true;
}
</script>
<style>
.tb1{
	margin : auto;
}
</style>

</head>
<body class = "img-bg">

<%--  <fieldset>
	<legend><strong>로그인</strong></legend>
	<table>
		<tr><th>ID : </th>	<td><input type="text" id="id" maxlength="10" required autofocus></td></tr>
		<tr><th> 비밀번호 : </th>	<td><input type="password" id="password" maxlength="12" required></td></tr>
		<tr align="right"><td colspan="2"><input type="button" id="join" value="가입">
							<input type="button" onclick="javascript:location.href='<c:url value="/"/>';" value="취소"></td></tr>
	</table>	
</fieldset>  --%>

<!-- home section -->
<section id="home" class="section player">
    <div class="section-container">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2 text-center">
                    <div class="content">
                        <div class="main-content">
                            <!-- <div class="main-logo">
                                <a href="#"><img src="./resources/assets/images/logo.png" alt=""/></a>
                            </div> -->
                            <h1 class="text-uppercase">COOING</h1>
                                                       
                                <div class="subscribe-area text-center">
                                <h3>please login</h3>                              
                            </div>                            

	<table class = "tb1">
		<tr><th>ID  </th><td><input type="text" id="id" maxlength="10" required autofocus class = "form-control"></td></tr>
		<tr><th>PW  </th><td><input type="password" id="password" maxlength="12" required class = "form-control"></td></tr>
		
		<tr align="center"><td colspan="2"><input type="button" id="join" value="로그인">
							<input type="button" onclick="javascript:location.href='<c:url value="/"/>';" value="취소"></td></tr>
	</table>	
	<p>                                            
                           
                        </div>
                        <div class="footer">
                            
                            <div class="footer-right">
                                <p>&copy; 2018 - Maintenance by <a href="cooing.site"> Cooing</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- js files -->
<script type="text/javascript" src="../resources/assets/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../resources/assets/js/bootstrap.js"></script>
<script type="text/javascript" src="../resources/assets/js/jquery.ajaxchimp.js"></script>
<script type="text/javascript" src="../resources/assets/js/pulgins.js"></script>
<script type="text/javascript" src="../resources/assets/js/youtube-bg.js"></script>
<script type="text/javascript" src="../resources/assets/js/scripts.js"></script>

	




</body>
</html>
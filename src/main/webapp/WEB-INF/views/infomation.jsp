<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Infomation</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="http://www.workshop.rs/jqbargraph/styles.css" type="text/css" />
<script type="text/javascript" src="http://www.workshop.rs/jqbargraph/jqBarGraph.js"></script>

<script>
$( function() {
    $( "#datepicker" ).datepicker({
    	 dateFormat: "yy-mm-dd",
    	 dayNamesShort: [ "일", "월", "화", "수", "목", "금", "토" ],
    	 dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
    	 dayNames: [ "일", "월", "화", "수", "목", "금", "토" ],
    	/*  changeYear: true,
    	 changeMonth: true,  // 편하기는 하겠으나 제공해줄 생각 없음*/
    	 maxDate: "-1",
    	 minDate: new Date(2010, 1 - 1, 1),
    	 showOtherMonths: true,
    	 selectOtherMonths:true,
    	 showAnim: "fadeIn",
    	 showMonthAfterYear: true
    	 /* monthNamesShort: [ "Jan", "Feb", "Mar", "Apr", "Maj", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dec" ] //바꿔봤지만 안이쁨*/
  	 });
});
$(document).ready(function() {
	initialize();
});
function initialize(){
	$('#datepicker').on('change' , function(){
		$.ajax({
			url:'searchInfomation',
			type:'POST',		
			data:{searchdate:$('#datepicker').val()},
			dataType:"json",
			success: function(list){
				array = new Array();
				$.each(list,function(i,data){
					var count = 0;
					var word = '';
					$.each(data,function(key,value){
						if(key == 'SEARCH_WORD'){
							word = value;
						}else if(key == 'COUNT'){
							count = value;
						}
					});	
					array[i] = [count , word , '#f3f3f3'];		
				});
				$('#graphdiv').html('');
				$('#graphdiv').jqBarGraph({ 
					data: array,		
					animate: false
				});
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	});
}
</script>
</head>
<body>
Date:<input type="text" id="datepicker">
<div id="graphdiv" style="width:100%;height:100%">
</div>
</body>
</html>
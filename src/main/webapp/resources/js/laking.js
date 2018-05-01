/**
 * 
 */

alert('test');
//달력 부분
$( function() {
  $('#datepicker').datepicker({
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
  $('.ui-datepicker-calendar td').css('padding' , '0px');
});

function initialize(){
	$('#datepicker').on('change' , function(){
		checkRadio();
	});
	$('.input').on('ifChanged' , function(){
		checkRadio(); 
	});
	$('#searchtx').keydown(function(event){
		if(event.keyCode == 13){
			location.href = './?search=' + $('#searchtx').val() + '';
		}
	});
	
	$('.category').on('click' , function(){
		location.href = './category_other?categorynum=' + $(this).attr('data') + '';
	});
	
	$('#friendsearch').keyup(function() {
		searchword();
	});
	
	searchword();
	searchgroup();
}


//좋아요 받아오는 부분
function likesearch(){
	var num = 0;
	//밑 에 부분은 좋아요에 관련된 부분
	if($('#datepicker').val() != null){
		$.ajax({
			url:'searchLike',
			type:'POST',		
			data:{searchdate:$('#datepicker').val()},
			dataType:"json",
			success: function(list){
				array = new Array();
				$.each(list,function(i,data){
					var count = 0;
					var word = '';	
					$.each(data,function(key,value){
						if(key == 'LIKEIT_ALBUMNUM'){
							word = value;
						}else if(key == 'COUNT'){
							count = value;
						}
					});
					num++;
					array[i] = [count , word];						
				});
				graphcreate(array , num);
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}

//검색어 순위 
function searchsearch(){
	var num = 0;
	//밑 에 부분은 검색어에 관련된 부분
	if($('#datepicker').val() != null){
		$.ajax({
			url:'searchInformation',
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
					num++;
					array[i] = [count , word];		
				});
				graphcreate(array,num);				
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}

//카테고리 순위
function categorysearch(){	
	var num = 0;
	//밑에 부분은 카테고리 검색에 관한 부분
	if($('#datepicker').val() != null){
		var vector = ['여행' , '스포츠' , '동물' , '음악' , '음식' , '패션' , '연예' , '게임' , '영화' , '도서'
			, '공연' , '외국어' , '전문지식' , '수집' , '자기계발' , '육아' , '일상생활' , '자동차' , '낚시' , '건강'];
		$.ajax({
			url:'searchCategorypop',
			type:'POST',		
			data:{searchdate:$('#datepicker').val()},
			dataType:"json",
			success: function(list){
				array = new Array();
				$.each(list,function(i,data){
					var count = 0;
					var kind = 0;
					$.each(data,function(key,value){
						if(key == 'KIND'){
							kind = value;
						}else if(key == 'COUNT'){
							count = value;
						}
					});	
					num++;
					array[i] = [count ,vector[kind]];		
				});
				graphcreate(array , num);
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}

//그래프 생성
function graphcreate(array , num){
	var color = ['#f06292' , '#7986cd' , '#4dd0e1' , '#aed581' , '#ffd54f' , '#a1887f' , '#78909c' , '#9575cd' , '#37474f' , '#e51c23']
	$('#graphdiv').html('');
	var width = 100 * num;
	if(width > 1000){
		width = 1000
	}else if(width < 150){
		width = 150;
	}
	$('#graphdiv').jqBarGraph({ 
		data: array,
		animate: false,
		width:width,
		height:550,
		sort:'desc',
		barSpace : 10,
		colors:color
	});
}

//라디오 체크 부분
function checkRadio(){
   var temp;   
   var radioObj = document.all('iCheck');   
   var isChecked;
   if(radioObj.length == null)
   { 
	   // 라디오버튼이 같은 name 으로 하나밖에 없다면
	   isChecked = radioObj.checked;
   }
   else
   { // 라디오 버튼이 같은 name 으로 여러개 있다면
      for(var i=0; i<radioObj.length; i++)
      {
         if(radioObj[i].checked)
         {
            isChecked = true;
            break;
         }
      }
   }

   if(isChecked){
	   temp = radioObj[i].value; 	   
	   //value값
	   switch (temp) {
	      case '1':
	    	 categorysearch(); 
	         break;
	      case '2':
	    	  searchsearch();
	         break;
	      case '3':
	    	 likesearch();
	         break;    
	   }
   }else{
   }	 
}











/**
 * home관련 js
 * 
 */

function initialize(){	
	//초기 친구 찾을 때만 사용했었음
	$('#friendsearch').keyup(function() {
		searchword();
	});
	$('#login').on('click', function() {
		loginmember('');
	});
	$('#searchtx').keydown(function(event){
		if(event.keyCode == 13){
			searchcheck = 99;
			get_album_list('writer','total','date', pagenum++ , 0);
			$('#newcheck').iCheck('check');
		}
	});
	$('.category').on('click' , function(){
		searchcheck = 1;
		$('#categorynum').val($(this).attr('data'));
		$('#newcheck').iCheck('check');
		checkRadioPaging();		
	});
	
	$('.input').on('ifChanged' , function(){
		checkRadioPaging(); 
	 });
	
	$('window').click(function(event) {
		if (event.target == $('#myModal')) {
			$('#myModal').css('display', 'none');
	    }
	});
	
	$('#myBtn').click(function() {
		$('#myModal').css('display', 'block');
	});
	
	$('#myBtn_close').click(function() {
		$('#myModal').css('display', 'none');
	});
		
	searchword();
	searchgroup();
}

function checkRadioPaging(){
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
		    	  if(searchcheck == 0){
			    	  searchcheck = 99;
			    	  get_album_list('writer','total','date',++pagenum, 0);
		    	  }else if(searchcheck == 1){
		    		  searchcheck = 99;
		    		  get_album_list('category' , 'total' , 'data' , ++pagenum , 1);
		    	  }
		         break;
		      case '2':
		    	  if(searchcheck == 0){
		    		  searchcheck = 99;
		    		  get_album_list('writer','total','like', ++pagenum , 0);
		    	  }else if(searchcheck == 1){
		    		  searchcheck = 99;
		    		  get_album_list('category' , 'total' , 'like' , ++pagenum , 1);
		    	  }
		         break;  
		      case '3':
		    	  $('#searchtx').val('');
		    	  $('#searchtx').blur();		    	  
	    		  searchcheck = 99;	
	    		  get_album_list('mylike' , 'total' , 'like' , ++pagenum , 2);
		         break; 
		   }
	   }else{
	   }	 
	}

function openGUpdate(group_name) {
	var url = "groupPage?group_name=" + group_name;  
	location.href=url;
}

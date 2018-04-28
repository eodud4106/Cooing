/**
 * home관련 js
 * 
 */

function initialize(){	
	$('#friendsearchbt').on('click', function() {
		searchfriend();
	});
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
			getTotalAlbumList("3");
		}
	});
	$('.category').on('click' , function(){
		searchcheck = 99;
		searchCategory($(this).attr('data'));
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
	
	if ('${sessionScope.Member}' != null) {
		readyChat('${sessionScope.Member.member_id}', '');
	}	
	searchword();

}

function inputbox_focus(){
	if($('#searchtx').css('width') == '0px'){
		$('#searchtx').val('');
		$('#searchtx').css('width' , '200px');
		$('#searchtx').css('paddingLeft' , '3px');
		$('#searchtx').focus();
	}else if($('#searchtx').css('width') == '200px'){
		$('#searchtx').val('');
		$('#searchtx').css('width' , '0px');
		$('#searchtx').css('paddingLeft' , '0px');
	}
}

function search_bar(search){
	if($('#searchtx').val() == 0){
		$(search).css('width' , '0px');
		$(search).css('paddingLeft' , '0px');
	}
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
	   searchcheck = 99;
	   if(isChecked){
		   temp = radioObj[i].value; 	   
		   //value값
		   switch (temp) {
		      case '1':
		    	  getTotalAlbumList("3"); 
		         break;
		      case '2':
		    	  getTotalAlbumList("2");
		         break;  
		   }
	   }else{
	   }	 
	}

function openGUpdate(group_name) {
	var url = "groupPage?group_name=" + group_name;  
	location.href=url;
}

//앨범 리스트 Ajax로 받는 코드
function getTotalAlbumList(checknum) {
	var check  = false;
	if(searchcheck != 2){
		searchcheck = 2;
		pagenum = 0;
	}
	if(pagenum == 0)
		check  = true;
	var searchtext = $('#searchtx').val();
	$.ajax({
		url: 'searchTotalAlbumList',
		type: 'post',
		data:{pagenum:++pagenum , checknum:checknum , searchtext:searchtext}, 
		dataType: 'json',
		success: function(result) {
			//list 받아오면 리스트 돌려서 처리할 부분
			AlbumListPaging(check , result);
			if(check){
				$.ajax({
					url:'searchTotalCount',
					type:'POST',		
					data:{checknum:checknum}, 
					dataType:'text',
					success: function(list){
						//total count 변경 부분
						$('#totalpage').val(list);
					},
					error:function(e){alert(JSON.stringify(e));}		
				});
			}			
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

function searchCategory(categorynumber){
	$('#searchtx').val('');
	var check  = false;
	if(searchcheck != 1){
		searchcheck = 1;
		pagenum = 0;
	}
	if(pagenum == 0)
		check  = true;
	categorynum = categorynumber;	
	$.ajax({
		url:'searchCategory',
		type:'POST',		
		data:{searchtext:categorynum , pagenum:++pagenum},
		dataType:'json',
		success: function(list){
			//list 받아오면 리스트 돌려서 처리할 부분
			AlbumListPaging(check , list);
			if(check){
				$.ajax({
					url:'searchCategoryCount',
					type:'POST',		
					data:{searchtext:categorynum},
					dataType:'text',
					success: function(list){
						//total count 변경 부분
						$('#totalpage').val(list);
					},
					error:function(e){alert(JSON.stringify(e));}		
				});
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}

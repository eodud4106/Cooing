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
			search();
		}
	});
	$('.category').on('click' , function(){
		searchCategory($(this).attr('data'));
	});
	
	$('.input').on('ifChanged' , function(){
		checkRadioPaging(); 
	 });	
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
		    	  getTotalAlbumList(); 
		         break;
		      case '2':
		    	  getLikeAlbumList();
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
function getTotalAlbumList() {
	var check  = false;
	if(searchcheck != 2){
		searchcheck = 2;
		pagenum = 0;
	}
	if(pagenum == 0)
		check  = true;
	$.ajax({
		url: 'getTotalAlbumList',
		type: 'post',
		data:{pagenum:++pagenum}, 
		dataType: 'json',
		success: function(result) {
			AlbumListPaging(check , result);
			if(check){
				$.ajax({
					url:'searchTotalCount',
					type:'POST',		
					dataType:'text',
					success: function(list){
						//list 받아오면 리스트 돌려서 처리할 부분
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

function getLikeAlbumList() {
	
	alert('??');
	var check  = false;
	if(searchcheck != 4){
		searchcheck = 4;
		pagenum = 0;
	}
	if(pagenum == 0)
		check  = true;
	$.ajax({
		url: 'getLikeAlbumList',
		type: 'post',
		data:{pagenum:++pagenum}, 
		dataType: 'json',
		success: function(result) {
			AlbumListPaging(check , result);
			if(check){
				$.ajax({
					url:'searchLikeCount',
					type:'POST',		
					dataType:'text',
					success: function(list){
						//list 받아오면 리스트 돌려서 처리할 부분
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
						//list 받아오면 리스트 돌려서 처리할 부분
						$('#totalpage').val(list);
					},
					error:function(e){alert(JSON.stringify(e));}		
				});
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}

function search(){
	var check  = false;
	if(searchcheck != 0){
		searchcheck = 0;
		pagenum = 0;
	}	
	if(pagenum == 0)
		check  = true;
	
	var searchtext = $('#searchtx').val();
	if(searchtext.length <= 0){
		searchcheck = 99;
		getTotalAlbumList();
		return false;
	}
	$.ajax({
		url:'searchWord',
		type:'POST',		
		data:{searchtext:searchtext, pagenum:++pagenum},
		dataType:'json',
		success: function(list){
			//list 받아오면 리스트 돌려서 처리할 부분
			AlbumListPaging(check , list);
			if(check){
				$.ajax({
					url:'searchWordCount',
					type:'POST',		
					data:{searchtext:searchtext},
					dataType:'text',
					success: function(list){
						//리스트 숫자를 불러와서 넘겨줘야 한다.
						$('#totalpage').val(list);
					},
					error:function(e){alert(JSON.stringify(e));}		
				});				
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}







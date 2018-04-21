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
	$('#searchtx').keyup(function(){
		
	});
	$('#login').on('click', function() {
		loginmember('');
	});
	$('#searchbt').on('click' , function(){
		search();
	});	
	$('.category').on('click' , function(){
		searchCategory($(this).attr('data'));
	});
}

function openGUpdate(group_name) {
	var url = "groupPage?group_name=" + group_name;  
	location.href=url;
}

//앨범 리스트 Ajax로 받는 코드
function getTotalAlbumList(pagenumber) {
	if(searchcheck != 2){
		pagenumber = 1;
		searchcheck = 2;
		pagenum = 1;
	}
	$.ajax({
		url: 'getTotalAlbumList',
		type: 'post',
		data:{pagenum:pagenumber}, 
		dataType: 'json',
		success: function(result) {
			AlbumListPaging(false , result);
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}

function searchCategory(categorynum , pagenumber){
	var check  = false;
	if(searchcheck != 1){
		pagenumber = 1;
		searchcheck = 1;
		pagenum = 1;
	}
	if(pagenum == 1)
		check  = true;
	$.ajax({
		url:'searchCategory',
		type:'POST',		
		data:{searchtext:categorynum , pagenum:pagenumber},
		dataType:'json',
		success: function(list){
			//list 받아오면 리스트 돌려서 처리할 부분
			AlbumListPaging(check , list);
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}

function search(pagenumber){
	var check  = false;
	if(searchcheck != 0){
		pagenumber = 1;
		searchcheck = 0;
		pagenum = 1;
	}	
	if(pagenum == 1)
		check  = true;
	
	var searchtext = $('#searchtx').val();
	if(searchtext.length <= 0){
		alert(pagenum);
		getTotalAlbumList(++pagenum);
	}
	$.ajax({
		url:'searchWord',
		type:'POST',		
		data:{searchtext:searchtext, pagenum:pagenumber},
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







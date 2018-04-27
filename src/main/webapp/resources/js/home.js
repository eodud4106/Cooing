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
		searchcheck = 99;
		searchCategory($(this).attr('data'));
	});
	
	$('.input').on('ifChanged' , function(){
		checkRadioPaging(); 
	 });

	$(document).click(function (e) {

		e.stopPropagation()

		$('.div_party_popup').remove();
		$('.div_friend_popup').remove();
		
		
		if($(e.target).hasClass('arr_party')) {
			console.log('클릭은 -> ' + e.target.nodeName);
			console.log('클래스는 -> ' + $(e.target).attr('class'));
			createPartyPopup(e, e.target);
		} else if($(e.target).hasClass('friendclick')) {
			console.log('클릭은 -> ' + e.target.nodeName);
			console.log('클래스는 -> ' + $(e.target).attr('class'));
			//TODO  친구 팝업창 띄우기
			createFriendPopup(e, e.target);
		}
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

function createPartyPopup(e, elem) {

	var $div_party_popup = $('<div />', {
		"class": "div_party_popup"
	}).css({
		"position": "absolute",
		"left": e.clientX,
		"top": e.clientY,
		"width": "100px",
		"height": "60px",
		"background-color": "#A9E2F3",
		"z-index": "1000",
		"color": "black"
	}).appendTo($('body'));

	var $div_go_party_page = $('<div />', {
		"class": "div_go_party_page",
		"party_name": $(elem).text(),
		"text": "그룹페이지"
	}).css({
		"width": "100%",
		"height": "50%",
		"display": "block",
		"float": "left"
	}).click(function(e) {
		location.href = "groupPage?group_name=" + $(this).attr('party_name');
	}).appendTo($div_party_popup);

	var $div_go_party_chat = $('<div />', {
		"class": "div_go_party_chat",
		"party_name": $(elem).text(),
		"text": "채팅",
		"party_num": $(elem).attr('partynum')
	}).css({
		"width": "100%",
		"height": "50%",
		"display": "block",
		"float": "left"
	}).click(function(e) {
		openChat(0, $(this).attr('party_num'), $(this).attr('party_name'));
	}).appendTo($div_party_popup);


}

function createFriendPopup(e, elem) {

	var $div_friend_popup = $('<div />', {
		"class": "div_friend_popup"
	}).css({
		"position": "absolute",
		"left": e.clientX,
		"top": e.clientY,
		"width": "100px",
		"height": "60px",
		"background-color": "#A9E2F3",
		"z-index": "1000",
		"color": "black"
	}).appendTo($('body'));

	var $div_go_friend_page = $('<div />', {
		"class": "div_go_friend_page",
		"friend_id": $(elem).attr('id'),
		"text": "친구페이지"
	}).css({
		"width": "100%",
		"height": "50%",
		"display": "block",
		"float": "left"
	}).click(function(e) {
		location.href = "friend_get?id=" + $(this).attr('friend_id');
	}).appendTo($div_friend_popup);

	var $div_go_party_chat = $('<div />', {
		"class": "div_go_friend_chat",
		"friend_id": $(elem).attr('id'),
		"text": "채팅"
	}).css({
		"width": "100%",
		"height": "50%",
		"display": "block",
		"float": "left"
	}).click(function(e) {
		openChat(0, $(this).attr('friend_id'), '');
	}).appendTo($div_friend_popup);


}




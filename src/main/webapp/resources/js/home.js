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
			getTotalAlbumList("3");
		}
	});
	$('.category').on('click' , function(){
		searchcheck = 1;
		$('#categorynum').val($(this).attr('data'));
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
			    	  getTotalAlbumList("3");
		    	  }else if(searchcheck == 1){
		    		  searchcheck = 99;
		    		  searchCategory("3" , $('#categorynum').val());
		    	  }
		         break;
		      case '2':
		    	  if(searchcheck == 0){
		    		  searchcheck = 99;
		    	  	getTotalAlbumList("2");
		    	  }else if(searchcheck == 1){
		    		  searchcheck = 99;
		    		  searchCategory("2" , $('#categorynum').val());
		    	  }
		    	  
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
	if(searchcheck != 0){
		searchcheck = 0;
		pagenum = 0;
	}
	if(pagenum == 0)
		check  = true;
	var searchtext = $('#searchtx').val();
	console.log(searchtext + '_text : test')
	$.ajax({
		url: 'searchTotalAlbumList',
		type: 'post',
		data:{
			pagenum:++pagenum , 
			checknum:checknum , 
			searchword:searchtext
		}, 
		dataType: 'json',
		success: function(result) {
			//list 받아오면 리스트 돌려서 처리할 부분
			AlbumListPaging(check , result);
			if(check){
				$.ajax({
					url:'searchTotalCount',
					type:'POST',		
					data:{
						searchword:searchtext,
						checknum:checknum
					}, 
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

function searchCategory(checknum , categorynumber){
	$('#searchtx').val('');
	var check  = false;
	if(searchcheck != 1){
		searchcheck = 1;
		pagenum = 0;
	}
	if(pagenum == 0)
		check  = true;
	$.ajax({
		url:'searchCategory',
		type:'POST',		
		data:{check:checknum , searchtext:categorynumber , pagenum:++pagenum},
		dataType:'json',
		success: function(list){
			//list 받아오면 리스트 돌려서 처리할 부분
			AlbumListPaging(check , list);
			if(check){
				$.ajax({
					url:'searchCategoryCount',
					type:'POST',		
					data:{check:checknum,searchtext:categorynum},
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

// 검색 타입, 검색 키워드, 정렬 순서, 페이지를 받아 albumlist 조회
function get_album_list(type, keyword, order, page) {
	var check  = false;

	if(page == 0) check  = true;
	
	$.ajax({
		url: 'album/get_album_list',
		type: 'post',
		data:{
			type: type,
			keyword: keyword,
			order: order,
			page: page
		}, 
		dataType: 'json',
		success: function(result) {
			
			// 앨범 스크롤 페이징 처리...
			AlbumListPaging_hindoong(check , result);
			
			if(check){
				$.ajax({
					url:'searchTotalCount',
					type:'POST',		
					data:{
						checknum: 3
					}, 
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

//앨범 리스트 출력
function AlbumListPaging_hindoong(check, result) {
	if (check)
		$('.card-columns').html('');
	$(result).each(function(i, album) {
		
		var $div_card = $('<div />', {
			"class":'card img-loaded div_card',
			"album_num": album.album_num
		}); //카드 클래스 div

		var $img = $('<img />', {
			"src": 'thumbnail?filePath=' + album.album_thumbnail,
			"class": "card-img-top probootstrap-animate div_card",
			"album_num": album.album_num
		}).css({
			"width": "100%",
			"height": "100%",
			"opacity": "1"
		}).appendTo($div_card);
		
		var $info_div = $('<div />', {
			"class": "div_info hidden_info div_card",
			"album_num": album.album_num
		}).appendTo($div_card);
		
		var $p_name = $('<p />', {
			"text": /*"ALBUM " +*/ album.album_name,
			"class": "card_album_name"
		}).appendTo($info_div);
		var $p_writer = $('<p />', {
			"text": /*"ID: " + */album.album_writer,
			"class": "card_album_writer"
		}).appendTo($info_div);
		var $p_contents = $('<p />', {
			"html": /*"<CONTENT><br>" +*/ album.album_contents + "<br>",
			"class": "card_album_contents"
		}).appendTo($info_div);
		if(album.album_contents == null) {
			$p_contents.html("<CONTENT><br>없음<br>")
		}		
		var $span_like = $('<sapn />', {
			"html": "❤",
			"class": "card_album_likes"
		}).css({
			"color":"#FF0000"			
		}).appendTo($info_div);
		
		var $span_likecount = $('<sapn />', {
			"html": album.like_count + "<br>",
			"class": "card_album_likes"
		}).appendTo($info_div);
		
		var $p_reply = $('<p />', {
			"html": "댓글 :" + album.reply_count,
			"class": "card_album_contents"
		}).appendTo($info_div);
		
		// 마우스 엔터
		$div_card.mouseenter(function(e) {
			var $div_overlay = $('<div />', {
				"class": "go_back"
			}).appendTo($(this));
			$info_div.removeClass('hidden_info').addClass('go_front');
		}).mouseleave(function(e) {
			$('.go_back').remove();
			$info_div.removeClass('go_front').addClass('hidden_info');
		})
		
		$('.card-columns').append($div_card);
	});
	
	$('.div_card').click(function(e) {
		location.href = 'albumView?album_num='+$(this).attr('album_num');
	});
	pagingcheck = false;
}

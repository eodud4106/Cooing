/**
 * 그룹 페이지 관련 js
 */

// 그룹 앨범리스트 받을 때 사용
var pagenum = 0;

function initialize(){
	$('#findid').keyup(searchgroupmember);
	$('#gmemberplus').on('click',memberplus);
	$('.img_3').on('click',memberdelete);
	$('#desolve').on('click',deleteparty);
}

function confirmcheck(strque){
	var check = confirm(strque);
	if(check)
		return true;
	else
		return false;
}

function deleteparty(){
	if(confirmcheck('그룹을 삭제 하시겠습니까?') == false) {
		return false;
	}
	//그룹 탈퇴 확인		
	var party_num = $('#desolve').attr('data');
	$.ajax({
		url:'delete_party',
		type:'POST',		
		data:{partynum:party_num},
		dataType:'text',
		success: function(list){
			if(list=='success'){
				location.href="./";
			}else{
				alert(list);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}

function memberdelete(){	
	if(confirmcheck('그룹 멤버를 삭제 하시겠습니까?') == false) {
		return false;
	}
	var member_id = $(this).attr('data');
	var party_num = $(this).attr('data2');
	$.ajax({
		url:'delete_member',
		type:'POST',		
		data:{memberid:member_id,partynum:party_num},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				$.ajax({
					url:'member_list_post',
					type:'POST',		
					data:{partynum:party_num},
					dataType:'json',
					success: function(list){
						$.each(list,function(i,data){
							var $p = $('<p />');
							var $img = $('<img />', {
								"class": "img-responsive img-circle",
								"src": './memberimg?strurl=' + data.member_picture==null? '':data.member_picture
							}).css({
								"border-radius": "80%",
								"display": "inline-block",
								"width": "100%",
								"max-width": "25%",
								"height": "auto"
							}).appendTo($p);
							//뭐지?? data.member_id
							if(data.member_id  != $('#sessionid').attr('data') ) {
								var $div = $('<div />', {
									"class": "img_3",
									"data": data.member_id,
									"data2": party_num
								}).css({
									"z-index": "99",
									"float": "right",
									"margin-top": "-29px"
								}).appendTo($p)
								var $i = $('<i />', {
									"class": "fas fa-user-times"
								}).appendTo($div)
							}
							$('#memberdiv').append($p);
						});
						$('#findid').val('');
						$('.img_3').on('click',memberdelete);
					},
					error:function(e){alert(JSON.stringify(e));}		
				});
			}else{
				alert(a);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function memberplus(){	
	var member_id = $('#findid').val();
	var party_num = $('#desolve').attr('data');
	if(confirmcheck(member_id + '를 그룹 멤버로 초대 하시겠습니까?') == false) {
		return false;
	}
	$.ajax({
		url:'party_member_input',
		type:'POST',		
		data:{groupmember:member_id,partynum:party_num},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				$.ajax({
					url:'member_list_post',
					type:'POST',		
					data:{partynum:party_num},
					dataType:'json',
					success: function(list){

						$.each(list,function(i,data){
							
							var $p = $('<p />');
							var $img = $('<img />', {
								"class": "img-responsive img-circle",
								"src": './memberimg?strurl=' + data.member_picture==null? '':data.member_picture
							}).css({
								"border-radius": "80%",
								"display": "inline-block",
								"width": "100%",
								"max-width": "25%",
								"height": "auto"
							}).appendTo($p);
							//뭐지?? data.member_id
							if(data.member_id  != $('#sessionid').attr('data') ) {
								var $div = $('<div />', {
									"class": "img_3",
									"data": data.member_id,
									"data2": party_num
								}).css({
									"z-index": "99",
									"float": "right",
									"margin-top": "-29px"
								}).appendTo($p)
								var $i = $('<i />', {
									"class": "fas fa-user-times"
								}).appendTo($div)
							}
							$('#memberdiv').html(p);
						});
						$('#findid').val('');
						$('.img_3').on('click',memberdelete);				
					},
					error:function(e){alert(JSON.stringify(e));}		
				});				
			}else{
				alert(a);
			}
		},
		error:function(e){alert(JSON.stringify(e));}		
	});
}
function searchgroupmember(){
	var text = $('#findid').val();
	if(text.length >= 1){
		$.ajax({
			url:'search_id_check',
			type:'POST',		
			data:{text:text},
			dataType:'json',
			success: function(array){
				$('#findid').autocomplete({
					source:array 
				});
			},
			error:function(e){alert(JSON.stringify(e));}		
		});
	}
}

//그룹 이름을 넘겨주기 위한 js에서 새로 만들어 봐야 된다 
//검색 타입, 검색 키워드, 정렬 순서, 페이지를 받아 albumlist 조회
function get_group_album_list(type , writer_type , groupid , order, page , checknum) {
	var check  = false;
	if(searchcheck != check){ 
		searchcheck = check;
		page = 0;
	}

	if(page == 0){ 
		check  = true;
		total = true;
	}
	
	var keyword;
	if(checknum == 1)
		keyword = $('#categorynum').val();
	else if(checknum == 0)
		keyword = $('#searchtx').val();
	$.ajax({
		url: 'album/get_album_list',
		type: 'post',
		data:{
			type:type,
			writer_type: writer_type,
			keyword: keyword,
			order: order,
			page: page,
			userId:groupid
		}, 
		dataType: 'json',
		success: function(result) {
			if(JSON.stringify(result) == '[]') {
				total = false;
			} else {
				total = true;
			}
			// 앨범 스크롤 페이징 처리...
			AlbumListPaging_hindoong(check , result);			
		},
		error: function(e) {
			alert(JSON.stringify(e));	
		}
	});
}






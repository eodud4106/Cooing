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
						});
						$('#memberdiv').append($p);
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
//function memberplus(){
//	
//	var member_id = $('#findid').val();
//	var party_num = $('#desolve').attr('data');
//	if(confirmcheck(member_id + '를 그룹 멤버로 초대 하시겠습니까?') == false) {
//		return false;
//	}
//	$.ajax({
//		url:'party_member_input',
//		type:'POST',		
//		data:{groupmember:member_id,partynum:party_num},
//		dataType:'text',
//		success: function(a){
//			if(a=='success'){
//				$.ajax({
//					url:'member_list_post',
//					type:'POST',		
//					data:{partynum:party_num},
//					dataType:'json',
//					success: function(list){
//						var strmember='';
//						$.each(list,function(i,data){
//							strmember += '<p><img class = "img-responsive img-circle" style ="'
//								+'border-radius: 80%; display: inline-block;; width: 100% \9;max-width: 25%; height: auto;"'
//								+ 'src = "./memberimg?strurl='+ data.member_picture==null?'':data.member_picture +'">'+ data.member_id;
//							if(data.member_id  != $('#sessionid').attr('data') )
//								strmember +='<div style= "z-index:99; float:right;margin-top: -29px;' 
//									+ '"class = "img_3" data="'+data.member_id+'" data2="'+party_num+'">'
//									+ '<i class="fas fa-user-times" ></i></div>';	
//						});
//						$('#memberdiv').html(strmember);
//						$('#findid').val('');
//						$('.img_3').on('click',memberdelete);				
//					},
//					error:function(e){alert(JSON.stringify(e));}		
//				});				
//			}else{
//				alert(a);
//			}
//		},
//		error:function(e){alert(JSON.stringify(e));}		
//	});
//}
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

//앨범 리스트 Ajax로 받는 코드
function getPartyAlbumList() {
	var check  = false;
	if(pagenum == 0)
		check  = true;
	$.ajax({
		url: 'album/getPartyAlbumList',
		type: 'post',
		data:{
			pagenum: ++pagenum,
			party_name: $('#party_name').text()
		}, 
		dataType: 'json',
		success: function(result) {
			//list 받아오면 리스트 돌려서 처리할 부분
			console.log('안 -> ' + JSON.stringify(result));
			AlbumListPaging(check , result);
			if(check){
				$.ajax({
					url:'album/getPartyAlbumCount',
					type:'POST',		
					data:{party_name: $('#party_name').text()},
					dataType:'text',
					success: function(list){
						//카운트 개수 불러와서 처리
						console.log("list -> " + list)
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

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
	if(confirmcheck('그룹탈퇴를 하시겠습니까?') == false) {
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
						var strmember='';
						$.each(list,function(i,data){
							strmember += '<p><img class = "img1" src = "./memberimg?strurl='+(data.member_picture==null?'':data.member_picture)	+'"></p><p>'+ data.member_id;
							if(data.member_id  != $('#sessionid').attr('data') )
								strmember +='<img src = "./resources/image_mj/remove.png" class = "img_3" data="'+data.member_id+'" data2="'+party_num+'">';	
						});
						$('#memberdiv').html(strmember);
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
						var strmember='';
						$.each(list,function(i,data){
							strmember += '<p><img class = "img1" src = "./memberimg?strurl='+(data.member_picture==null?'':data.member_picture)	+'"></p><p>'+ data.member_id;
							if(data.member_id  != $('#sessionid').attr('data') )
								strmember +='<img src = "./resources/image_mj/remove.png" class = "img_3" data="'+data.member_id+'" data2="'+party_num+'">';	
						});
						$('#memberdiv').html(strmember);
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
			console.log('안 -> ' + JSON.stringify(result));
			AlbumListPaging(check , result);
			if(check){
				$.ajax({
					url:'searchTotalCount',
					type:'POST',		
					dataType:'text',
					success: function(list){
						//list 받아오면 리스트 돌려서 처리할 부분
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
	
	// 그룹 앨범 만드기...
	function create_group_album() {
		$.ajax({
			url: 'create_album',
			type: 'post',
			data: {
				party_name: '${partyinfo.party_name}',
				isPersonal: 0
			},
			dataType: 'json',
			success: function(result) {
				if(result == 'user null') {
					alert('로그인 정보 없음!');
				} else if(result == 'fail') {
					alert('오류 발생!!');
				} else {
					 //TODO 앨범 편집창으로 이동
					 location.href="edit_album?album_num=" + result;
				}
			},
			error: function(e) {
				alert(JSON.stringify(e));	
			}
		});
	}
}
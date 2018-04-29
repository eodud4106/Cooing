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

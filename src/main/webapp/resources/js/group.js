/**
 *  그룹 관련 js
 */

function initialize(){
	$('#searchidbt').on('click' ,searchgroupfriend);
	$('#groupid').keyup(searchgroupid);
	$('#groupname').keyup(searchgroupname);
}

function searchgroupname(){
	var input = $('.validate-input .input100');
	var thisAlert = $(input).parent();
	var name = $('#groupname').val();
	if(name.length > 0){
		$.ajax({
			url:'party_search_name',
			type:'POST',		
			data:{groupname:name},
			dataType:'text',
			success: function(a){
				if(a == 'success'){
					$('#createbt').off();
					$('#createbt').on('click' , creategroup);
					$(thisAlert).removeClass('alert-validate');
					//$('#groupbody').css('background-color','#00ff00');
				}
				else{
					$('#createbt').off();
					//$('#groupbody').css('background-color','#ff0000');	
					 $(thisAlert).addClass('alert-validate');
					 
				}
			},
			error:function(e){
				//alert(JSON.stringify(e));
			}		
		});
	}	
}

function creategroup(){

	var name = $('#groupname').val();
	
	if (name.length > 10) {
		alert('그룹명은 10자 이내로 입력하세요.');
		return false;
	}
	
	var create_group = confirm('그룹을 생성하시겠습니까?');
	
	if(create_group == false) {
		return false;
	}

	if(name.length > 0){
		$.ajax({
			url:'party_create',
			type:'POST',		
			data:{groupname:name},
			dataType:'text',
			success: function(a){
				if(a != '-1'){
					var idlist = $('#idlist').text();
					if(idlist.length > 0){
						
						var arr_member_id = idlist.match(/[a-z0-9]{1,15}/g);
						
						for (var i = 0; i < arr_member_id.length; i++) {
							sendPush(name, arr_member_id[i], 2, '우리 파티에 오세요!!');
						}
						
						alert('그룹을 만들고 초대장을 보냈습니다!')
						opener.location.href="./groupPage?group_name="+name;
						window.close();

					}
					else{
						opener.location.href="./groupPage?group_name="+name;
						window.close();
					}
				}
				else{
					alert('그룹 생성을 실패했습니다. 잠시 후 다시 시도해 주십시오.');
				}
			},
			error:function(e){/*alert(JSON.stringify(e));*/}		
		});
	}	
}

function searchgroupfriend(){
	var text = $('#groupid').val();
	var id = $('#searchidbt').attr('data');
	$.ajax({
		url:'friend_check',
		type:'POST',		
		data:{id:text},
		dataType:'text',
		success: function(a){
			if(a=='success'){
				var check = true;
				var idlist = $('#idlist').html();
				var strarray = idlist.split(' ');
				for(var i = 0; i < strarray.length; i++){
					if(strarray[i] == text){
						check = false;
					}
				}
				if(id == text){
					check = false;
				}
				if(check){
					$('#idlist').append(text + ' ');
					$('#groupid').val('');
				}
			}
			else{
				alert("찾으시는 ID의 회원이 없습니다.");
			}
		},
		error:function(e){/*alert(JSON.stringify(e));*/}		
	});
	$('#groupid').val('');
}
function searchgroupid(){
	var text = $('#groupid').val();
	if(text.length >= 1){
		$.ajax({
			url:'search_allid',
			type:'POST',		
			data:{text:text},
			dataType:'json',
			success: function(array){
				$('#groupid').autocomplete({
					source:array 
				});
			},
			error:function(e){/*alert(JSON.stringify(e));*/}		
		});
	}
}
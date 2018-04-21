/**
 * 그룹 페이지 관련 js
 */

function initialize(){
	$('#findid').keyup(searchword);
	$('#gmemberplus').on('click',memberplus);
	$('.img_3').on('click',memberdelete);
	$('#desolve').on('click',deleteparty);
}
function deleteparty(){
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
							strmember += '<p><img class = "img1" src = "./jinsu/memberimg?strurl='+(data.member_picture==null?'':data.member_picture)	+'"></p><p>'+ data.member_id;
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
	var party_num = $('#gmemberplus').attr('data');
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
							strmember += '<p><img class = "img1" src = "./jinsu/memberimg?strurl='+(data.member_picture==null?'':data.member_picture)	+'"></p><p>'+ data.member_id;
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
function searchword(){
	var text = $('#findid').val();
	if(text.length >= 1){
		$.ajax({
			url:'jinsu/search_id',
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
/**
 *  친구 / 그룹을 클릭했을 때 팝업메뉴를 보여주는 데에 쓰입니다..
 */
$(document).ready(function() {
	$(document).click(function (e) {

		e.stopPropagation()

		$('.div_party_popup').remove();
		$('.div_friend_popup').remove();
		
		
		if($(e.target).hasClass('arr_party')) {
			createPartyPopup(e, e.target);
		} else if($(e.target).hasClass('arr_friend')) {
			createFriendPopup(e, e.target, 'friend');
		} else if($(e.target).hasClass('arr_user')) {
			createFriendPopup(e, e.target, 'user');
		}
	});
})


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

function createFriendPopup(e, elem, type) {

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
		"friend_id": $(elem).attr('friend_id')
	}).css({
		"width": "100%",
		"height": "50%",
		"display": "block",
		"float": "left"
	}).click(function(e) {
		location.href = "friend_get?id=" + $(this).attr('friend_id');
	}).appendTo($div_friend_popup);
	
	if(type == 'friend') {
		$div_go_friend_page.text('친구페이지');
	} else if (type == 'user') {
		$div_go_friend_page.text('유저페이지');
	}

	var $div_go_friend_chat = $('<div />', {
		"class": "div_go_friend_chat",
		"friend_id": $(elem).attr('friend_id'),
		"text": "채팅"
	}).css({
		"width": "100%",
		"height": "50%",
		"display": "block",
		"float": "left"
	}).click(function(e) {
		openChat(1, $(this).attr('friend_id'), '');
	}).appendTo($div_friend_popup);

}
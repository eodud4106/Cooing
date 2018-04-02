/**
 * 채팅 관련 메소드 모음
 */

function openPChat(friend_id, toRoot) {
	var url = toRoot + "chat?friend_id=" + friend_id;  
	window.open(url, '_blank', 'width=700, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no' );
}
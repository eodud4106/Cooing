// [start] 맵을 쓰기 위한 코드
Map = function(){
    this.map = new Object();
};   
Map.prototype = {   
    put : function(key, value){   
        this.map[key] = value;
    },   
    get : function(key){   
        return this.map[key];
    },
    containsKey : function(key){    
        return key in this.map;
    },
    containsValue : function(value){    
        for(var prop in this.map){
            if(this.map[prop] == value) return true;
        }
        return false;
    },
    isEmpty : function(key){    
        return (this.size() == 0);
    },
    clear : function(){   
        for(var prop in this.map){
            delete this.map[prop];
        }
    },
    remove : function(key){    
        delete this.map[key];
    },
    keys : function(){   
        var keys = new Array();   
        for(var prop in this.map){   
            keys.push(prop);
        }   
        return keys;
    },
    values : function(){   
        var values = new Array();   
        for(var prop in this.map){   
            values.push(this.map[prop]);
        }   
        return values;
    },
    size : function(){
        var count = 0;
        for (var prop in this.map) {
            count++;
        }
        return count;
    }
};
// [end] 맵을 쓰기 위한 코드


// 전역 변수 선언
var map_box = new Map();    //box를 담을 map

//TODO db에서 박스를 여러 개 가지고 온 경우 || '${arr_box.length}'-1 처럼 숫자를 넣어두기....
var $arr_div_box = [];      // 텍스트, 이미지 등의 박스를 담을 배열
var arr_box_id = [];        //div_box의 id를 담을 jquery 배열
var album_top = 0;          //앨범의 top
var album_left = 0;         //앨범의 left

var PAGE_WIDTH = 600;       // 페이지 당 너비
var PAGE_HEIGHT = 650;      // 페이지 당 높이

var curr_page = 1;

var arr_color = ["#FF0000", "#FF5E00", "#FFBB00", "#FFE400", "#ABF200",
     "#1DDB16", "#00D8FF", "#0100FF", "#5F00FF", "#FF00DD", 
     "#FFD9FA", "#B2CCFF", "#FFC6FF", "#D9E5FF", "#FAECC5", 
    "#FFC19E", "#D5D5D5", "#000000", "#FFFFFF", "rgba(0,0,0,0)"];

var arr_size = ["xx-small", "x-small", "small", "medium", "large", "x-large", "xx-large"];

//자식창 닫혔을 때 감지
var curTime;
function child_close(){

	var changedSrc = $('#'+curTime).attr('src');
	var check_changedSrc = $('#'+curTime).attr('src').substring(0,5);
	if(check_changedSrc == 'data:'){
		$.ajax({
			type: "POST",
			url: "croped_picture_save",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			data: { "imgUrl": changedSrc },
			success : function(fath) {
				$('.onSelect img').attr('src', 'img_album?filePath='+fath);
	        }, 
	        error : function(e) { 
	            alert(JSON.stringify(e)); 
	        } 
		});

	}
}

// [start] 페이지 로딩 후 앨범 준비
function ready_album(mode) {
    //TODO 앨범 로딩...
	
	if(mode == 'view') {
		
		$('#album').css("display", "block");
		// 앨범 flip 효과 적용
	    $('#album').turn({
	        display: 'double',  // 한 번에 보여줄 페이지
	        inclination: 50,    // 페이지 넘김 효과 시의 경사도
	        width: PAGE_WIDTH * 2,
	        height: PAGE_HEIGHT,
	        when:{
	        	turned: function(event, page, view) {
	        		bookmark_check();
	        	}
	        }
	    });
		
	} else if (mode == 'edit') {
		
		if($('#album').children('.page').length == 0) {
	    	// 앨범 로딩 결과 없음
	    	createNewAlbum();
	    } else {
	    	// 로딩된 앨범 있음
	    	
	    	// 페이지 별 div_box에 편집 기능 적용
	    	$('#album').children('.page').each(function(i, page) {	
	    		$(page).children('.div_box').each(function(j, div_box) {
	    			apply_event_to_box($(div_box));
	    		})
	    	})
	    }
	    
	    $('#album').css("display", "block");

	    // 캔버스에 아이템 드랍 시 이벤트 처리
	    apply_page_droppable($('.page'));

	    // 앨범 flip 효과 적용
	    $('#album').turn({
	        display: 'double',  // 한 번에 보여줄 페이지
	        inclination: 50,    // 페이지 넘김 효과 시의 경사도
	        width: PAGE_WIDTH * 2,
	        height: PAGE_HEIGHT,
	        when: {             // 이벤트 리스너
	            turning: function(event, page, view) {
	                // 편집창 제거
	                removeEdit();
	                // onEdit, onSelect 상태인 박스가 있다면 클래스 삭제, 효과 초기화, z-index 조정
	                clearOn();
	                // page 저장
	                savePage('curr');

	            },
	            turned: function(event, page, view) {

	                console.log('현재 페이지 -> ' + $('#album').turn('page'));

	                var total_page = $('#album').turn('pages');

	                var arr_single_page = [1, total_page];

	                curr_page = $('#album').turn('page');

	                // 첫페이지와 끝페이지가 아니고, 홀수 번째(오른쪽 페이지) 페이지일 경우 1을 줄여서 왼쪽 페이지를 가리키게 함.
	                if(arr_single_page.indexOf(curr_page) == -1 && curr_page % 2 == 1) {
	                    curr_page--;
	                }

	                // 모든 페이지의 droppable을 끄고 현재 보여지는 페이지만 droppable을 켠다.
	                $('.page').droppable("disable");
	                $('#page' + curr_page + '').droppable("enable");
	               
	                if(curr_page != 1){ 
	            	   $('#page' + curr_page + '').css('border-right' , '1px solid black');
	            	   $('#page' + curr_page + '').css('box-shadow' , 'rgb(134, 142, 150) 1px -1px 1px 1px inset');	            	   
	            	   $('#page' + (curr_page + 1) + '').css('border-left' , '1px solid black');
	            	   $('#page' + (curr_page + 1) + '').css('box-shadow' , 'rgb(134, 142, 150) -1px -1px 1px 1px inset');
	                }
	                
	                // 현재 페이지가 싱글 페이지가 아닌 경우 오른쪽 페이지도 droppable을 켠다.
	                if(arr_single_page.indexOf(curr_page) == -1) {
	                    $('#page' + (curr_page + 1) + '').droppable("enable");
	                }
	                
	            }
	        } 
	    });




	    album_top = $('#album').position().top + Number($('#album').css('margin-top').replace('px',''));
	    album_left = $('#album').position().left + Number($('#album').css('margin-left').replace('px',''));

	    // .tool을 드래그할 경우 드래그한 element를 복제한 helper 생성
	    // (캔버스 위에 생성되는 textbox는 helper 속성을 물려받는다.)
	    $(".tool").draggable({
	        helper: "clone"
	    });
	  

	    // 편집창이 아닌 곳 클릭하면.... 효과 해제해버림...
	    $('body').mousedown(function(e) {
	        //e.stopPropagation();

	        //$('#title').text(e.target.nodeName);

	        if(!$(e.target.parentNode.parentNode).hasClass('edit')) {

	            // 편집창 제거
	            removeEdit();

	            // onEdit, onSelect 상태인 박스가 있다면 클래스 삭제, 효과 초기화, z-index 조정
	            clearOn();
	        }
	    })

	    // 백스페이스 누를 시 onSelect 박스 삭제!!!!
	    $('body').keydown(function(e){
	        // 백스페이스 keyCode == 8
	        if(e.keyCode == '8') {

	            remove_box();
	        }
	    })
	} else {
		alert('설정 오류!');
	}
	
	slider();
	
	create_tooltip_of_under_tool();

}
// [end] 페이지 로딩 후 앨범 준비


/**
 *  새 앨범 기본 페이지 설정
 **/
function createNewAlbum() {

    // 최초 페이지 수
    var init_page = 12;

    // 페이지 생성 후 album div에 부착
    for(var i = 1; i <= init_page; i++) {
        var $page = $('<div />', {
            'id': 'page' + i,
            'class': 'page hard'
        });

        $page.appendTo('#album');
    }
}

/**
 *  페이지에 아이템 droppable 적용
 *  @param : jquery 형식의 page 엘리먼트
 **/
function apply_page_droppable($page) {

    $page.droppable({
        accept: '.tool',
        drop: function(event, ui) {

            event.stopPropagation();

            // 드랍한 페이지
            var page = $(this).attr('id').replace(/\D/g,'');
            // 드랍된 페이지 알기 위한 변수(대영)
            droppable_page = page;

            // 드랍으로 만든 node를 page 위에 그림
            renderbox(event, ui, page);
        }
    });
}

//TODO page 비우기
function initpage($page) {
	$page.empty();
}


/**
 *  [start] 텍스트 박스를 캔버스에 추가
 *  @param : (좌표가 포함된 이벤트, 드래그 드랍한 박스, 드랍한 페이지)
 **/

//배경 지울 때 드랍된 페이지 저장변수(대영)
var droppable_page;
function renderbox(event, ui, page) {

    // 클릭한 페이지의 위치 확인
    var curr_page_top = album_top;
    var curr_page_left = album_left;
    if(page % 2 == 1) {
        // 드랍한 페이지가 홀수 페이지일 경우 우측에 위치하므로 왼쪽 페이지의 너비만큼 더해준다.
        curr_page_left += PAGE_WIDTH;
    }

    // 위치, 크기 조절 이벤트 적용할 div_box
    // box 드래그, 리사이즈 초기화
    var $div_box = $('<div />', {
        'id' : 'box_' + $arr_div_box.length,
        'class' : 'div_box'
    });

    // node의 타입별 textfield 기본 폰트 크기 지정
    if(ui.helper.hasClass("text")) {
        // 텍스트 박스인 경우
        $div_box.addClass('textbox').text('입력하세요.....!').css({
            "position": "absolute",
            "top": event.pageY - curr_page_top - 30,
            "left": event.pageX - curr_page_left - 50
        });

    }    
    //배경 지우기
    else if(ui.helper.hasClass("remove")) {
    	$('#page' + droppable_page).css('background-image', '');
    }
    //이미지인 경우
    else if(ui.helper.hasClass("image")) {
        var $i_plus = $('<i />', {
            "class": "fas fa-image",
            "position": "absolute",
            "top": "140px",
            "left": "140px"
        });

        var $image = $('<img />', {
            "width": "100%",
            "height": "100%"
        }).css({
            "display": "none"
        });
        
        $div_box.addClass('imagebox').css({
            "width": "300px",
            "height": "300px",
            "font-size": "xx-large",
            "text-align": "center",
            "line-height": "8"
        }).append($i_plus).append($image).css({
            "position": "absolute",
            "top": event.pageY - curr_page_top - 130,
            "left": event.pageX - curr_page_left - 150
        });

    }

    $div_box.appendTo($('#page' + page + ''));

    apply_event_to_box($div_box, curr_page_top, curr_page_left);


}
// [end] 텍스트 박스를 캔버스에 추가

/**
 * [start] 박스에 이벤트 추가
 * @param $div_box
 */ 
function apply_event_to_box($div_box, curr_page_top, curr_page_left) {
	
    $arr_div_box.push($div_box);


    $div_box.draggable({
        // textbox 드래그 시 위치 이동 처리 (ui.helper는 이벤트의 대상)
        drag: function(event, ui) {
            $('.div_whole_editor').css({
                "display": "none"
            });
        },
        stop: function(event, ui) {
            $('.div_whole_editor').css({
                "display": "block",
                "top": $('.onSelect').position().top + curr_page_top - 50,
                "left": $('.onSelect').position().left + curr_page_left
            });
            var over_left = $(window).width() - Number($('.div_whole_editor').css('left').replace('px', '')) - 350;
            if(over_left < 0) {
            	$('.div_whole_editor').css('left', $('.onSelect').position().left + curr_page_left + over_left)
            }
        },
        containment: $div_box.parent()  // 캔버스 영역 밖으로 나가지 못하게 제한

    }).resizable({

        containment: $div_box.parent(), // 캔버스 영역을 넘지 못하도록 제한
        disabled: true          // 리사이즈는 onSelect 상태인 박스만 가능하므로.. 초기 설정에는 disable

    });

    //page에 box 출력
    $div_box.find(".ui-resizable-handle").hide();
    
    // z-index 관리용 코드
    arr_box_id.push($div_box.attr('id'));
    $div_box.css({
        "z-index": 500 + arr_box_id.indexOf($div_box.attr('id'))
    })
    //$('#selection').text(arr_box_id);

    // textbox 마우스 다운 시 크기 조절 모드 + 전역 편집 모드
    $div_box.mousedown(function(e) {
        //이벤트 bubble 제거
        e.stopPropagation();

        // 클릭한 대상이...
        if($div_box.hasClass('onEdit')) {
            // 뭐하지?????
        } else if ($div_box.hasClass('onSelect')) {
            // 선택 중인 박스였다면... 무얼 할까??
        } else {
            // 아무 것도 아닌 박스였다면... 수정 중/선택 중인 다른 박스 모두 해제하고... 클릭한 대상에게 선택 중 효과 적용..
            clearOn();

            $div_box.draggable('enable').resizable('enable')
                .addClass('onSelect').find(".ui-resizable-handle").show();
            
            removeEdit();
            createWholeEditor($div_box);
        }

    }).dblclick(function(e){
        //textbox 더블클릭 시 텍스트 입력 + 선택 편집 모드로 전환(TODO 텍스트 입력에 따라 높이 자동 조절되도록, 너비는 직접 수정)

        //이벤트 bubble 제거
        e.stopPropagation();

        removeEdit();

        // 텍스트박스일 경우만 적용
        if ($div_box.hasClass('textbox')) {

            // textbox 드래그 끔, 리사이즈 켬, 수정 중 css 적용
            $div_box.draggable('disable').resizable('disable').removeClass('onSelect').addClass('onEdit')
                .find(".ui-resizable-handle").hide();

            // textfiled를 수정 가능하게 변경
            $div_box.prop("contenteditable", true);
        }

    }).mouseup(function(e) {
        // 마우스 업 이벤트 시 텍스트편집창 띄울 것인지 판단

        // 클릭한 대상이...
        if($div_box.hasClass('onEdit')) {
            // 수정 중인 박스였다면 부분 옵션창을 켠다.
            removeEdit();
            isTextboxHighlighted();

        } else if ($div_box.hasClass('onSelect')) {
            // 선택 중인 박스였다면... 무얼 할까??

        } else {
            // 아무 것도 아닌 박스였다면...?? 

        }

    });
}
// [end] 박스에 이벤트 추가

// 텍스트 선택 시 텍스트 상단에 편집창 팝업
function isTextboxHighlighted(e) {

    var sel = window.getSelection();

    if(sel.rangeCount > 0) {
        var range = sel.getRangeAt(0);
        var clientRects = range.getClientRects();
        if(clientRects.length > 0 && sel.toString().length > 0) {
            createTextEditor(clientRects[0].top, (clientRects[0].right + clientRects[0].left)/2 );
        }
    }
}


// [start] 1단계 편집창 생성
function createWholeEditor($div_box) {

    var $arr_bt = [];

    // 텍스트 박스 전용 버튼
    if($div_box.hasClass('textbox')) {
        // 글자 크기
        $arr_bt.push($('<button />', {
            "id": "bt_size",
            "text": "글자크기"
        }));
        
        // 글꼴
        $arr_bt.push($('<button />', {
            "id": "bt_font",
            "text": "글꼴"
        }));
        $arr_bt[$arr_bt.length - 1].mouseenter(function() {
            if($('.div_font').css('display') == 'none') {
                $('.div_font').css('display', 'block');
            }
        });
        
        // 글자 색
        $arr_bt.push($('<button />', {
            "id": "bt_color",
            "text": "글자색"
        }));
        
        // 배경 색
        $arr_bt.push($('<button />', {
            "id": "bt_bcolor",
            "text": "배경색"
        }));

        // 내부 효과 제거
        $arr_bt.push($('<button />'));
        var $i_ban = $('<i class="fas fa-ban"></i>');
        $arr_bt[$arr_bt.length-1].append($i_ban).click(function() {
            $('.onSelect').prop("contenteditable", true).css({
                "-webkit-user-select": "text",
                "user-select": "text"
            }).focus();
            document.execCommand('selectAll', false, null);
            document.execCommand('removeFormat', false, null);
            $('.onSelect').prop("contenteditable", false).css({
                "-webkit-user-select": "",
                "user-select": ""
            })
            $('.onSelect').css({
                "font-size": "medium",
                "color": "#859196",
                "background-color": "rgba(255,255,255,0)"
            })
        }).mouseenter(function(e) {
            createTooltip($(this), '효과제거');
        }).mouseleave(function(e) {
            $('.tooltip').remove();
        });
    }

    // 이미지 박스 전용 버튼
    else if($div_box.hasClass('imagebox')) {
        // 사진 추가
        $arr_bt.push($('<button />'));
        var $i_plus = $('<i class="fas fa-plus"></i>');
        var $input_file = $('<input />', {
            "type": "file",
            "accept": "image/*",
            "id": "hidden_input",
            "name": "hidden_input"
        }).css({
            "position": "absolute",
            "top": "0px",
            "left": "0px",
            "width": "50px",
            "height": "40px",
            "margin": "auto",
            "opacity": "0",
            "overflow": "hidden"
        }).change(function() {
            //alert('파일 업로드')
            var $img = $('.onSelect img');
            var file = this.files[0];
            
            if (file) {
                $('.onSelect svg').remove();
            }   
            
            // formData 선언
            var formData = new FormData();
            
            formData.append('file', file);
            
            $.ajax({
                url : 'albumImageSave',
                processData : false,
                contentType : false,
                type : 'POST',
                data : formData,
                dataType : 'text',
                success : function(saved_name) {
                    
                    //saved_name을 받으면 이미지 src에 연결한다.
                    // fail이 아닐 경우 -> 이미지 저장됨
                    if (saved_name != 'fail') {
                        
                        $img.attr('src', 'img_album?filePath=' + saved_name).css({
                            "display": "block"
                        });
                        
                    } else {
                        alert('업로드 실패');
                    }
                },
                error : function(e) {
                    alert('파일 업로드 실패');
                }
            });

        });
        $arr_bt[$arr_bt.length-1].append($i_plus).append($input_file).mouseenter(function(e) {
            createTooltip($(this), '추가');
        }).mouseleave(function(e) {
            $('.tooltip').remove();
        });
            
        // 사진 자르기 (대영)
        $arr_bt.push($('<button />', {
            "id": "bt_crop",
            "text": "자르기"
        }));
        $arr_bt[$arr_bt.length-1].click(function() {
        	
        	var check_crop = $('.onSelect img').css('display');
        	if(check_crop != 'none'){
            		curTime = new Date().getTime();
            		//편집창 열면서 사진url 넓이 높이 보내기
            		var settings ='height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes';
                	$('.onSelect img').attr('id', curTime); //임시 id값은 자식창에서 종료키 누르면 삭제됨
                	var windowObj = window.open("crop_picture?url_picture=" + $('.onSelect img').attr('src') + "&picture_id="+ curTime +"", "window_crop", settings);
        	}else {
        		alert('사진을 올리고 자르기를 클릭해주세요.');
        	}         	
		});
        
        // 사진 회전 (대영)
        $arr_bt.push($('<button />', {
            "id": "bt_rotate",
            "text": "회전"
        }));
        
        // 사진 필터 (대영)
        $arr_bt.push($('<button />', {
            "id": "bt_filter",
            "text": "필터"
        }));

        // 현재 페이지 배경으로
        $arr_bt.push($('<button />'));
        $i_set_background = $('<i class="far fa-images"></i>');
        $arr_bt[$arr_bt.length-1].append($i_set_background).click(function(e) {
            var src = $('.onSelect img').attr('src');
            $('.onSelect').parent('.page').css({
                "background-image": "url(" + src + ")",
                "background-repeat": "no-repeat",
                "background-size":"100% 100%"
            });
            $('.onSelect').remove();
            removeEdit();
        }).mouseenter(function(e) {
            createTooltip($(this), '배경으로');
        }).mouseleave(function(e) {
            $('.tooltip').remove();
        })
    }
        
    
    // 삭제
    $arr_bt.push($('<button />'));
    var $i_delete = $('<i class="fas fa-times"></i>');
    $arr_bt[$arr_bt.length-1].append($i_delete).click(function() {
        remove_box();
    }).mouseenter(function(e) {
        createTooltip($(this), '삭제');
    }).mouseleave(function(e) {
        $('.tooltip').remove();
    });


    // 제일 위로
    $arr_bt.push($('<button />'));
    var $i_to_the_top = $('<i class="fas fa-angle-double-up"></i>');
    $arr_bt[$arr_bt.length-1].append($i_to_the_top).click(function() {
        // TODO 제일 위로 올리기

        // id 배열 내 index(z-index는 인덱스 + 500)
        var target_index = arr_box_id.indexOf($('.onSelect').attr('id'));

        // id 배열 내 onSelect의 id를 가장 뒤로 이동
        arr_box_id.splice(target_index, 1);
        arr_box_id.push($('.onSelect').attr('id'));

        // z-index 조정
        for(var i = 0; i < arr_box_id.length; i++) {
            $('#' + arr_box_id[i] + '').css({
                "z-index" : 500 + i
            })
        }

    }).mouseenter(function(e) {
        createTooltip($(this), '가장 위로');
    }).mouseleave(function(e) {
        $('.tooltip').remove();
    });

    // 스크롤 보정을 위한 변수
    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    var scrollLeft = document.documentElement.scrollLeft || document.body.scrollLeft;


    // onSelect가 속한 페이지 번호
    var pagenum = $('.onSelect').parent().attr('id').replace(/\D/g,'');

    // 클릭한 페이지의 위치 확인
    var curr_page_top = album_top;
    var curr_page_left = album_left;
    if(pagenum % 2 == 1) {
        // 드랍한 페이지가 홀수 페이지일 경우 우측에 위치하므로 왼쪽 페이지의 너비만큼 더해준다.
        curr_page_left += PAGE_WIDTH; 
    }


    // 1단계 편집창 div 생성
    var $div_whole_editor = $('<div />');
    $div_whole_editor.addClass('edit').addClass('div_whole_editor').css({
        "position": "absolute",
        "top": $('.onSelect').position().top + curr_page_top - 50,
        "left": $('.onSelect').position().left + curr_page_left
    }).prop("contenteditable", false).appendTo('body');
   
    var over_left = $(window).width() - Number($('.div_whole_editor').css('left').replace('px', '')) - 350;
    if(over_left < 0) {
    	$('.div_whole_editor').css('left', $('.onSelect').position().left + curr_page_left + over_left)
    }
    
    // div append
    for(var i = 0; i < $arr_bt.length; i++) {
        var $tmp_div = $('<div />');
        $tmp_div.append($arr_bt[i]);

        $arr_bt[i].addClass('div_bt');


        // 항목에서 마우스 떼면 감추기
        $tmp_div.mouseleave(function() {
            //텍스트 부분
            $('.div_font').css('display', 'none');
        });


        /**
         *  [start] div를 열어야 하는 경우
         */
        
        // 사진 회전 (대영)
        if(($arr_bt[i].attr('id') == "bt_rotate")){

            $tmp_div.mouseenter(function(e) {
                $('.div_picturerotate').css("display", "block");
            }).mouseleave(function(e) {
                $('.div_picturerotate').css("display", "none");
            })


        	var $innerDiv = $('<div />', {
                 "class": "div_picturerotate"
             }).css({
                 "text-align": "left",
                 "display": "none"
             });
             
             var $arr_bt_rotate = [];
             
             //0도
             $arr_bt_rotate.push($('<button />', {
                 "class": "bt_rotate", 
                 "text": "0도"
             }));
             $arr_bt_rotate[$arr_bt_rotate.length -1].css({
                 "font-size": "10pt"
             }).click(function() {
                 $('.onSelect').css("transform", "rotateZ(0deg)");
             });
             
             //45도
             $arr_bt_rotate.push($('<button />', {
                 "class": "bt_rotate", 
                 "text": "45도"
             }));
             $arr_bt_rotate[$arr_bt_rotate.length -1].css({
                 "font-size": "10pt"
             }).click(function() {
                 $('.onSelect').css("transform", "rotateZ(40deg)");
             });
             
             //90도
             $arr_bt_rotate.push($('<button />', {
                 "class": "bt_rotate", 
                 "text": "90도"
             }));
             $arr_bt_rotate[$arr_bt_rotate.length -1].css({
                 "font-size": "10pt"
             }).click(function() {
                 $('.onSelect').css("transform", "rotateZ(90deg)");
             });
             
             //135도
             $arr_bt_rotate.push($('<button />', {
                 "class": "bt_rotate", 
                 "text": "135도"
             }));
             $arr_bt_rotate[$arr_bt_rotate.length -1].css({
                 "font-size": "10pt"
             }).click(function() {
                 $('.onSelect').css("transform", "rotateZ(135deg)");
             });
             
             //180도
             $arr_bt_rotate.push($('<button />', {
                 "class": "bt_rotate", 
                 "text": "180도"
             }));
             $arr_bt_rotate[$arr_bt_rotate.length -1].css({
                 "font-size": "10pt"
             }).click(function() {
                 $('.onSelect').css("transform", "rotateZ(180deg)");
             });
             
             //225도
             $arr_bt_rotate.push($('<button />', {
                 "class": "bt_rotate", 
                 "text": "225도"
             }));
             $arr_bt_rotate[$arr_bt_rotate.length -1].css({
                 "font-size": "10pt"
             }).click(function() {
                 $('.onSelect').css("transform", "rotateZ(225deg)");
             });
             
             //270도
             $arr_bt_rotate.push($('<button />', {
                 "class": "bt_rotate", 
                 "text": "270도"
             }));
             $arr_bt_rotate[$arr_bt_rotate.length -1].css({
                 "font-size": "10pt"
             }).click(function() {
                 $('.onSelect').css("transform", "rotateZ(270deg)");
             });
             
             //315도
             $arr_bt_rotate.push($('<button />', {
                 "class": "bt_rotate", 
                 "text": "315도"
             }));
             $arr_bt_rotate[$arr_bt_rotate.length -1].css({
                 "font-size": "10pt"
             }).click(function() {
                 $('.onSelect').css("transform", "rotateZ(315deg)");
             });
             
             for (var j = 0; j < $arr_bt_rotate.length; j++) {
                 $innerDiv.append($arr_bt_rotate[j])
             }
             $tmp_div.append($innerDiv);
        }

        // 사진 필터 (대영)
        else if($arr_bt[i].attr('id') == "bt_filter") {

            $tmp_div.mouseenter(function(e) {
                $('.div_picturefilter').css("display", "block");
            }).mouseleave(function(e) {
                $('.div_picturefilter').css("display", "none");
            })

            var $innerDiv = $('<div />', {
                "class": "div_picturefilter"
            }).css({
                "text-align": "left",
                "display": "none"
            });
            
            var $arr_bt_filter = [];
            
            //기본
            $arr_bt_filter.push($('<button />', {
                "class": "bt_filter", 
                "text": "기본"
            }));
            $arr_bt_filter[$arr_bt_filter.length -1].css({
                "font-size": "10pt"
            }).click(function() {
                $('.onSelect img').css("filter", "none");
            });
                     
            //흑백
            $arr_bt_filter.push($('<button />', {
                "class": "bt_filter", 
                "text": "흑백"
            }));
            $arr_bt_filter[$arr_bt_filter.length -1].css({
                "font-size": "10pt"
            }).click(function() {
                $('.onSelect img').css("webkit-filter", "grayscale(100%)");
            });
            
            //화사한
            $arr_bt_filter.push($('<button />', {
                "class": "bt_filter", 
                "text": "화사한"
            }));
            $arr_bt_filter[$arr_bt_filter.length -1].css({
                "font-size": "10pt"
            }).click(function() {
                $('.onSelect img').css("filter", "brightness(200%)");
            });
            
            //명랑한
            $arr_bt_filter.push($('<button />', {
                "class": "bt_filter", 
                "text": "명랑한"
            }));
            $arr_bt_filter[$arr_bt_filter.length -1].css({
                "font-size": "10pt"
            }).click(function() {
                $('.onSelect img').css("filter", "contrast(200%)");
            });
            
            //슈렉
            $arr_bt_filter.push($('<button />', {
                "class": "bt_filter", 
                "text": "슈렉"
            }));
            $arr_bt_filter[$arr_bt_filter.length -1].css({
                "font-size": "10pt"
            }).click(function() {
                $('.onSelect img').css("filter", "hue-rotate(90deg)");
            });
            
            //유령
            $arr_bt_filter.push($('<button />', {
                "class": "bt_filter", 
                "text": "유령"
            }));
            $arr_bt_filter[$arr_bt_filter.length -1].css({
                "font-size": "10pt"
            }).click(function() {
                $('.onSelect img').css("filter", "invert(100%)");
            });
            
            //투명한
            $arr_bt_filter.push($('<button />', {
                "class": "bt_filter", 
                "text": "투명한"
            }));
            $arr_bt_filter[$arr_bt_filter.length -1].css({
                "font-size": "10pt"
            }).click(function() {
                $('.onSelect img').css("filter", "opacity(30%)");
            });
            
            //그림 같은
            $arr_bt_filter.push($('<button />', {
                "class": "bt_filter", 
                "text": "그림 같은"
            }));
            $arr_bt_filter[$arr_bt_filter.length -1].css({
                "font-size": "10pt"
            }).click(function() {
                $('.onSelect img').css("filter", "contrast(200%) brightness(150%)");
            });

            for (var j = 0; j < $arr_bt_filter.length; j++) {
                $innerDiv.append($arr_bt_filter[j])
            }
            $tmp_div.append($innerDiv);
        }
        
        // 글자 크기
        else if($arr_bt[i].attr('id') == "bt_size") {

            $tmp_div.addClass('div_font_size');
            $tmp_div.mouseenter(function(e) {
                $('.inner_div_font_size').css("display", "block");
            }).mouseleave(function(e) {
                $('.inner_div_font_size').css("display", "none");
            })

            var $inner_div = $('<div />', {
                "class": "inner_div_font_size"
            }).css({
                "display": "none"
            });

            for(var j = 0; j < arr_size.length; j++) {
                var $bt = $('<button />', {
                    "text": (j+1),
                    "class": "div_div_button"
                }).css({
                    "font-size": arr_size[j],
                    "color": "white"
                }).click(function(e) {
                    $('.onSelect').css({
                        "font-size": $(this).css("font-size")
                    })
                })
                $bt.appendTo($inner_div);
            }
            var $bt1 = $('<button />').appendTo($inner_div);
            var $bt2 = $('<button />').appendTo($inner_div);

            $inner_div.appendTo($tmp_div);

        }

        // 글꼴
        else if($arr_bt[i].attr('id') == "bt_font") {

            var $innerDiv = $('<div />', {
                "class": "div_font"
            });
            $innerDiv.css({
                "display": "none", 
                "z-index": "1000"
            });

            // 글꼴
            var $arr_bt_font = [];
            // 궁서체
            $arr_bt_font.push($('<button />', {
                "class": "bt_font", 
                "text": "궁서체"
            }));
            $arr_bt_font[$arr_bt_font.length -1].css({
                "font-family": "궁서체, serif"
            }).click(function() {
                $('.onSelect').css("font-family", "궁서체, serif");
            });
            // 맑은고딕
            $arr_bt_font.push($('<button />', {
                "class": "bt_font", 
                "text": "맑은고딕"
            }));
            $arr_bt_font[$arr_bt_font.length -1].css({
                "font-family": "Malgun Gothic, serif"
            }).click(function() {
                $('.onSelect').css("font-family", "Malgun Gothic, serif");
            });
            // 굴림
            $arr_bt_font.push($('<button />', {
                "class": "bt_font", 
                "text": "굴림"
            }));
            $arr_bt_font[$arr_bt_font.length -1].css({
                "font-family": "굴림, serif"
            }).click(function() {
                $('.onSelect').css("font-family", "굴림, serif");
            });
            // 바탕
            $arr_bt_font.push($('<button />', {
                "class": "bt_font", 
                "text": "바탕"
            }));
            $arr_bt_font[$arr_bt_font.length -1].css({
                "font-family": "바탕, serif"
            }).click(function() {
                $('.onSelect').css("font-family", "바탕, serif");
            });
            // Nanum Brush Script
            $arr_bt_font.push($('<button />', {
                "class": "bt_font", 
                "text": "Nanum Brush Script"
            }));
            $arr_bt_font[$arr_bt_font.length -1].css({
                "font-family": "Nanum Brush Script, serif"
            }).click(function() {
                $('.onSelect').css("font-family", "Nanum Brush Script, serif");
            });
            // Gamja Flower
            $arr_bt_font.push($('<button />', {
                "class": "bt_font", 
                "text": "Gamja Flower"
            }));
            $arr_bt_font[$arr_bt_font.length -1].css({
                "font-family": "Gamja Flower, cursive"
            }).click(function() {
                $('.onSelect').css("font-family", "Gamja Flower, cursive");
            }); 
            // Hi Melody
            $arr_bt_font.push($('<button />', {
                "class": "bt_font", 
                "text": "Gugi"
            }));
            $arr_bt_font[$arr_bt_font.length -1].css({
                "font-family": "Hi Melody, cursive"
            }).click(function() {
                $('.onSelect').css("font-family", "Hi Melody, cursive");
            });
            for (var j = 0; j < $arr_bt_font.length; j++) {
                $innerDiv.append($arr_bt_font[j].addClass('div_div_button'))
            }
            $tmp_div.append($innerDiv);
        }

       // 글자 색
       else if($arr_bt[i].attr('id') == "bt_color") {
            
            $tmp_div.addClass('div_font_color');
            $tmp_div.mouseenter(function(e) {
                $('.inner_div_font_color').css("display", "block");
            }).mouseleave(function(e) {
                $('.inner_div_font_color').css("display", "none");
            })

            var $inner_div = $('<div />', {
                "class": "inner_div_font_color"
            }).css({
                "display": "none"
            });

            for(var j = 0; j < arr_color.length; j++) {
                var $bt = $('<button />', {
                    "class": "div_div_button"
                }).css({
                    "background-color": arr_color[j]
                }).click(function(e) {
                    $('.onSelect').css({
                        "color": $(this).css("background-color")
                    })
                });
                $bt.appendTo($inner_div);
            }

            $inner_div.appendTo($tmp_div);
        }

        // 배경색
        else if($arr_bt[i].attr('id') == "bt_bcolor") {

            $tmp_div.addClass('div_font_bcolor');
            $tmp_div.mouseenter(function(e) {
                $('.inner_div_font_bcolor').css("display", "block");
            }).mouseleave(function(e) {
                $('.inner_div_font_bcolor').css("display", "none");
            })

            var $inner_div = $('<div />', {
                "class": "inner_div_font_bcolor"
            }).css({
                "display": "none"
            });

            for(var j = 0; j < arr_color.length; j++) {
                var $bt = $('<button />', {
                    "class": "div_div_button"
                }).css({
                    "background-color": arr_color[j]
                }).click(function(e) {
                    $('.onSelect').css({
                        "background-color": $(this).css("background-color")
                    })
                });
                $bt.appendTo($inner_div);
            }

            $inner_div.appendTo($tmp_div);
        }
        /**
         *  [end] div를 열어야 하는 경우
         */
        
        $div_whole_editor.append($tmp_div);
    }



    

    // $arr_bt[$arr_bt.length-1].parent().mouseenter(function(e) {
    //     createTooltip($(this), '가장 위로');
    // }).mouseleave(function(e) {
    //     $('.div_tooltip').remove();
    // });
    
    // 공통 클래스 적용.....
    $div_whole_editor.contents().addClass('edit');
    $div_whole_editor.contents().contents().addClass('edit');
    
}
// [end] 1단계 편집창 생성

// [start] 2단계 편집창(텍스트 전용) 생성
function createTextEditor(top, left) {

    var $arr_bt = [];
    
    // 왼쪽 정렬
    $arr_bt.push($('<button />'));
    var $i_align_left = $('<i class="fas fa-align-left"></i>');
    $arr_bt[$arr_bt.length-1].append($i_align_left).click(function() {
        document.execCommand('justifyLeft', false, null);
    });

    // 가운데 정렬
    $arr_bt.push($('<button />'));
    var $i_align_center = $('<i class="fas fa-align-center"></i>');
    $arr_bt[$arr_bt.length-1].append($i_align_center).click(function() {
        document.execCommand('justifyCenter', false, null);
    });

    // 오른쪽 정렬
    $arr_bt.push($('<button />'));
    var $i_align_right = $('<i class="fas fa-align-right"></i>');
    $arr_bt[$arr_bt.length-1].append($i_align_right).click(function() {
        document.execCommand('justifyRight', false, null);
    });
    
    // 글자 색
    $arr_bt.push($('<button />', {"class": "sel_font_color"}));
    var $i_font_white = $('<i class="fas fa-font"></i>');
    var $i_font_yellow = $('<i class="fas fa-font"></i>');
    $i_font_yellow.css('color', 'yellow');
    $arr_bt[$arr_bt.length-1].append($i_font_white).append($i_font_yellow);

    // 글자 배경 색
    $arr_bt.push($('<button />', {"class": "sel_font_bcolor"}));
    var $i_font_white = $('<i class="fas fa-font"></i>').css({
        'color': 'white',
        'background-color': 'yellow'
    });
    $arr_bt[$arr_bt.length-1].append($i_font_white);

    // 볼드
    $arr_bt.push($('<button />'));
    var $i_bold = $('<i class="fas fa-bold"></i>');
    $arr_bt[$arr_bt.length-1].append($i_bold).click(function(e) {
        // TODO 매우 중요!! document.queryCommandState('bold') 
        document.execCommand('bold', false, null);
    });

    // 이탤릭
    $arr_bt.push($('<button />'));
    var $i_italic = $('<i class="fas fa-italic"></i>');
    $arr_bt[$arr_bt.length-1].append($i_italic).click(function(e) {
        // TODO 매우 중요!! document.queryCommandState('bold') 
        document.execCommand('italic', false, null);
    });

    // 밑줄
    $arr_bt.push($('<button />'));
    var $i_underline = $('<i class="fas fa-underline"></i>');
    $arr_bt[$arr_bt.length-1].append($i_underline).click(function(e) {
        // TODO 매우 중요!! document.queryCommandState('bold')
        document.execCommand('underline', false, null);
    });

    // 글자 크게
    $arr_bt.push($('<button />'));
    var $i_font = $('<i class="fas fa-font"></i>');
    var $i_plus = $('<i class="fas fa-plus"></i>');
    $arr_bt[$arr_bt.length-1].append($i_font).append($i_plus).click(function(e) {
        var curr_font_size = document.queryCommandValue('fontSize');
        document.execCommand('fontSize', false, Number(curr_font_size) + 1);
    });

    // 글자 작게
    $arr_bt.push($('<button />'));
    var $i_font = $('<i class="fas fa-font"></i>');
    var $i_minus = $('<i class="fas fa-minus"></i>');
    $arr_bt[$arr_bt.length-1].append($i_font).append($i_minus).click(function(e) {
        var curr_font_size = document.queryCommandValue('fontSize');
        document.execCommand('fontSize', false, Number(curr_font_size) - 1);
    });


    // 스크롤 보정을 위한 변수
    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    var scrollLeft = document.documentElement.scrollLeft || document.body.scrollLeft;

    // 텍스트 편집 옵션창
    var $div_selection_editor = $('<div />');
    $div_selection_editor.addClass('edit').addClass('div_selection_editor').css({
        "position": "absolute",
        "top": top + scrollTop - 65,
        "left": left + scrollLeft - 225
    }).prop("contenteditable", false).appendTo('body');
    
    var over_left = $(window).width() - Number($('.div_selection_editor').css('left').replace('px', '')) - 500;
    if(over_left < 0) {
    	$('.div_selection_editor').css('left', $('.div_selection_editor').position().left + over_left)
    }

    // 효과 버튼 append
    for(var i = 0; i < $arr_bt.length; i++) {
        var $tmp_div = $('<div />');
        $tmp_div.append($arr_bt[i]);
        $arr_bt[i].addClass('div_bt');

        // 글자색 처리
        if($arr_bt[i].hasClass('sel_font_color')) {
            $tmp_div.addClass('div_sel_font_color');
            $tmp_div.mouseenter(function(e) {
                $('.inner_div_sel_font_color').css("display", "block");
            }).mouseleave(function(e) {
                $('.inner_div_sel_font_color').css("display", "none");
            })

            var $inner_div = $('<div />', {
                "class": "inner_div_sel_font_color"
            }).css({
                "display": "none"
            });

            for(var j = 0; j < arr_color.length; j++) {
                var $bt = $('<button />', {
                    "class": "div_div_button"
                }).css({
                    "background-color": arr_color[j]
                }).click(function(e) {
                    document.execCommand('foreColor', false, $(this).css("background-color"));
                });
                $bt.appendTo($inner_div);
            }

            $inner_div.appendTo($tmp_div);
        }

        // 글자 배경색 처리
        if($arr_bt[i].hasClass('sel_font_bcolor')) {
            $tmp_div.addClass('div_sel_font_bcolor');
            $tmp_div.mouseenter(function(e) {
                $('.inner_div_sel_font_bcolor').css("display", "block");
            }).mouseleave(function(e) {
                $('.inner_div_sel_font_bcolor').css("display", "none");
            })

            var $inner_div = $('<div />', {
                "class": "inner_div_sel_font_bcolor"
            }).css({
                "display": "none"
            });

            for(var j = 0; j < arr_color.length; j++) {
                var $bt = $('<button />', {
                    "class": "div_div_button"
                }).css({
                    "background-color": arr_color[j]
                }).click(function(e) {
                    document.execCommand('backColor', false, $(this).css("background-color"));
                });
                $bt.appendTo($inner_div);
            }

            $inner_div.appendTo($tmp_div);
        }


        $div_selection_editor.append($tmp_div);
    }
    
    // 공통 클래스 적용.....
    $div_selection_editor.contents().addClass('edit');
    $div_selection_editor.contents().contents().addClass('edit');
}
// [end] 2단계 편집창(텍스트 전용) 생성

// 편집창 제거
function removeEdit() {
    $('.div_selection_editor').remove();
    $('.div_whole_editor').remove();
    $('.tooltip').remove();
}

// onSelect, onEdit 상태 해제
function clearOn() {
    $('.onEdit').draggable('enable').resizable('disable').prop("contenteditable", false).css({
            "z-index": 500 + arr_box_id.indexOf($('.onEdit').attr('id'))
        }).removeClass('onEdit').find(".ui-resizable-handle").hide();
    $('.onSelect').draggable('enable').resizable('disable').css({
            "z-index": 500 + arr_box_id.indexOf($('.onSelect').attr('id'))
        }).removeClass('onSelect').find(".ui-resizable-handle").hide();
}

/**
 *  [start] 도움말 생성
 **/
function createTooltip($elem, text) {

    // 스크롤 보정을 위한 변수
    var scrollTop = $(document).scrollTop();
    var scrollLeft = $(document).scrollLeft();

    var $editor = $('.div_whole_editor') || $('.div_selection_editor');

    // 도움말
    var $div_tooltip = $('<div />');
    $div_tooltip.html(text);

    

    if(!$elem.hasClass('under_tool')) {
    	$div_tooltip.addClass('tooltip').appendTo('body').css({
	        "top": $editor.position().top - 40,
	        "left": $editor.position().left + $elem.parent().position().left + 20 - $div_tooltip.width()/2
	    })
	} else {
		$div_tooltip.addClass('tooltip_under_bar').appendTo($elem.parent()).css({
			"top": $elem.position().top - 40,
	        "left": $elem.position().left + 40 - $div_tooltip.width()/2
	    })
	}

}
// [end] 도움말 생성


/**
 *  [start] 페이지 저장(페이지 div의 css:backgroud-image 속성도 저장한다.)
 **/
function savePage(mode) {

    // 몇 페이지 저장할 것인지
    var count = 1;
    // 몇 페이지부터 저장할 것인지
    var start = 1;

    
    if(curr_page == 1){
	    // 표지 섬네일 저장
	    page1ImageSave();
    }

    if(mode == 'all') {
        // 앨범 전체 저장 모드
        count = $('#album').turn('pages');
        alert('저장이 완료 되었습니다.');
		isSave = true;

    } else if(mode == 'curr') {

        // 일반 저장일 경우 현재 페이지부터 저장

        start = curr_page;

        if(curr_page != 1 && curr_page != $('#album').turn('pages')) {
            // 현재 페이지가 싱글 페이지가 아니면 오른쪽 장도 저장해야 함.
            count++;
        }
        
    }

    var arr_page = [];

    for(var i = start; i < start+count; i++) {

        var html = $('#page' + i + '').html();

        $page_clone = $('#page' + i + '').clone();

        $boxs_clone = $page_clone.find('.div_box');
        $boxs_clone.each(function(j, div_box) {
            $(div_box).draggable().resizable().draggable('destroy').resizable('destroy').removeClass('ui-resizable-disabled');
        });

        arr_page[i-start] = {
            "page_num": i,
            "page_html": $page_clone.html(),
            "page_background": $page_clone.css('background-image'),
            "page_color": $page_clone.css('background-color')
        }

    }
    $.ajax({
        url : 'save_page',
        type : 'POST',
        data : {
            album_num: $('#hidden_album_num').val(),
            arr_page: JSON.stringify(arr_page),
            mode: mode
        },
        dataType : 'text',
        success : function(a) {
            //console.log('저장된 앨범번호 -> ' + a);
        },
        error : function(e) {
            alert(JSON.stringify(e));
        }
    });

}
// [end] 페이지 저장

/**
 *  페이지 추가
 *  현재 보고 있는 페이지를 기준으로 2페이지 추가
 **/
 function addPage() {

    // 페이지 추가는 커버 바로 앞에 두 페이지 씩 추가하는 형태
    var total_page = $('#album').turn('pages');
    //console.log('totla_page -> ' + total_page);

    //2페이지 추가이므로 2번 반복
    for(var i = 0; i < 2; i++) {

        // 새 뒷 커버 생성
        var $page = $('<div />', {
            'id': 'page' + (total_page + (i+1)),
            'class': 'page hard'
        });

        //뒷 커버를 추가
        $('#album').turn('addPage', $page, (total_page+1+i));
        apply_page_droppable($('#page' + (total_page+1+i) + ''))
    }

    //기존 페이지의 아이디와 innerHTML을 두 페이지 씩 뒤로 이동
    for(var i = $('#album').turn('pages'); i >= curr_page+2; i--) {

        $('#page' + i + '').html($('#page' + (i - 2) + '').html());

    }

    // 새로 추가한 페이지는 아니지만... 한 장 새로 추가한 것처럼 보이기 위해 현재 페이지와 그 다음 페이지를 비운다...
    $('#page' + curr_page + '').html('');
    $('#page' + (curr_page + 1) + '').html('');

    // 모든 페이지의 droppable을 끄고 현재 보여지는 페이지만 droppable을 켠다.
    $('.page').droppable("disable");
    $('#page' + curr_page + '').droppable("enable");

    alert('페이지가 추가되었습니다!');

 }

 /**
  *  페이지 삭제
  *  현재 보고 있는 페이지를 기준으로 2페이지 삭제
  **/
 function removePage() {

    var total_page = $('#album').turn('pages');

    // 페이지 삭제 전 확인
    if(!confirm('보고 있는 페이지가 삭제됩니다. 정말 삭제하시겠습니까? (표지일 경우 뒷장도 함께 삭제됩니다!)')) return;

    //2페이지 추가이므로 2번 반복
    for(var i = 0; i < 2; i++) {

        if(curr_page == total_page) {
            // 마지막 페이지일 경우 앞 장도 
            $('#album').turn('removePage', curr_page - i);

        } else {
            // 마지막 페이지가 아닐 경우 현재 페이지와 그 다음 페이지 삭제
            $('#album').turn('removePage', curr_page);
        }
    }

    // id 수정
    for(var i = curr_page + 2; i <= total_page; i++) {
        $('#page' + i + '').attr('id', 'page' + (i - 2));
    }

    // 현재 페이지가 총 페이지 수를 초과할 경우 수정
    if(curr_page > $('#album').turn('pages')) {
        curr_page = $('#album').turn('pages');
    }

    alert('페이지가 삭제되었습니다!');

 }

/*
 * 슬라이더
 */
function slider() {
	$('#slider').slider({
		min: 1,
		max: $('#album').turn('pages')/2 +1,
		change: function(event, ui) {
			//console.log(ui.value)
		},
		slide: function(event, ui) {
			create_nav_bar(ui);
		},
		start: function(event, ui) {
			create_nav_bar(ui);
		},
		stop: function() {
			$('.slider_popup').remove();
		}
	});
}

function create_nav_bar(ui) {
	var total_width = $('.ui-slider').width();
	var scale = total_width / ($('#album').turn('pages')/2);
	var curr_left = scale * (ui.value - 1);
	var left = curr_left + $('#slider-bar').position().left;

	var top = $('#slider-bar').position().top;
	
	$('.slider_popup').remove();
	
	var $slider_popup = $('<div />', {
		"class": "slider_popup"
	}).css({
		"left": left,
		"top": top - 50
	});
	
	if(ui.value == 1) {
		$('#album').turn('page', 1);
	} else {
		$('#album').turn('page', (ui.value-1)*2 );
		
	}

	if(ui.value == 1 || ui.value == $('#album').turn('pages')/2 +1) {
		$slider_popup.text(((ui.value-1)*2) == 0? 1: (ui.value-1)*2);
		$slider_popup.css("left", left - 15);
	} else {
		$slider_popup.text((ui.value-1)*2 + " ~ " + ((ui.value-1)*2+1));
		$slider_popup.css("left", left - 20);
	}
	$slider_popup.appendTo('body')
}

function remove_box() {
    var id_index = arr_box_id.indexOf($('.onSelect').attr('id'));

    // onSelect인 박스일 경우만 삭제
    if($('.onSelect').remove()) {

        $('.tooltip').remove();

        // 편집창 제거
        removeEdit();

        // arr_box_id 조정
        arr_box_id.splice(id_index, 1);

        // arr_box_id를 바탕으로 모든 박스의 z-index 조정
        for(var i = 0; i < arr_box_id.length; i++) {
            $('#' + arr_box_id[i] + '').css({
                "z-index": 500 + i
            })
        }
        
    }
}

function create_tooltip_of_under_tool() {
	$('.under_tool').mouseenter(function(e) {
			
		createTooltip($(this), $(this).attr('role'));
		
	}).mouseleave(function(e) {
		$('.tooltip_under_bar').remove();
	})
}

function nav_page(location) {
	if(location == 'start') {
		$('#album').turn('page', 1);
	} else {
		$('#album').turn('page', $('#album').turn('pages'));
	}
}

// 속지 선택 div 팝업
function open_background() {
	
	$('.tooltip_under_bar').remove();
	$('#div_select_bg').remove();
	
	var $div = $('<div />', {
		"id": "div_select_bg",
		"class": "div_select_bg"
		
	}).css({
		"left": $('#i_brush').position().left - 20,
		"top": $('#i_brush').position().top - 160
	}).appendTo('body');
	
	var $osirase = $('<p />', {
		"text" : "속지 색 변경"
	}).css({
		"text-align": "center",
		"text-size": "large",
		"color": "white"
	}).appendTo($div);
	
	for(var i = 0; i < arr_color.length; i++) {
		var $bt = $('<button />', {
			"class": "bt_select_bg"
		}).css({
			"background-color": arr_color[i] 
		}).click(function(e) {
			$('.page').css({
				"background-color": $(this).css("background-color") 
			});
		}).appendTo($div);
	}
	
	
	$(document).click(function(e) {
		if(!$(e.target).parent().parent().hasClass('i_brush') && !$(e.target).parent().hasClass('i_brush')) {
			$('#div_select_bg').remove();
		}
	});
	
}

// 페이지 이동
function go_page(index) {
	if(index == 'first') {
		$('#album').turn('page', 1);
	} else if (index == 'before') {
		$('#album').turn('previous');
	} else if (index == 'next') {
		$('#album').turn('next');
	} else if (index == 'end') {
		$('#album').turn('page', $('#album').turn('pages'));
	}
}
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<title> new document </title>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
//<![CDATA[
  $(function(){

   //초기 설정
   var size=12;
   var body=$("textarea");

    //① 글자 크기의 버튼들을 클릭했을 때
    $(".zoom button").on("click",function(){
        var btn_index=$(".zoom button").index(this);  //클릭한 버튼의 인덱스 반환
        
        if(btn_index==0){ //"+"를 클릭했을 경우
           size++; //size가 1씩 증가
           body.css("font-size",size+"px"); //글자 크기 속성이 변경됨.
        }else if(btn_index==2){ //"-"를 클릭했을 경우
           size--; //size가 1씩 감소
           body.css("font-size",size+"px"); //글자 크기 속성이 변경됨.
        }else{ //"0"를 클릭했을 경우
           size=12; //디폴트로 다시 세팅
           body.css("font-size","12px"); //글자 크기 속성이 12px로 변경됨.
        }
        $("#lbl_fontsize").text(size); //글자크기 출력
    });

    //② 글자 모양을 선택했을 때 
    $("#fs").on("change",function(){
      body.css("font-family",$(this).val()); //글자 모양 변경
    });
  });

  //=======================================================================//
  /*유틸 메뉴 기능*/
  //=======================================================================//
  $(function(){
    
    /*zoom 버튼*/
    var base=100;
    var mybody=$("textarea");
    $("#zoom a").on("click",function(){
        var zNum=$("#zoom a").index(this);   //클릭한 <a>의 인덱스 반환
        if(zNum==0){//확대
            base+=10;
        }else if(zNum==1){//100%
            base=100;
        }else{//축소
            base-=10;
        }
        mybody
        .css("overflow-x","auto")
        .css("transform-origin","0 0") //기준위치를 좌측상단
        .css("transform","scale("+base/100+")") //ex)110/100 = 1.1 
        .css("zoom",base+"%");

        return false; // 클릭한 <a>의 이동을 막습니다.
    });

    /*인쇄 버튼*/
    $(".print_btn").on("click",function(){
       window.print();
       return false;
    })
  });
  $( function() {
	    $( "#textarea" ).draggable();
	
	  } );
//]]>

</script>
<style type="text/css">
  *{margin:0;padding:0;}
  body{font:12px dotum,"돋움",sans-serif;margin:20px;}

  #f_wrap dt{font-weight:bold;margin-top:10px;}
  #txt_wrap{width:90%;margin-top:20px;}
  #f_wrap .zoom button{width:20px;height:20px;}

  /*유틸 메뉴 영역*/
  li{list-style:none;}
  #util_menu dd{float:left;padding:0 5px;}
  #util_menu li{float:left;}
  #util_menu{position:absolute;top:4px;right:3px;}

</style>
</head>
<body>
 <div id="f_wrap">
    <dl>
      <dt>글자크기 (<span id="lbl_fontsize">12</span>px) </dt>
      <dd class="zoom">
        <button>+</button>
        <button>0</button>
        <button>-</button>
      </dd>
      <dt>글자모양</dt>
      <dd class="f_style">
          <select name="fs" id="fs">
            <option value="dotum,'돋움',sans-serif">돋움</option>
            <option value="gulim, '굴림', sans-serif">굴림</option>
            <option value="magun gothic, '맑은고딕', sans-serif">맑은고딕</option>
            <option value="gungsuh, '궁서', serif">궁서</option>
          </select>
      </dd>
    </dl>
 </div>

 

<table id ="textarea" style="border: 1px solid; border-collapse: collapse;">   
      
<tr style="border: solid 1px ;">      
<td style="border: 1px solid;">       
<textarea style= "border: 0;" id="txt_wrap"></textarea>  
</td></tr></table>  

<!--유틸메뉴 추가-->
<dl id="util_menu">
 <dd>
    <ul id="zoom">
       <li><img src="images/util_zoom_1.gif" alt="" /></li>
       <li>
        <a href="#" class="zoom_in"><img src="images/util_zoom_2.gif" alt="" /></a>
       </li>
       <li>
        <a href="#" class="zoom_return"><img src="images/util_zoom_3.gif" alt="" /></a>
       </li>
       <li>
        <a href="#" class="zoom_out"><img src="images/util_zoom_4.gif" alt="" /></a>
       </li>
    </ul>
 </dd>
  <dd>
      <a href="#" class="print_btn">
        <img src="images/util_print.gif" alt="" />
      </a>
  </dd>
</dl>

</body>
</html>
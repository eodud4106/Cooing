<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">
<head>
<script src="resources/joon_js/external/jquery/jquery.js"> </script>
<script src="resources/joon_js/jquery-ui.min.js"></script>
<meta charset=utf-8>
<meta name="viewport" content="width=620">
<title>HTML5 Demo: Drag and drop, automatic upload</title>
<body>
 
<style>
#holder { border: 10px dashed #ccc; width: 300px; min-height: 300px; margin: 20px auto;}
#holder.hover { border: 10px dashed #0c0; }
#holder img { display: block; margin: 10px auto; }
 
 
#container { width: 300px; margin: 0px auto;}
progress { width: 300px; margin: 0px auto; }
</style>
<div id="holder">
</div> 
   
<div id="container">
    <progress id="uploadprogress" min="0" max="100" value="0"/>
</div> 
 
 
<script type="text/javascript">
$(document).ready(function() {
	$("img").draggable({
		
	})
});
    var holder = document.getElementById('holder');
    var progress = document.getElementById('uploadprogress');
         
    holder.ondragover = function () { this.className = 'hover'; return false; };
    holder.ondragend = function () { this.className = ''; return false; };
    holder.ondrop = function (e) {
        this.className = '';
        e.preventDefault();
        readfiles(e.dataTransfer.files);
    }
 
     
    function readfiles(files) {
        // 파일 미리보기
        previewfile(files[0]);
         
        var formData = new FormData();
        formData.append('upload', files[0]);
     
        var xhr = new XMLHttpRequest();
        xhr.open('POST', './devnull.php');
        xhr.onload = function() {
            progress.value = 100;
        };
 
        xhr.upload.onprogress = function (event) {
            if (event.lengthComputable) {
                var complete = (event.loaded / event.total * 100 | 0);
                progress.value = progress.innerHTML = complete;
            }
        }
 
        xhr.send(formData);
    }
     
    function previewfile(file) {
        var reader = new FileReader();
        reader.onload = function (event) {
            var image = new Image();
            image.src = event.target.result;
            image.width = 250; // a fake resize
            holder.appendChild(image);
        };
 
        reader.readAsDataURL(file);
    }
    <!--
    SET_DHTML(CURSOR_MOVE, TRANSPARENT, "kreuzotter", "nordland");

    // The following loop creates a copy for each of the two images,
    // but hides that copy immediately while the page is still loading
    for (var i = 0; i < 2; i++)
    {
        dd.elements[i].copy();
        dd.elements[i].copies[0].hide();
    }

    // The following two functions override their empty namesakes predefined in wz_dragdrop.js.
    // They are automatically invoked from wz_dragdrop.js when a drag operation starts
    // and ends, respectively.

    // Here we make the non-transparent 'placeholder' copy of the dragged image visible
    // and move it to the place where the drag operation starts
    function my_PickFunc()
    {
        dd.obj.copies[0].moveTo(dd.obj.x, dd.obj.y);
        dd.obj.copies[0].show();
    }

    // Here we hide the 'placeholder' again
    function my_DropFunc()
    {
        dd.obj.copies[0].hide();

        // Write the name and coordinates of the dropped item into form inputs:
        document.myForm.NAME.value = dd.obj.name;
        document.myForm.X.value = dd.obj.x;
        document.myForm.Y.value = dd.obj.y;
    }
    //--> 
</script>
<img src="<c:url value="/resources/joon_image/cooing1.jpg" />"width="400" height="300">

<img src="<c:url value="/resources/joon_image/cooing5.jpg" />"width="400" height="300">
</body>
</html>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
  #imageContainer {
    max-width: 100%; /* 이미지 컨테이너의 최대 너비를 화면 너비로 설정 */
    height: auto; /* 높이를 자동으로 조절하여 가로세로 비율 유지 */
  }

  #imageContainer img {
    max-width: 100%; /* 이미지의 최대 너비를 100%로 설정 */
    height: auto; /* 높이를 자동으로 조절하여 가로세로 비율 유지 */
    display: block; /* 인라인 요소 간격 문제 해결 */
    margin: 0 auto; /* 가운데 정렬 */
  }
</style>
</head>
<body>

<input type="file" id="fileInput" name="file" onchange="previewFile()" />
<div id="imageContainer"></div>

<script>
    function previewFile() {
        var fileInput = document.getElementById('fileInput');
        var file = fileInput.files[0];

        if (file) {
            var reader = new FileReader();

            reader.onload = function (e) {
                var imageContainer = document.getElementById('imageContainer');
                imageContainer.innerHTML = '<img src="' + e.target.result + '" alt="Uploaded Image" />';
            };

            reader.readAsDataURL(file);
        } else {
            alert('파일을 선택해주세요');
        }
    }
</script>

</body>
</html>
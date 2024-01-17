<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Image Preview</title>
    <style type="text/css">
        #imageContainer {
            width: 500px;
        }
    </style>
</head>
<body>
    <table bgcolor='#e4e9de' border='1' bordercolordark='#ffffff' bordercolorlight='#bccad5' cellspacing='0' cellpadding='1'>
        <form name="aaa">
            <tr>
                <td><font color=green>♤</font> 이미지를 선택하십시요. <font color=green>♤</font></td>
            </tr>
            <tr>
                <td><input type='file' name='dreamkos_file' size='32' onChange='dreamkos_imgview()'></td>
            </tr>
            <tr>
                <td><img id='pre' style='display:none;' border='0'></td>
            </tr>
        </form>
    </table>

    <img id="previewImg" align="absmiddle" style="display:none" border="0" onLoad="isValid(this);" onError="alert('Not image');">
    <input type="file" name="upImgPath" onChange="setNewImg(this);">

    <script language='javascript'>
        var limitedImgWidth = 50; // Limited width of an image
        var limitedImgHeight = 50; // Limited height of an image

        function isValid(oImg) {
            try {
                oImg.style.display = "inline";
                if ((oImg.width > 0 && oImg.width <= limitedImgWidth) &&
                    (oImg.height > 0 && oImg.height <= limitedImgHeight)) return true;
                else throw new Object("error");
            } catch (e) {
                oImg.style.display = "none";
                alert(e + "\\r\\n" + "Illegal image object!");
            }
            return false;
        }

        function setNewImg(oElement) {
            var oImg = document.getElementById("previewImg");
            if (oElement.value != "") oImg.setAttribute("src", oElement.value);
        }

        function dreamkos_imgview() {
            var img_pre = 'pre';
            var fileInput = document.aaa.dreamkos_file;
            var previewImg = document.getElementById(img_pre);

            if (fileInput.files && fileInput.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = 'inline';
                };

                reader.readAsDataURL(fileInput.files[0]);
            } else {
                previewImg.style.display = 'none';
            }
        }
    </script>
</body>
</html>




<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" type="text/css" href="/css/board.css">
  <script src="/script/board.js"></script>
  <script>
        function selectimage() {
          document.frm.submit();
        }
  </script>
</head>
<body>
    <div id="wrap">
        <form name="frm" action="fileupload" method="post" enctype="multipart/form-data">
            <h1>파일 선택</h1>
            <input type="file" name="image" onchange="selectimage();">
        </form>
    </div>
</body>
</html>

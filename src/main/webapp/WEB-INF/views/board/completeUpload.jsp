<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>정진이네 게시판</title>
  <link rel="stylesheet" type="text/css" href="/css/board.css">
  <script src="/script/board.js"></script>
  <script>
      opener.document.getElementById("previewimg").setAttribute("src", "/images/" + "${savefilename}");
      opener.document.getElementById("previewimg").style.display="inline";  // 이미지 미리보기

      opener.document.insertBoard.image.value='${image}';
      opener.document.insertBoard.savefilename.value='${savefilename}';
      self.close();
  </script>
</head>
<body>

</body>
</html>

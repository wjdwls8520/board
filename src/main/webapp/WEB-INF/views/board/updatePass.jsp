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
    <form name="frm" action="updatePass" method="post">
        <input type="hidden" name="num" value="${num}" />
        <h1>패스워드 수정</h1>
        기존 비밀번호 :       <input type="password" name="oldPass" /> <br />
        새 비밀번호 :          <input type="password" name="newPass" /> <br />
        새 비밀번호 확인 :    <input type="password" name="confirmPass" /> <br />
        <input type="submit" value="수정" />
        <br />
        ${msg}
    </form>
</div>
</body>
</html>

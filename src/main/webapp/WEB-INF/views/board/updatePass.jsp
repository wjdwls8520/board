<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div id="wrap" align="center" style="width:100%">

    <form name="frm" action="updatePass"  method="post" >
        <input type="hidden" name="num" value="${num}" />
        <h1>패스워드 수정</h1>
        기존 비밀 번호 : <input type="password" name="oldPass" ><br />
        새 비밀 번호 : <input type="password" name="newPass" ><br />
        새 비밀 번호 확인 : <input type="password" name="confirmPass" ><br />
        <input type="submit" value="수정" /><br />
        ${msg}
    </form>

</div>

</body>
</html>

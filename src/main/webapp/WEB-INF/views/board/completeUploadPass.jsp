<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    alert("비밀번호가 수정되었습니다");
    opener.document.location.href='boardViewWithoutCnt?num=${num}';
    self.close();
</script>
</body>
</html>

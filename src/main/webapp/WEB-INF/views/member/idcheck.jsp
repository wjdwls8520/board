<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript">
        function idok( id ){
            opener.document.join.userid.value = id;
            opener.document.join.reid.value =  id;
            self.close();
        }
    </script>
    <style type="text/css">
        body{display: flex; justify-content: center; flex-direction: column;}
    </style>
</head>
<body>
<!-- 재검색 창 -->
<form action="idcheck" style="margin:20px 20px; display: flex; justify-content: center;">
    아이디 : <input type="text" name="userid" value="${userid}" /><!-- value 에 현재 중복체크한 아이디 표시 -->
    <input type="submit" value="중복체크" />
</form>

<!-- 사용 가능/불가능 -->
<div style="display: flex; justify-content: center;">
<c:choose>
    <c:when test="${result==-1}">
            <script type="text/javascript">
                opener.document.join.userid.value="";
                opener.document.join.reid.value="";
            </script>
            ${userid}는 이미 사용 중이어서 사용이 불가능합니다.
    </c:when>
    <c:otherwise>
            ${userid}는 사용 가능한 아이디입니다.
            <input type="button" value="사용하겠습니다" onClick="idok('${userid}')" />
    </c:otherwise>
</c:choose>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/board.css" />
    <script src="/script/board.js" ></script>
</head>
<body>

<div id="main_container">
    <h2>게시글 수정</h2>
    <div class="board">
        <form class="insertBoar" method="post" name="insertBoard" action="updateBoard" >
            <input type="hidden" name="num" value="${dto.num}" />
            <div class="field">
                <div class="label">작성자</div><input type="text" name="userid" value="${dto.userid}" readonly />
            </div>
            <div class="field">
                <div class="label">비밀번호</div><input type="password" name="pass"  />
            </div>
            <div class="field">
                <div class="label">이메일</div><input type="text" name="email" value="${dto.email}"/>
            </div>
            <div class="field">
                <div class="label">제목</div><input type="text" name="title" value="${dto.title}"/>
            </div>
            <div class="field">
                <div class="label">내용</div>
                <textarea name="content" rows="10" cols="100" style="flex:4">${dto.content}</textarea>
            </div>

            <div class="field">
                <div class="label">기존 이미지</div>
                <div class="text">
                    <c:choose>
                        <c:when test="${empty oldfilename}" >
                            <img src="/images/noname.jpg" width="100" /><br />
                        </c:when>
                        <c:otherwise>
                            <img src="${oldfilename}" width="100" /><br />
                            ${board.image}
                        </c:otherwise>
                    </c:choose>
                    <input type="hidden" name="oldfilename"  value="${oldfilename}" />
                </div>
            </div>

            <div class="field">
                <div class="label">업데이트 할 이미지</div>
                <input type="button"  value="이미지 선택" onclick="selectImg()"/>
            </div>
            <div class="field">
                <div class="label">이미지 미리보기</div>
                <c:choose>
                    <c:when test="${empty dto.savefilename}">
                        <div style="flex:4">
                            <img src=""  id="previewimg" width="150" style="display:none" />
                        </div>
                        <input type="hidden" name="image" />
                        <input type="hidden" name="savefilename"  />
                    </c:when>
                    <c:otherwise>
                        <div style="flex:4">
                            <img src="${dto.savefilename}"  id="previewimg" width="150" />
                        </div>
                        <input type="hidden" name="image"  value="${dto.image}"/>
                        <input type="hidden" name="savefilename"  value="${dto.savefilename}"/>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="field">
                <input type="submit" value="수정완료"  />
                <input type="button" value="돌아가기" onClick="location.href='boardViewWithoutCnt=${dto.num}'" />
            </div>
            <div class="field">${msg} </div>
        </form>

    </div>
</div>
</body>
</html>

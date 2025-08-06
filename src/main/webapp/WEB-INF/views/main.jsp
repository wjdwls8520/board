<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>정진이네 게시판</title>
    <link rel="stylesheet" type="text/css" href="/css/board.css">
    <script src="/script/board.js"></script>
</head>
<body>
    <div id="main_container">
            <h2>Board List</h2>
            <div class="logininfo">
                    <div class="user">
                            <h3>${loginUser.userid}(${loginUser.name})님이 로그인 하셨습니다.</h3>
                            <input type="button" value="회원정보수정" onclick="location.href='updateMemberForm'" />
                            <input type="button" value="LogOut" onclick="location.href='logout'" />
                            <input type="button" value="회원탈퇴" onclick="deleteMember('${loginUser.userid}')" />
                    </div>
                    <div class="writebutton">
                            <input type="button" value="게시글 등록" onclick="location.href='insertBoardForm'" />
                    </div>
            </div>

            <div class="board">
                    <div class="title_row">
                            <div class="title_col">번호</div><div class="title_col">제목</div><div class="title_col">작성자</div>
                            <div class="title_col">작성일</div><div class="title_col">조회수</div>
                    </div>
                    <c:forEach items="${boardList}" var="board">
                            <div class="row">
                                    <div class="col">${board.num}</div>
                                    <div class="col">
                                            <a href="boardView?num=${board.num}" style="display: flex; align-items: center; gap: 3px; text-decoration: none">
                                                    <img src="/images/${board.savefilename}" width="60px" height="60px" />
                                                    ${board.title}
                                                    <c:if test="${board.replycnt > 0}">
                                                            <span style="color:red; font-weight:bold">[${board.replycnt}]</span>
                                                    </c:if>

                                                    <c:if test="${not empty board.savefilename}">
                                                            <span style="color:blue; font-weight:bold; font-size:90%">[img]</span>
                                                    </c:if>
                                            </a>
                                    </div>
                                    <div class="col">${board.userid}</div>
                                    <div class="col"><fmt:formatDate value="${board.writedate}" /></div>
                                    <div class="col">${board.readcount}</div>
                            </div>
                    </c:forEach>
            </div>
            <div class="paging">
                    <!-- prev 표시 -->
                    <c:if test="${paging.prev}">
                            <a href="/main?page=${paging.beginPage-1}">◀</a>&nbsp;&nbsp;
                    </c:if>

                    <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                            <a href=/main?page=${index}>
                                    <c:choose>
                                            <c:when test="${index == paging.page}">
                                                    <span style="color:red; font-weight:bold;">
                                                        &nbsp;${index}&nbsp;
                                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                                    <span style="color:black; font-weight:bold;">
                                                            &nbsp;${index}&nbsp;
                                                    </span>
                                            </c:otherwise>
                                    </c:choose>
                            </a>
                    </c:forEach>

                    <!-- next 표시 -->
                    <c:if test="${paging.next}">
                            <a href="/main?page=${paging.endPage+1}">▶</a>
                    </c:if>
            </div>

    </div>

        <div class="pop" style="display: flex; justify-content: center; align-items: center; background: #fff; border: 3px solid #000; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 600px; height: 500px;" onclick="document.querySelector('.pop').classList.add('display-none'); ">
                <h1 style="font-size: 60px">바보들아 환영한다</h1>
        </div>
</body>
</html>

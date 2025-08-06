function idcheck() {
    let join = document.join;
    if( join.userid.value == "" ) {
        alert("아이디를 입력하세요.");
        return;
    }

    let inputid = join.userid.value;
    var opt = "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=200";
    window.open("idcheck?userid=" + inputid, 'idcheck', opt);
}

function deleteMember(userid) {
    if( confirm("저장된 회원 정보가 모두 삭제됩니다. 작성하신 게시물과 댓글도 모두 삭제됩니다. 계속하시겠습니까?") ) {
        location.href='deleteMember?userid=' + userid;
    }
}

function selectImg() {
    var opt = "toolbar=no, menubar=no, resizable=no, width=450, height=200";
    window.open("selectimg", "selectimg", opt);
}

function deleteBoard( num ) {

    if( confirm("게시물과 해당 게시물의 댓글이 모두 삭제됩니다. 계속하시겠습니까?")) {
        var pass = prompt("삭제 비밀번호를 입력하세요.");

        location.href='deleteBoard?num=' + num + '&pass=' + pass;
    }
}

// 패스워드 수정
function updatePass(num) {

    var opt = "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=200";
    window.open("updatePassOpenWin?num=" + num, 'updatePassOpenWin', opt);
}



// 댓글
function replyCheck() {
    if( document.addRep.content.value=="") {
        alert("댓글 내용을 입력하세요.");
        return false;
    }
    return true;
}

function deleteReply(replynum, boardnum) {
    if( document.addRep.content.value=="") {
        alert("댓글을 삭제하시겠습니까.");
        location.href='deleteReply?replynum=' + replynum + '&boardnum=' + boardnum;
    }
    return true;
}




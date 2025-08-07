package com.himedia.board.controller;

import com.himedia.board.dto.BoardDto;
import com.himedia.board.dto.Paging;
import com.himedia.board.service.BoardService;
import com.himedia.board.service.S3UploadService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

@Controller
public class BoardController {

    @Autowired
    BoardService bs;

    @Autowired
    ServletContext context;

    @GetMapping("/main")
    public ModelAndView mainPage(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        HashMap<String,Object> result = new HashMap<>();
        result = bs.selectBoard(request);
        ArrayList<BoardDto> list = (ArrayList<BoardDto>) result.get("boardList");
        Paging paging = (Paging)result.get("paging");
        mav.addObject("boardList", list);
        mav.addObject("paging", paging);
        // mav.addObject("boardList", result.get("boardList"));
        // mav.addObject("paging", result.get("paging"));
        mav.setViewName("main");
        return mav;
    }


    @GetMapping("/boardView")
    public ModelAndView boardView(@RequestParam("num") int num) {
        ModelAndView mav = new ModelAndView();
        // HashMap<String, Object> result = new HashMap<String, Object>();
        HashMap<String, Object> result = bs.getBoard( num );

        // BoardDto bdto = (BoardDto) result.get("board");
        // mav.addObject("board", bdto);
        mav.addObject("board", result.get("board") );

        // ArrayList<ReplyDto> list = (ArrayList<ReplyDto>) result.get("replyList");
        // mav.addObject("replyList", list);
        mav.addObject("replyList", result.get("replyList") );

        mav.setViewName("board/boardView");
        return mav;
    }


    @GetMapping("/insertBoardForm")
    public String insertBoardForm() {
        return "board/insertBoard";
    }



    @GetMapping("/selectimg")
    public String selectimg() {
        return "board/selectimg";
    }




    @Autowired
    S3UploadService sus;

    @PostMapping("/fileupload")
    public String fileupload(@RequestParam("image") MultipartFile file,
                             HttpServletRequest request, Model model) {
        try {
            // 파일 업로드하고 그 경로와 파일이름을 리턴
            String uploadFilePathName = sus.saveFile( file );
            String filename = file.getOriginalFilename();
            model.addAttribute("image", filename);
            model.addAttribute("savefilename", uploadFilePathName);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return "board/completeUpload";
    }

    /*
    @PostMapping("/fileupload")
    public String fileupload(@RequestParam("image") MultipartFile file,
                             HttpServletRequest request, Model model) {
        String path = context.getRealPath("/images");  // 저장 경로 생성
        String filename = file.getOriginalFilename();
        Calendar today = Calendar.getInstance();
        long t = today.getTimeInMillis();
        String fn1 = filename.substring(0, filename.indexOf(".") );  // abc.jsp   -> abc
        String fn2 = filename.substring( filename.indexOf(".") ); // abc.jsp   -> jsp
        String savefilename = fn1 + t + fn2;   // 저장 파일 이름 생성
        String uploadPath = path + "/" + savefilename;    // 저장 경로와 파일 이름 완성
        try {
            file.transferTo( new File(uploadPath) );   // 파일 업로드
        } catch (IllegalStateException e) { e.printStackTrace();
        } catch (IOException e) { e.printStackTrace();        }
        model.addAttribute("image", filename);  // 사용자가 선택한 파일이름
        model.addAttribute("savefilename", savefilename);  //서버에 저장되는 이름
        return "board/completeUpload";
    }
     */


    @PostMapping("/insertBoard")
    public String insertBoard(@ModelAttribute("dto") @Valid BoardDto boarddto, BindingResult result, Model model) {
        String url = "board/insertBoard";
        if(result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage() );
        else if(result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage() );
        else if(result.hasFieldErrors("pass"))
            model.addAttribute("msg", result.getFieldError("pass").getDefaultMessage() );
        else {
            url = "redirect:/main";
            bs.insert(boarddto);
        }
        return url;
    }


    /*
    @PostMapping("/insertBoard")
    public String insertBoard(
            @Valid BoardDto boarddto, BindingResult result,
            @RequestParam("uploadImage") MultipartFile file,
            Model model) {
        String url = "board/insertBoard";
        System.out.println("boarddto : " + boarddto);
        System.out.println("file : " + file);
        if(result.hasFieldErrors("title"))
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage() );
        else if(result.hasFieldErrors("content"))
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage() );
        else if(result.hasFieldErrors("pass"))
            model.addAttribute("msg", result.getFieldError("pass").getDefaultMessage() );
        else{
            url = "redirect:/main";
            // 파일 업로드
            String path = content.getRealPath("/images");
            String filename = file.getOriginalFilename();
            Calendar today = Calendar.getInstance();
            long t = today.getTimeInMillis();
            String fn1 = filename.substring(0, filename.indexOf("."));  // abc.jsp   -> abc
            String fn2 = filename.substring(filename.indexOf(".")); // abc.jsp   -> .jsp
            String uploadFilePath = path + "/" + fn1 + t + fn2;   //  저장경로/abc12345678.jpg
            String savefilename = fn1 + t + fn2;    // abc12345678.jpg
            try {
                file.transferTo(new File(uploadFilePath));   // 파일 업로드
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

            // 게시글 등록
            boarddto.setImage(filename);
            boarddto.setSavefilename( savefilename);
            bs.insert( boarddto );
        }
        model.addAttribute("dto", boarddto);
        return url;
    }
    */


    @GetMapping("/updateBoardForm")
    public ModelAndView updateBoardForm( @RequestParam("num") int num ) {
        ModelAndView mav = new ModelAndView();
        //BoardDto bdto = bs.getBoardOne(num);
        //mav.addObject("board", bdto);
        mav.addObject("dto", bs.getBoardOne(num) );
        mav.addObject("oldfilename", bs.getBoardOne(num).getSavefilename() );
        mav.setViewName("board/updateBoard");
        return mav;
    }


    @PostMapping("/updateBoard")
    public String updateBoard(
            @ModelAttribute("dto") @Valid BoardDto boarddto, BindingResult result,
            @RequestParam("oldfilename") String oldfilename,  Model model) {
        model.addAttribute("oldfilename", oldfilename);
        String url = "board/updateBoard";
        BoardDto bdto = bs.getBoardOne(boarddto.getNum());

        if( result.hasFieldErrors("pass") )
            model.addAttribute("msg", result.getFieldError("pass").getDefaultMessage() );
        else if( result.hasFieldErrors("title") )
            model.addAttribute("msg", result.getFieldError("title").getDefaultMessage() );
        else if( result.hasFieldErrors("content") )
            model.addAttribute("msg", result.getFieldError("content").getDefaultMessage() );
        else if( !boarddto.getPass().equals( bdto.getPass() )  )
            model.addAttribute("msg", "수정을위한 패스워드가 일치하지 않습니다" );
        else{
            url = "redirect:/boardViewWithoutCnt?num=" + bdto.getNum();
            bs.update( boarddto);
        }
        return url;
    }

    @GetMapping("/boardViewWithoutCnt")
    public ModelAndView boardViewWithoutCnt(@RequestParam("num") int num) {
        ModelAndView mav = new ModelAndView();
        HashMap<String, Object> result = bs.getBoardWithoutCnt( num );
        mav.addObject("board", result.get("board") );
        mav.addObject("replyList", result.get("replyList") );
        mav.setViewName("board/boardView");
        return mav;
    }


    @GetMapping("/deleteBoard")
    public String deleteBoard(@RequestParam("num") int num, @RequestParam("pass") String pass, Model model) {
        BoardDto boarddto = bs.getBoardOne(num);
        if( boarddto.getPass().equals(pass) ) {
            bs.delete(num);
            return "redirect:/main";
        }else{
            model.addAttribute("num", num);
            return "board/deleteFail";
        }

    }



    @GetMapping("/updatePassOpenWin")
    public String updatePassOpenWin(  @RequestParam("num") int num , Model model) {
        model.addAttribute("num", num);
        return "board/updatePass";
    }


    @PostMapping("/updatePass")
    public String updatePass(
            @RequestParam(value="oldPass", required = false, defaultValue = "") String oldPass,
            @RequestParam(value="newPass", required = false, defaultValue = "") String newPass,
            @RequestParam(value="confirmPass", required = false, defaultValue = "") String confirmPass,
            @RequestParam("num")  int num, Model model
    ){
        String url = "board/updatePass";
        model.addAttribute("num", num);
        BoardDto boarddto = bs.getBoardOne(num);
        if( oldPass.equals("") || newPass.equals("") || confirmPass.equals("") ) {
            model.addAttribute("msg", "입력란을 모두 채우세요");
        }else if( !boarddto.getPass().equals( oldPass ) ) {
            model.addAttribute("msg", "기존 비밀번호가 맞지 않습니다");
        }else if( !newPass.equals( confirmPass ) ) {
            model.addAttribute("msg", "새 비밀번호가 확인이 일치하지 않습니다");
        }else{
            bs.updatePass( num, newPass);
            url = "board/completeUploadPass";
        }
        return url;
    }
}

package com.kh.moviediary.websocket.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.moviediary.common.template.Pagination;
import com.kh.moviediary.common.vo.ReviewPageInfo;
import com.kh.moviediary.member.vo.Member;
import com.kh.moviediary.websocket.model.service.NoteService;
import com.kh.moviediary.websocket.model.vo.Note;


@Controller
@RequestMapping("/websocket")
public class NoteController {
	
	
	// NoteController.java
	@GetMapping("/noteHandler")
	public String noteHandlerPage(@RequestParam(value="targetId", required=false) String targetId, 
	                             HttpSession session, RedirectAttributes ra, HttpServletRequest request, Model model) {
	    
	    // 1. 세션에서 loginUser 객체 확인
	    Member loginUser = (Member)session.getAttribute("loginUser");
	    
	    // 2. 비로그인 시 NullPointerException 방지를 위해 차단
	    if(loginUser == null) {
	        String referer = request.getHeader("Referer"); 
	        ra.addFlashAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
	        return "redirect:" + (referer != null ? referer : "/");
	    }
	    
	    model.addAttribute("targetId", targetId);
	    return "websocket/noteHandler"; 
	}

	
	@Autowired
	private NoteService noteService;
	
	
	
	@PostMapping("/insertNote.do")
	@ResponseBody
	public String insertNote(Note n, HttpSession session) {

	    Member loginUser = (Member)session.getAttribute("loginUser");

	 // [방어 코드 추가] 로그인 세션이 만료되었거나 비로그인인 경우
        if(loginUser == null) {
            return "fail"; // AJAX success에서 알림 처리 가능
        }
        
        // 1. 발신자 정보 설정 (로그인 유저의 정보 사용)
        n.setSendNickName(loginUser.getNickName()); // 닉네임 필드도 있다면 추가
        
        // 2. DB 저장 실행
        int result = noteService.insertNote(n);

        if(result > 0) {
            try {
                // 실시간 알림 전송
                WebsocketHandler.sendNoteAlarm(n.getReceiveNickName());
            } catch (Exception e) {
                e.printStackTrace();
            }
            return "success";
        }
        return "fail";
    }
	

	
	@RequestMapping("/noteList")
	public String noteList(@RequestParam(value="page", defaultValue="1") int currentPage,
	                       @RequestParam(value="type", defaultValue="received") String type, 
	                       HttpSession session, Model model) {
	    
	    Member loginUser = (Member)session.getAttribute("loginUser");
	    if(loginUser == null) {
	        return "redirect:/"; 
	    }
	    String userNickName = loginUser.getNickName();
	    
	    int listCount = type.equals("received") ? 
	                    noteService.selectListCount(userNickName) : 
	                    noteService.selectSentListCount(userNickName);

	    int boardLimit = 5;  
	    int pageLimit = 10;  

	    ReviewPageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
	    
	    List<Note> receivedList = noteService.selectReceivedNoteList(pi, userNickName);
	    List<Note> sentList = noteService.selectSentNoteList(pi, userNickName);
	    
	    model.addAttribute("pi", pi);
	    model.addAttribute("receivedList", receivedList); 
	    model.addAttribute("sentList", sentList);
	    
	    model.addAttribute("type", type);
	    
	    return "websocket/noteList";
	}
	
	@RequestMapping("/noteDetail")
	public String noteDetail(@RequestParam("nno") int nno, 
	                         @RequestParam("type") String type, 
	                         Model model) {
	    
	    Note n = noteService.selectNoteDetail(nno);
	    
	    if(n != null) {
	        model.addAttribute("n", n);
	        model.addAttribute("type", type); // 목록으로 돌아갈 때 필요한 상태값
	        return "websocket/noteDetail";
	    } else {
	        model.addAttribute("alertMsg", "존재하지 않는 쪽지입니다.");
	        return "redirect:/websocket/noteList?type=" + type;
	    }
	}

	
	

}

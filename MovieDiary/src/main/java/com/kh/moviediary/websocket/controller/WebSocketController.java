package com.kh.moviediary.websocket.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.moviediary.member.vo.Member;
import com.kh.moviediary.websocket.model.service.NoteService;
import com.kh.moviediary.websocket.model.vo.Note;


@Controller
@RequestMapping("/websocket")
public class WebSocketController {
	
	@GetMapping("/noteHandler") // 이 경로가 jsp의 href와 일치해야 합니다.
    public String noteHandlerPage() {
        return "websocket/noteHandler"; // 실제 파일 위치: /WEB-INF/views/websocket/noteHandler.jsp
    }
	
	@Autowired
	private NoteService noteService;
	
	@PostMapping("/insertNote.do")
	public String insertNote(Note n, HttpSession session, RedirectAttributes ra) {
	    // 세션에서 로그인한 유저의 ID를 발신자로 설정
	    Member loginUser = (Member)session.getAttribute("loginUser");
	    n.setSendId(loginUser.getUserId());
	    
	    int result = noteService.insertNote(n);
	    
	    if(result > 0) {
	        ra.addFlashAttribute("alertMsg", "쪽지를 성공적으로 보냈습니다.");
	    } else {
	        ra.addFlashAttribute("alertMsg", "쪽지 발송에 실패했습니다.");
	    }
	    return "redirect:/websocket/noteList"; // 저장 후 바로 쪽지함으로 이동
	}
	
	
	@GetMapping("/noteList") // 실제 주소: /moviediary/websocket/noteList
    public String noteListPage(HttpSession session, Model model) {
        Member loginUser = (Member)session.getAttribute("loginUser");
        
        if(loginUser != null) {
            String userId = loginUser.getUserId();
            // DB에서 리스트를 가져와 모델에 담는 로직 (기존 코드 유지)
            //model.addAttribute("receivedList", noteService.selectReceivedNoteList(userId));
            //model.addAttribute("sentList", noteService.selectSentNoteList(userId));
            
            return "websocket/noteList"; // 파일 위치: /WEB-INF/views/websocket/noteList.jsp
        }
        return "redirect:/";
    }
	

	
	

}

package com.kh.moviediary.websocket.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.moviediary.common.template.Pagination;
import com.kh.moviediary.common.vo.ReviewPageInfo;
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
		// 1. 세션에서 로그인 정보를 가져옵니다.
	    Member loginUser = (Member)session.getAttribute("loginUser");
	    
	    // [보안] 로그인이 안 된 경우를 체크합니다 (Null 방지)
	    if(loginUser == null) {
	        ra.addFlashAttribute("alertMsg", "로그인 후 이용 가능합니다.");
	        return "redirect:/"; 
	    }
	    
	    // 2. 발신자 ID 설정
	    n.setSendId(loginUser.getUserId());
	    
	    // 3. DB 저장 실행
	    // noteService가 @Autowired로 잘 주입되었는지 상단을 확인하세요!
	    int result = noteService.insertNote(n);
	    
	    if(result > 0) {
	        ra.addFlashAttribute("alertMsg", "쪽지를 성공적으로 보냈습니다.");
	    } else {
	        ra.addFlashAttribute("alertMsg", "쪽지 발송에 실패했습니다.");
	    }
	    
	    return "redirect:/websocket/noteList";
	}
	
	
	
	@RequestMapping("/noteList")
	public String noteList(@RequestParam(value="page", defaultValue="1") int currentPage, 
	                       HttpSession session, Model model) {
	    
	    // 1. 로그인한 유저의 아이디 가져오기
	    Member loginUser = (Member)session.getAttribute("loginUser");
	    
	    if(loginUser == null) {
	        return "redirect:/"; 
	    }

	    String userId = loginUser.getUserId();
	    
	    // 2. 페이징 처리에 필요한 요소 설정
	    int boardLimit = 5;  // [요청사항] 한 페이지에 5개씩
	    int pageLimit = 10;  // 페이징바에 표시할 페이지 수
	    
	 // WebSocketController.java 수정
	    int receivedCount = noteService.selectListCount(userId);      // 받은 쪽지 개수
	    int sentCount = noteService.selectSentListCount(userId);     // 보낸 쪽지 개수 (새로 만든 메서드)

	    
	    // 둘 중 더 큰 값을 listCount로 사용 (두 탭 모두 페이징이 작동하게 함)
	    int listCount = Math.max(receivedCount, sentCount); 


	    ReviewPageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
	    
	    List<Note> receivedList = noteService.selectReceivedNoteList(pi, userId);
	    List<Note> sentList = noteService.selectSentNoteList(pi, userId);
	    
	    
	    // 5. 데이터 담아서 전달
	    model.addAttribute("pi", pi);
	    model.addAttribute("receivedList", receivedList); 
	    model.addAttribute("sentList", sentList);
	    
	    return "websocket/noteList";
	}
	

	
	

}

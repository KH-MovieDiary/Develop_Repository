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
	                       // 1. type 파라미터를 추가로 받습니다. (기본값은 받은 쪽지함인 'received')
	                       @RequestParam(value="type", defaultValue="received") String type, 
	                       HttpSession session, Model model) {
	    
	    Member loginUser = (Member)session.getAttribute("loginUser");
	    if(loginUser == null) {
	        return "redirect:/"; 
	    }
	    String userId = loginUser.getUserId();
	    
	    // 2. 현재 선택된 탭(type)에 따라서만 개수를 세도록 수정 (페이징의 정확도를 위해)
	    int listCount = type.equals("received") ? 
	                    noteService.selectListCount(userId) : 
	                    noteService.selectSentListCount(userId);

	    int boardLimit = 5;  
	    int pageLimit = 10;  

	    ReviewPageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
	    
	    // 3. 리스트 조회 (현재는 두 리스트를 다 가져오지만, 성능을 위해 선택된 것만 가져와도 좋습니다)
	    List<Note> receivedList = noteService.selectReceivedNoteList(pi, userId);
	    List<Note> sentList = noteService.selectSentNoteList(pi, userId);
	    
	    model.addAttribute("pi", pi);
	    model.addAttribute("receivedList", receivedList); 
	    model.addAttribute("sentList", sentList);
	    
	    // 4. 매우 중요: 화면에서 ${type}을 사용할 수 있도록 모델에 담아줍니다.
	    model.addAttribute("type", type);
	    
	    return "websocket/noteList";
	}

	
	

}

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
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	
	@GetMapping("/noteHandler")
	public String noteHandlerPage(@RequestParam(value="targetId", required=false) String targetId, 
	                             HttpSession session, RedirectAttributes ra, HttpServletRequest request, Model model) {
	    
	    Member loginUser = (Member)session.getAttribute("loginUser");
	    
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

        if(loginUser == null) {
            return "fail";
        }
        
        n.setSendNickName(loginUser.getNickName());
        
        int result = noteService.insertNote(n);

        if(result > 0) {
            try {
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
	                         Model model,
	                         HttpSession session) {

	    // 비로그인 차단
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/";
	    }

	    Note n = noteService.selectNoteDetail(nno);

	    if (n != null) {

	        // 받은 사람, 보낸 사람만 열람 가능
	        String loginNick = loginUser.getNickName();

	        boolean isOwner =
	                loginNick != null &&
	                (loginNick.equals(n.getReceiveNickName()) || loginNick.equals(n.getSendNickName()));

	        if (!isOwner) {
	            // 다른 기능 건드리지 않기: 조용히 목록으로 보냄
	            return "redirect:/websocket/noteList?type=" + type;
	        }

	        model.addAttribute("n", n);
	        model.addAttribute("type", type);
	        return "websocket/noteDetail";

	    } else {
	        model.addAttribute("alertMsg", "존재하지 않는 쪽지입니다.");
	        return "redirect:/websocket/noteList?type=" + type;
	    }
	}
	
	
	@ResponseBody
	@RequestMapping(value="/deleteNote", method=RequestMethod.POST)
	public String deleteNote(int nno, HttpSession session) {
		if (session.getAttribute("loginUser") == null) {
            return "fail";
        }
        int result = noteService.deleteNote(nno);
        
        return result > 0 ? "success" : "fail";
	}


	
	

}

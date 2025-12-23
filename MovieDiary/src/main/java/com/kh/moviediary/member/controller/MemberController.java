package com.kh.moviediary.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;



import com.kh.moviediary.member.service.MemberService;
import com.kh.moviediary.member.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@RequestMapping("/mypage.me")
	public String mypage(Model model) {
		return "mypage/mypage";
	}
	
	@RequestMapping("/enrollForm.me")
	public String enrollForm() {
		
		return "member/memberEnrollForm";
	}
	
	@RequestMapping("/updateForm.me")
	public String updateForm() {
		return "member/memberUpdateForm";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/idCheck.me", produces="text/html; charset=utf-8")
	public String idCheck(String inputId) {

		int count = service.idCheck(inputId);

		if(count>0) {
			
			return "NNNNN";
		}else {
			
			return "NNNNY";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="/nickCheck.me", produces="text/html; charset=utf-8")
	public String nickCheck(String nickName) {
		int count = service.nickCheck(nickName);
		
		if(count>0) {
			return "NNNNN";
		}else {
			return "NNNNY";
		}
	}
	
	
	@RequestMapping("/insert.me")
	public String insertMember(Member m, MultipartFile uploadFile, HttpSession session) {
	   
	    m.setUserPwd(bcrypt.encode(m.getUserPwd()));
	    
	    if(uploadFile!=null && !uploadFile.getOriginalFilename().equals("")) { 
		    
	    	String originName=uploadFile.getOriginalFilename();
		    String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		    int ranNum = (int)(Math.random()*90000+10000);
		    String ext = originName.substring(originName.lastIndexOf("."));
		    String changeName = currentTime+ranNum+ext;
		    String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		    
		    try {
				uploadFile.transferTo(new File(savePath+changeName));
				
				m.setPicture("resources/uploadFiles/" + changeName);
				System.out.println("사진 저장 성공");
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("사진 저장 실패");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    } else {
	    	m.setPicture("resources/uploadFiles/default_profile.jpg");
	    }

	    int result = service.insertMember(m);
	    
	    if(result > 0) {
	        session.setAttribute("alertMsg", "회원가입성공");
	        return "redirect:/"; 
	    } else {
	        session.setAttribute("alertMsg", "회원가입실패");
	        return "common/errorPage";
	    }
	}
	
	@RequestMapping("login.me")
	public String loginUser(Member m, HttpSession session, Model model) {
		Member loginUser = service.loginUser(m);
		
		if(loginUser != null && bcrypt.matches(m.getUserPwd(), loginUser.getUserPwd())) {
			session.setAttribute("alertMsg", "로그인 성공");
			session.setAttribute("loginUser", loginUser);
			
			return "redirect:/";
		}else {
			session.setAttribute("alertMsg", "로그인 실패");
			return "mainpage/mainPage";
		}
	}
	
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
	    session.invalidate(); // 세션 무효화 (로그아웃)
	    return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="checkPwd.me", produces="text/html; charset=UTF-8")
	public String checkPassword(String userPwd, HttpSession session) {
	    Member loginUser = (Member)session.getAttribute("loginUser");

	    if(loginUser != null && bcrypt.matches(userPwd, loginUser.getUserPwd())) {
	        return "true";
	    } else {
	        return "false";
	    }
	}
	
	@RequestMapping("update.me")
	public String updateMember(Member m, MultipartFile uploadFile, HttpSession session, Model model) {
		// 1. 새로운 첨부파일(프로필 사진)이 넘어온 경우 처리
	    if(uploadFile != null && !uploadFile.getOriginalFilename().equals("")) {
	        
	        // 기존 파일이 있다면 삭제하는 로직을 추가하면 더 깔끔합니다 (선택사항)
	        
	        String originName = uploadFile.getOriginalFilename();
	        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	        int ranNum = (int)(Math.random() * 90000 + 10000);
	        String ext = originName.substring(originName.lastIndexOf("."));
	        String changeName = currentTime + ranNum + ext;
	        String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
	        
	        try {
	            uploadFile.transferTo(new File(savePath + changeName));
	            // 새로운 경로를 Member 객체에 세팅
	            m.setPicture("resources/uploadFiles/" + changeName);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    } else {
	        // 파일을 새로 올리지 않았다면 기존 사진 경로를 유지해야 합니다.
	        // JSP에서 <input type="hidden" name="picture" value="${loginUser.picture}"> 로 넘겨줘야 함
	    }

	    // 2. 서비스 호출하여 DB 업데이트 (이메일, 생년월일, 성별, 장르, 사진 등)
	    int result = service.updateMember(m);
	    
	    if(result > 0) {
	        // 3. [중요] DB 업데이트 성공 시 세션 정보 갱신
	        // updateMember 서비스 성공 후, 변경된 정보로 다시 DB 조회를 해와야 세션이 최신화됩니다.
	        Member updateMember = service.loginUser(m); 
	        session.setAttribute("loginUser", updateMember);
	        
	        session.setAttribute("alertMsg", "성공적으로 정보가 수정되었습니다.");
	        return "redirect:mypage.me";
	    } else {
	        model.addAttribute("errorMsg", "회원 정보 수정 실패");
	        return "common/errorPage";
	    }
	    
	}
	
	@RequestMapping("delete.me")
	public String deleteMember(String userId, HttpSession session, javax.servlet.http.HttpServletRequest request, Model model) {
	    
	    // STATUS 컬럼을 'N'으로 바꾸는 서비스 호출
	    int result = service.deleteMember(userId);
	    
	    if(result > 0) {
	    	// 1. 기존 세션 파괴 (로그아웃 효과)
	        request.getSession().invalidate();
	        
	        // 2. 새로운 세션 생성 (true를 인자로 주면 새 세션 발급)
	        HttpSession newSession = request.getSession(true);
	        
	        // 3. 새 세션에 알림 메시지 저장
	        newSession.setAttribute("alertMsg", "성공적으로 탈퇴되었습니다. 그동안 이용해주셔서 감사합니다.");
	        
	        return "redirect:/";
	    } else {
	        model.addAttribute("errorMsg", "회원 탈퇴 실패");
	        return "common/errorPage";
	    }
	}
	
	
	

}

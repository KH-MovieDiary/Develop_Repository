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
	public String updateForm(HttpSession session, Model model) {
		
	    Member loginUser = (Member)session.getAttribute("loginUser");

	    if (loginUser == null) {
	    	session.setAttribute("alertMsg", "로그인 후 이용가능합니다.");
	        return "redirect:/";
	    } 
	    

	    if (loginUser.getFavoriteGenre() != null && !loginUser.getFavoriteGenre().equals("")) {
	        java.util.List<String> genreList = java.util.Arrays.asList(loginUser.getFavoriteGenre().split(","));
	        model.addAttribute("genreList", genreList);
	    }
	    
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
	public String insertMember(Member m, String[] favoriteGenre, MultipartFile uploadFile, HttpSession session) {
	   
	    m.setUserPwd(bcrypt.encode(m.getUserPwd()));
	    
	    if (favoriteGenre != null && favoriteGenre.length > 0) {
	        // 배열 ["10751", "27"] -> 문자열 "10751,27" 변환
	        String joinGenres = String.join(",", favoriteGenre);
	        m.setFavoriteGenre(joinGenres);
	    }

	    
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
	        session.setAttribute("alertMsg", "회원가입성공! 로그인 후 이용하시기 바랍니다.");
	        return "redirect:/"; 
	    } else {
	        return "common/errorPage";
	    }
	}
	
	
	@RequestMapping("login.me")
	public String loginUser(Member m, HttpSession session, Model model) {
	    Member loginUser = service.loginUser(m);
	    
	    if(loginUser != null && bcrypt.matches(m.getUserPwd(), loginUser.getUserPwd())) {
	        session.setAttribute("loginUser", loginUser);
	        session.setAttribute("alertMsg", "로그인 성공");
	        return "redirect:/";
	    } else {
	        session.setAttribute("alertMsg", "로그인 실패");
	        return "redirect:/";
	    }
	}
	
	
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
	    session.invalidate();
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
	public String updateMember(Member m, String[] favoriteGenre, MultipartFile uploadFile, HttpSession session, Model model) {

	    if(uploadFile != null && !uploadFile.getOriginalFilename().equals("")) {
	       
	        
	        String originName = uploadFile.getOriginalFilename();
	        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	        int ranNum = (int)(Math.random() * 90000 + 10000);
	        String ext = originName.substring(originName.lastIndexOf("."));
	        String changeName = currentTime + ranNum + ext;
	        String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
	        
	        try {
	            uploadFile.transferTo(new File(savePath + changeName));
	            m.setPicture("resources/uploadFiles/" + changeName);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    } else {

	    }
	    
	    if (favoriteGenre != null && favoriteGenre.length > 0) {
	        String joinGenres = String.join(",", favoriteGenre);
	        
	        if (joinGenres.length() > 100) {
	            joinGenres = joinGenres.substring(0, 100);
	        }
	        
	        m.setFavoriteGenre(joinGenres);
	    } else {
	        m.setFavoriteGenre(null);
	    }
	    
	    int result = service.updateMember(m);
	    
	    if(result > 0) {
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
	   
	    int result = service.deleteMember(userId);
	    
	    if(result > 0) {
	        request.getSession().invalidate();
	        
	        HttpSession newSession = request.getSession(true);
	        
	        newSession.setAttribute("alertMsg", "성공적으로 탈퇴되었습니다. 그동안 이용해주셔서 감사합니다.");
	        
	        return "redirect:/";
	    } else {
	        model.addAttribute("errorMsg", "회원 탈퇴 실패");
	        return "common/errorPage";
	    }
	}
	
	
	

}

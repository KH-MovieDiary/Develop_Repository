package com.kh.moviediary.review.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.kh.moviediary.member.vo.Member;
import com.kh.moviediary.movie.vo.Movie;
import com.kh.moviediary.review.model.vo.Review;
import com.kh.moviediary.review.service.ReviewService;
import com.kh.moviediary.reviewLike.model.vo.Reviewlike;
import com.kh.moviediary.reviewLike.service.ReviewlikeService;

@Controller
public class ReviewController {
	
	@Autowired
	ReviewService service;
	
	@Autowired
	ReviewlikeService likeservice;
	
	@GetMapping("/insert.review")
	public String reviewInsertForm(@RequestParam(value="movieTitle", required=false) String movieTitle,
								   @RequestParam(value="tmdbId", required=false) String movieId,
								   HttpSession session,
								   HttpServletRequest request,
								   Model model){
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		
        if(loginUser == null) {
            session.setAttribute("alertMsg", "로그인 후 이용가능합니다.");
            String referer = request.getHeader("Referer"); 
            return "redirect:" + referer ; 
        }
        
		if(movieTitle != null && movieId != null) {
			model.addAttribute("movieTitle",movieTitle);
			model.addAttribute("movieId",movieId);
		}
		
		return "review/reviewInsert";
	}
	
	@PostMapping("/insert.review")
	public String reviewInsert(Review r, HttpSession session) {
		
		int count = service.countByMovieId(r.getMovieId());
		
		if(count == 0) { 			
			try {
				String apiKey = "7c6e7a1753d67ca027fa6776c3dbba6f";
				
				String url = "https://api.themoviedb.org/3/movie/" + r.getMovieId()
						   + "?api_key=" + apiKey + "&language=ko-KR";
				
				RestTemplate rt = new RestTemplate();
				Map<String, Object> map = rt.getForObject(url, Map.class);
				
				Movie m = new Movie();
				m.setMovieId(r.getMovieId());
				m.setMovieTitle((String)map.get("title"));
				
				String releaseDate = (String)map.get("release_date");
				m.setReleaseDateStr(releaseDate != null ? releaseDate : "");
				
				String content = (map.get("overview") == null) ? "" : String.valueOf(map.get("overview"));
				m.setContent(content);

				float popularity = 0f;
				if (map.get("popularity") != null && !"".equals(String.valueOf(map.get("popularity")))) {
					popularity = Float.parseFloat(String.valueOf(map.get("popularity")));
				}
				m.setPopularity(popularity);
				
				Boolean adult = (Boolean)map.get("adult");
				m.setAdult(adult != null && adult ? "Y" : "N");

				List<Map<String, Object>> genres = (List<Map<String, Object>>) map.get("genres");
				if(genres != null && !genres.isEmpty()) {
					m.setCategory(String.valueOf(genres.get(0).get("name")));
				} else {
					m.setCategory("기타");
				}

				String director = getDirectorFromTmdb(r.getMovieId());
				m.setDirector(director);
				
				service.insertMovie(m);
				
			} catch(Exception e) {
				e.printStackTrace();
				session.setAttribute("alertMsg", "영화 정보를 불러오는데 실패했습니다.");
				return "redirect:/reviewList.bo";
			}
		}

		
		int result = service.reviewInsert(r);
		
		
		if(result>0) {
			session.setAttribute("alertMsg","성공적으로 작성되었습니다!");
		} else {
			session.setAttribute("alertMsg", "감상문 등록에 실패하였습니다");
		}
		
		return "redirect:/reviewList.bo";
	}
	
	@RequestMapping("/detail.review")
	public String reviewDetail(@RequestParam(value="rno") int rno,Model model,HttpSession session,HttpServletRequest request) {
		
		int result = service.increaseCount(rno);
		
		if(result>0) {
			Review r = service.reviewDetail(rno);
			
			String likeYn = "N";
	     
	        Member loginUser = (Member) session.getAttribute("loginUser");
	        
	        if (loginUser != null) {
	            Reviewlike rl = new Reviewlike();
	            rl.setReviewId(rno);
	            rl.setUserId(loginUser.getUserId());

	            String likeResult = likeservice.selectLike(rl); 
	            
	            if (likeResult != null) {
	                likeYn = likeResult;
	            }
	        }
	        
	        session.setAttribute("validNoteTarget", r.getNickname());
	        
			model.addAttribute("review", r);
			model.addAttribute("likeYn", likeYn);
			
			return "review/reviewDetail";
		} else {
			session.setAttribute("alertMsg", "상세보기를 실패하였습니다");
			return "redirect: " + request.getHeader("referer");
		}
	}
	
	@PostMapping("/updateForm.review")
	public String reviewUpdateForm(int rno,Model model) {
		Review r = service.reviewDetail(rno);
		model.addAttribute("review",r);
		return "review/reviewUpdate";
	}
	
	
	@RequestMapping("/update.review")
	public String reviewUpdate(Review r,HttpSession session) {
		
		int result = service.reviewUpdate(r);
		
		if(result>0) {
			session.setAttribute("alertMsg", "수정에 성공하셨습니다");
		} else {
			session.setAttribute("alertMsg", "수정에 실패하였습니다");
		}
		return "redirect:/detail.review?rno="+r.getReviewId();
	}
	
	@PostMapping("/delete.review")
	public String reviewDelete(int rno,HttpSession session) {
		
		int result = service.reviewDelete(rno);
		if(result>0) {
			session.setAttribute("alertMsg", "삭제에 성공하였습니다");
			return "redirect:/reviewList.bo";
		} else {
			session.setAttribute("alertMsg", "삭제에 실패하였습니다");
			return "redirect:/reviewList.bo";
		}
		
	}
	
	private String getDirectorFromTmdb(int tmdbId) {
		if (tmdbId <= 0) return "정보없음";

		try {
			String apiKey = "7c6e7a1753d67ca027fa6776c3dbba6f";
			String url = "https://api.themoviedb.org/3/movie/" + tmdbId + "/credits"
					   + "?api_key=" + apiKey
					   + "&language=ko-KR";

			RestTemplate rt = new RestTemplate();
			Map<String, Object> credits = rt.getForObject(url, Map.class);

			if (credits == null) return "정보없음";

			List<Map<String, Object>> crew = (List<Map<String, Object>>) credits.get("crew");
			if (crew == null) return "정보없음";
			
			StringBuilder directors = new StringBuilder();

			for (Map<String, Object> c : crew) {
				if (c == null) continue;

				Object jobObj = c.get("job");
				if (jobObj == null) continue;

				String job = String.valueOf(jobObj);
				if (!"Director".equalsIgnoreCase(job)) continue;

				String name = (c.get("name") == null) ? "" : String.valueOf(c.get("name"));
				if (name.trim().isEmpty()) continue;

				if (directors.length() > 0) directors.append(", ");
				directors.append(name);
			}
			
			String result = directors.toString();
			return result.isEmpty() ? "정보없음" : result;

		} catch (Exception e) {
			e.printStackTrace();
			return "정보없음";
		}
	}
}

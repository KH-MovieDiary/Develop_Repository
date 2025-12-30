package com.kh.moviediary.mainpage.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.kh.moviediary.mainpage.service.MainPageService;
import com.kh.moviediary.review.model.vo.Review;
import com.kh.moviediary.review.service.ReviewService;

@Controller
public class MainPageController {

    private static final String API_KEY = "7c6e7a1753d67ca027fa6776c3dbba6f";
    private static final String BASE_URL = "https://api.themoviedb.org/3";
    private static final String IMG_URL  = "https://image.tmdb.org/t/p/w500";

    @Autowired
    private MainPageService service;

    @Autowired
    private ReviewService reviewService;
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String mainPage(Model model) {

        String url =
                BASE_URL + "/movie/now_playing"
                + "?api_key=" + API_KEY
                + "&language=ko-KR"
                + "&region=KR"
                + "&page=1";

        RestTemplate rt = new RestTemplate();

        try {
            @SuppressWarnings("unchecked")
            Map<String, Object> result = rt.getForObject(url, Map.class);

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> results = (List<Map<String, Object>>) result.get("results");

            List<Map<String, Object>> top5 = new ArrayList<Map<String, Object>>();

            if (results != null) {
                for (Map<String, Object> m : results) {
                    if (top5.size() >= 20) break;

                    Object idObj = m.get("id");
                    m.put("tmdbId", idObj == null ? "" : String.valueOf(idObj));

                    Object posterPathObj = m.get("poster_path");
                    String posterPath = (posterPathObj == null) ? null : posterPathObj.toString();
                    m.put("posterUrl", (posterPath == null || posterPath.trim().isEmpty() || "null".equals(posterPath))
                            ? "" : IMG_URL + posterPath);

                    Object titleObj = m.get("title");
                    if (titleObj == null) {
                        Object nameObj = m.get("name");
                        m.put("title", nameObj == null ? "" : String.valueOf(nameObj));
                    }

                    top5.add(m);
                }
            }

            model.addAttribute("top5", top5);
            model.addAttribute("top5Size", top5.size());
            model.addAttribute("error", "");

        } catch (Exception e) {
            model.addAttribute("top5", new ArrayList<Map<String, Object>>());
            model.addAttribute("top5Size", 0);
            model.addAttribute("error", "TMDB 호출 실패: " + e.getClass().getName() + " / " + e.getMessage());
        }

        return "mainpage/mainPage";
    }

    @ResponseBody
    @RequestMapping(value="/reviewGet", method=RequestMethod.GET, produces="application/json; charset=UTF-8")
    public List<Review> reviewGet() {
        List<Review> list = service.reviewGet();
        return list;
    }
    
    @ResponseBody
    @RequestMapping(value="/reviewPopularTop5", produces="application/json; charset=UTF-8")
    public List<Review> reviewPopularTop5() {
    	List<Review> list = service.reviewPopularTop5();
    	return list;
    }
    
    @RequestMapping("/reviewDetail")
    public String reviewDetail(@RequestParam("reviewId") int reviewId) {
        return "redirect:/detail.review?rno=" + reviewId;
    }

}

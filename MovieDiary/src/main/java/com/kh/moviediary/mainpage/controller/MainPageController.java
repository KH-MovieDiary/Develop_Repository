package com.kh.moviediary.mainpage.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

@Controller
public class MainPageController {

    private static final String API_KEY = "7c6e7a1753d67ca027fa6776c3dbba6f";
    private static final String BASE_URL = "https://api.themoviedb.org/3";
    private static final String IMG_URL  = "https://image.tmdb.org/t/p/w500";

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String mainPage(Model model) {
    	System.out.println("ggdgzsd");

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

            List<Map<String, Object>> top5 = new ArrayList<Map<String,Object>>();

            if (results != null) {
                for (Map<String, Object> m : results) {
                    if (top5.size() >= 5) break;

                    Object posterPathObj = m.get("poster_path");
                    String posterPath = (posterPathObj == null) ? null : posterPathObj.toString();

                    if (posterPath == null || posterPath.trim().isEmpty() || "null".equals(posterPath)) {
                        m.put("posterUrl", "");
                    } else {
                        m.put("posterUrl", IMG_URL + posterPath);
                    }

                    top5.add(m);
                }
            }

            model.addAttribute("top5", top5);
            model.addAttribute("top5Size", top5.size());
            model.addAttribute("error", "");

        } catch (Exception e) {
            model.addAttribute("top5", new ArrayList<Map<String,Object>>());
            model.addAttribute("top5Size", 0);
            model.addAttribute("error", "TMDB 호출 실패: " + e.getClass().getName() + " / " + e.getMessage());
        }
       

        return "mainpage/mainPage";
    }

}

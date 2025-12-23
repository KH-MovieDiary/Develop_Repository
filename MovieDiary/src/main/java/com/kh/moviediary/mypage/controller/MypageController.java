package com.kh.moviediary.mypage.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.kh.moviediary.member.vo.Member;
import com.kh.moviediary.reviewlist.vo.ReviewList;

@Controller
public class MypageController {

    private static final String API_KEY = "7c6e7a1753d67ca027fa6776c3dbba6f";
    private static final String BASE_URL = "https://api.themoviedb.org/3";
    private static final String IMG_URL  = "https://image.tmdb.org/t/p/w500";

    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {

        // content1 test data
        Member loginUser = Member.builder()
                .userId("testUser01")
                .nickName("테스트유저")
                .birthday("1988-12-05")
                .gender("M")
                .favoriteGenre("액션, SF")
                .picture(null)
                .createDate(new java.sql.Date(System.currentTimeMillis()))
                .build();

        session.setAttribute("loginUser", loginUser);
        model.addAttribute("loginUser", loginUser);
        
        //content3 test data start
        List<ReviewList> myReviewList = new ArrayList<ReviewList>();

        for (int i = 1; i <= 25; i++) {
            ReviewList review = ReviewList.builder()
                    .reviewId(String.valueOf(i))
                    .movieId(1000 + i)
                    .content("테스트 감상평 내용 " + i)
                    .viewCount((int)(Math.random() * 200))
                    .likeCount((int)(Math.random() * 50))
                    .userId(loginUser.getUserId())
                    .createDate(new Date(System.currentTimeMillis()))
                    .build();

            myReviewList.add(review);
        }

        model.addAttribute("myReviewList", myReviewList);
        
        //content4 test data 
        List<Map<String, Object>> myActivityList = new ArrayList<Map<String, Object>>();

        for (int i = 1; i <= 20; i++) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("reviewId", i);
            map.put("activityType", i % 2 == 0 ? "COMMENT" : "LIKE");
            map.put("likeCount", (int)(Math.random() * 100));
            map.put("createDate", new Date(System.currentTimeMillis()));

            myActivityList.add(map);
        }

        model.addAttribute("myActivityList", myActivityList);

        
        // 2️⃣ mainpage에서 쓰던 방식 그대로
        String url =
                BASE_URL + "/movie/now_playing"
                + "?api_key=" + API_KEY
                + "&language=ko-KR"
                + "&region=KR"
                + "&page=1";

        RestTemplate rt = new RestTemplate();
        List<Map<String, Object>> likedMovies = new ArrayList<Map<String, Object>>();

        try {
            @SuppressWarnings("unchecked")
            Map<String, Object> result = rt.getForObject(url, Map.class);

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> results =
                    (List<Map<String, Object>>) result.get("results");

            for (Map<String, Object> m : results) {
                if (likedMovies.size() >= 10) break;

                String posterPath = (String) m.get("poster_path");
                if (posterPath != null) {
                    m.put("posterUrl", IMG_URL + posterPath);
                } else {
                    m.put("posterUrl", "");
                }

                likedMovies.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("likedMovies", likedMovies);

        return "mypage/mypage";
    }
}





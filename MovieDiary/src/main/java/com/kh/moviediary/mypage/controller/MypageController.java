package com.kh.moviediary.mypage.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.moviediary.member.vo.Member;
import com.kh.moviediary.mypage.service.MypageService;
import com.kh.moviediary.tmdb.service.TmdbService;

@Controller
public class MypageController {

    @Autowired
    private MypageService mypageService;

    @Autowired
    private TmdbService tmdbService;

    @GetMapping("/mypage.me")
    public String mypage(HttpSession session, Model model) {

        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login.me";

        String userId = loginUser.getUserId();

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("wishList", mypageService.getWishList(userId));
        model.addAttribute("myReviewList", mypageService.getMyReviewList(userId));
        model.addAttribute("myCommentList", mypageService.getMyCommentList(userId, 10));

        return "mypage/mypage";
    }

    // ✅ 위시리스트 포스터 비동기 로딩용
    @ResponseBody
    @PostMapping(value="/mypage/wishlist/posters", produces="application/json;charset=UTF-8")
    public Map<String, Object> wishlistPosters(@RequestBody Map<String, Object> body,
                                               HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) return Map.of("result", "LOGIN");

        Object idsObj = body.get("movieIds");
        if (!(idsObj instanceof List)) return Map.of("result", "FAIL", "message", "movieIds required");

        @SuppressWarnings("unchecked")
        List<Object> raw = (List<Object>) idsObj;

        List<String> ids = new ArrayList<>();
        for (Object o : raw) {
            if (o == null) continue;
            String s = String.valueOf(o).trim();
            if (!s.isEmpty()) ids.add(s);
        }

        Map<String, String> posters = tmdbService.getPosterUrlsByMovieIds(ids, 40);
        return Map.of("result", "OK", "posters", posters);
    }

    // 댓글 상세(원문 + 좋아요/싫어요 수)
    @ResponseBody
    @GetMapping(value="/mypage/comment/info", produces="application/json;charset=UTF-8")
    public Map<String, Object> commentInfo(@RequestParam int commentId, HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) return Map.of("result", "LOGIN");

        return mypageService.getCommentInfo(commentId, loginUser.getUserId());
    }

    @ResponseBody
    @PostMapping(value="/mypage/comment/delete", produces="text/plain;charset=UTF-8")
    public String deleteComment(@RequestParam int commentId, HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) return "LOGIN";

        int result = mypageService.deleteMyComment(commentId, loginUser.getUserId());
        return (result > 0) ? "OK" : "FAIL";
    }
}

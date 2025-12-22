package com.kh.moviediary.movie.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.kh.moviediary.common.MoviePageInfo;

@Controller
public class MovieController {

    private static final String API_KEY = "7c6e7a1753d67ca027fa6776c3dbba6f";
    private static final String BASE_URL = "https://api.themoviedb.org/3";
    private static final String IMG_URL  = "https://image.tmdb.org/t/p/w500";

    // ====== 간단 메모리 캐시 (속도용) ======
    // key: "page|genre|sort" -> value: response map
    private static final Map<String, CacheEntry> CACHE = new HashMap<String, CacheEntry>();
    private static final long CACHE_TTL_MS = 60000; // 60초 캐시 

    private static class CacheEntry {
        long savedAt;
        Map<String, Object> data;
        CacheEntry(long savedAt, Map<String, Object> data) {
            this.savedAt = savedAt;
            this.data = data;
        }
    }

    @GetMapping("/movieInfo.mo")
    public String movieInfo(
            @RequestParam(value="cPage", defaultValue="1") int cPage,
            @RequestParam(value="genreId", required=false) Integer genreId,
            @RequestParam(value="sort", defaultValue="release_date") String sort,
            Model model
    ) {
        // ====== 정렬 매핑 ======
        // release_date: 최신 개봉순, popularity: 인기순, vote_average: 평점순(기본TMDB) 등
        String sortBy;
        if ("popularity".equalsIgnoreCase(sort)) {
            sortBy = "popularity.desc";
        } else if ("vote_average".equalsIgnoreCase(sort) || "rating".equalsIgnoreCase(sort)) {
            sortBy = "vote_average.desc";
        } else {
            // release_date
            sortBy = "primary_release_date.desc";
        }

        // ====== 캐시 키 ======
        String cacheKey = cPage + "|" + (genreId == null ? "-" : genreId) + "|" + sortBy;

        CacheEntry ce = CACHE.get(cacheKey);
        if (ce != null && (System.currentTimeMillis() - ce.savedAt) < CACHE_TTL_MS) {
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> movies = (List<Map<String, Object>>) ce.data.get("movies");
            MoviePageInfo pageInfo = (MoviePageInfo) ce.data.get("pageInfo");

            model.addAttribute("movies", movies);
            model.addAttribute("pi", pageInfo);
            model.addAttribute("genreId", genreId);
            model.addAttribute("sort", sort);
            model.addAttribute("error", "");
            return "movie/movieInfo";
        }

        // ====== TMDB Discover로 "한국영화만" ======
        // 핵심: with_original_language=ko 로 한국어 원어 영화 위주~멍♡
        // 추가: with_origin_country=KR 는 TMDB에서 동작하는 경우가 많지만, 환경/버전에 따라 무시될 수 있어~멍♡
        // -> 둘 다 붙여서 "한국영화"로 최대한 강하게 제한~멍♡
        // NOTE: TMDB는 성인 제외 include_adult=false~멍♡
        String baseDiscover =
                BASE_URL + "/discover/movie"
                + "?api_key=" + API_KEY
                + "&language=ko-KR"
                + "&include_adult=false"
                + "&with_original_language=ko"
                + "&with_origin_country=KR"
                + "&sort_by=" + sortBy;

        if (genreId != null) {
            baseDiscover += "&with_genres=" + genreId;
        }

        // “최신 기준 300개” 같은 요구가 있으면 실제로는 여러 페이지지만,
        // 화면은 15개씩 페이징이니까 여기선 현재 페이지만 뽑아오면됨
        // 단, 포스터 없는 영화는 스킵하므로 15개를 채우기 위해 1~3페이지 더 훑을 수 있음
        RestTemplate rt = new RestTemplate();

        List<Map<String, Object>> pageMovies = new ArrayList<Map<String, Object>>();
        int fetchPage = cPage;      // TMDB page
        int fetchTries = 0;         // 최대 3번 추가 호출 제한
        int tmdbTotalResults = 0;   // 전체 결과
        int tmdbTotalPages = 0;

        try {
            while (pageMovies.size() < 15 && fetchTries < 3) {
                String url = baseDiscover + "&page=" + fetchPage;

                @SuppressWarnings("unchecked")
                Map<String, Object> result = rt.getForObject(url, Map.class);

                if (result == null) break;

                Object tr = result.get("total_results");
                Object tp = result.get("total_pages");
                if (tr instanceof Number) tmdbTotalResults = ((Number) tr).intValue();
                if (tp instanceof Number) tmdbTotalPages = ((Number) tp).intValue();

                @SuppressWarnings("unchecked")
                List<Map<String, Object>> results = (List<Map<String, Object>>) result.get("results");
                if (results == null || results.isEmpty()) break;

                for (Map<String, Object> m : results) {
                    if (pageMovies.size() >= 15) break;

                    // 포스터 없는 영화는 아예 제외
                    Object posterPathObj = m.get("poster_path");
                    String posterPath = (posterPathObj == null) ? null : posterPathObj.toString();
                    if (posterPath == null || posterPath.trim().isEmpty() || "null".equals(posterPath)) {
                        continue;
                    }

                    // JSP에서 쓰기 쉽게 posterUrl 생성
                    m.put("posterUrl", IMG_URL + posterPath);

                    // title이 null이면 name/original_title fallback
                    Object titleObj = m.get("title");
                    if (titleObj == null || String.valueOf(titleObj).trim().isEmpty()) {
                        Object ot = m.get("original_title");
                        m.put("title", ot == null ? "제목 없음" : String.valueOf(ot));
                    }

                    pageMovies.add(m);
                }

                fetchPage++;
                fetchTries++;
                if (tmdbTotalPages > 0 && fetchPage > tmdbTotalPages) break;
            }

            // ====== 페이징 계산(15개/페이지, 버튼 5개) ======
            // TMDB total_results는 “포스터 없는 것 포함”이라 실제 표시 수와 약간 어긋날 수 있어
            // 그래도 페이지바 목적으론 충분
            MoviePageInfo pi = buildPageInfo(tmdbTotalResults, cPage, 5, 15);

            
            model.addAttribute("movies", pageMovies);
            model.addAttribute("pi", pi);
            model.addAttribute("genreId", genreId);
            model.addAttribute("sort", sort);
            model.addAttribute("error", "");

            // 캐시 저장
            Map<String, Object> cacheData = new HashMap<String, Object>();
            cacheData.put("movies", pageMovies);
            cacheData.put("pageInfo", pi);
            CACHE.put(cacheKey, new CacheEntry(System.currentTimeMillis(), cacheData));

        } catch (Exception e) {
            model.addAttribute("movies", new ArrayList<Map<String, Object>>());
            model.addAttribute("pi", buildPageInfo(0, 1, 5, 15));
            model.addAttribute("genreId", genreId);
            model.addAttribute("sort", sort);
            model.addAttribute("error", "TMDB 호출 실패: " + e.getClass().getName() + " / " + e.getMessage());
        }

        return "movie/movieInfo";
    }

    // ====== pageInfo 계산 유틸 ======
    // listCount: 전체 결과수(대충), currentPage: 현재페이지, pageLimit: 5, movieLimit: 15
    private MoviePageInfo buildPageInfo(int listCount, int currentPage, int pageLimit, int movieLimit) {
        MoviePageInfo pi = new MoviePageInfo();
        pi.setListCount(listCount);
        pi.setCurrentPage(currentPage);
        pi.setPageLimit(pageLimit);
        pi.setMovieLimit(movieLimit);

        int maxPage = (int) Math.ceil((double) listCount / movieLimit);
        if (maxPage < 1) maxPage = 1;

        int startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;
        if (endPage > maxPage) endPage = maxPage;

        pi.setMaxPage(maxPage);
        pi.setStartPage(startPage);
        pi.setEndPage(endPage);
        return pi;
    }
}

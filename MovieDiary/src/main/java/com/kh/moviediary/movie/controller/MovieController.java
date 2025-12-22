package com.kh.moviediary.movie.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.kh.moviediary.common.MoviePageInfo;

@Controller
public class MovieController {

    private static final String API_KEY = "7c6e7a1753d67ca027fa6776c3dbba6f";
    private static final String BASE_URL = "https://api.themoviedb.org/3";
    private static final String IMG_URL  = "https://image.tmdb.org/t/p/w500";

    private static final Map<String, CacheEntry> CACHE = new HashMap<String, CacheEntry>();
    private static final long CACHE_TTL_MS = 60000; // 60초


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
        String sortBy;
        if ("popularity".equalsIgnoreCase(sort)) {
            sortBy = "popularity.desc";
        } else if ("vote_average".equalsIgnoreCase(sort) || "rating".equalsIgnoreCase(sort)) {
            sortBy = "vote_average.desc";
        } else {
            sortBy = "primary_release_date.desc";
        }

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

        RestTemplate rt = new RestTemplate();

        List<Map<String, Object>> pageMovies = new ArrayList<Map<String, Object>>();
        int fetchPage = cPage;
        int fetchTries = 0;
        int tmdbTotalResults = 0;

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

                    // 포스터 없는 영화 제외
                    Object posterPathObj = m.get("poster_path");
                    String posterPath = (posterPathObj == null) ? null : posterPathObj.toString();
                    if (posterPath == null || posterPath.trim().isEmpty() || "null".equals(posterPath)) {
                        continue;
                    }
                    m.put("posterUrl", IMG_URL + posterPath);

                    Object titleObj = m.get("title");
                    if (titleObj == null || String.valueOf(titleObj).trim().isEmpty()) {
                        Object ot = m.get("original_title");
                        m.put("title", ot == null ? "제목 없음" : String.valueOf(ot));
                    }

                    Object idObj = m.get("id");
                    if (idObj instanceof Number) {
                        m.put("tmdbId", String.valueOf(((Number) idObj).intValue())); // "829202"
                    } else {
                        m.put("tmdbId", String.valueOf(idObj)); // fallback
                    }

                    pageMovies.add(m);
                }

                fetchPage++;
                fetchTries++;
                if (tmdbTotalPages > 0 && fetchPage > tmdbTotalPages) break;
            }

            MoviePageInfo pi = buildPageInfo(tmdbTotalResults, cPage, 5, 15);

            model.addAttribute("movies", pageMovies);
            model.addAttribute("pi", pi);
            model.addAttribute("genreId", genreId);
            model.addAttribute("sort", sort);
            model.addAttribute("error", "");


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
    @ResponseBody
    @GetMapping("/tmdb/movieDetail.mo")
    public Map<String, Object> tmdbMovieDetail(
            @RequestParam("tmdbId") String tmdbIdRaw) {

        String tmdbId = tmdbIdRaw;
        if (tmdbId.contains(".")) {
            tmdbId = tmdbId.substring(0, tmdbId.indexOf('.'));
        }

        Map<String, Object> res = new HashMap<String, Object>();
        RestTemplate rt = new RestTemplate();

        try {
            String url =
                    BASE_URL + "/movie/" + tmdbId
                    + "?api_key=" + API_KEY
                    + "&language=ko-KR";

            @SuppressWarnings("unchecked")
            Map<String, Object> data = rt.getForObject(url, Map.class);

            Object posterPathObj = data.get("poster_path");
            if (posterPathObj != null) {
                data.put("posterUrl", IMG_URL + posterPathObj);
            }

            res.put("ok", true);
            res.putAll(data);

        } catch (Exception e) {
            res.put("ok", false);
            res.put("message", e.getMessage());
        }

        return res;
    }

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

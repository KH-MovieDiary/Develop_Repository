package com.kh.moviediary.movie.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    private static final long CACHE_TTL_MS = 60_000;

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
            @RequestParam(value="keyword", required=false, defaultValue="") String keyword,
            Model model
    ) {

        String kw = (keyword == null) ? "" : keyword.trim();

        String sortBy;
        if ("popularity".equalsIgnoreCase(sort)) {
            sortBy = "popularity.desc";
        } else if ("vote_average".equalsIgnoreCase(sort) || "rating".equalsIgnoreCase(sort)) {
            sortBy = "vote_average.desc";
        } else {
            sortBy = "primary_release_date.desc";
        }

        String cacheKey = cPage + "|" + (genreId == null ? "-" : genreId) + "|" + sortBy + "|" + kw;

        CacheEntry ce = CACHE.get(cacheKey);
        if (ce != null && (System.currentTimeMillis() - ce.savedAt) < CACHE_TTL_MS) {

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> movies =
                    (List<Map<String, Object>>) ce.data.get("movies");

            MoviePageInfo pageInfo =
                    (MoviePageInfo) ce.data.get("pageInfo");

            model.addAttribute("movies", movies);
            model.addAttribute("pi", pageInfo);
            model.addAttribute("genreId", genreId);
            model.addAttribute("sort", sort);
            model.addAttribute("keyword", kw);
            model.addAttribute("error", "");

            return "movie/movieInfo";
        }

        RestTemplate rt = new RestTemplate();

        List<Map<String, Object>> pageMovies = new ArrayList<>();
        int fetchPage = cPage;
        int fetchTries = 0;
        int tmdbTotalResults = 0;
        int tmdbTotalPages = 0;

        try {
            while (pageMovies.size() < 15 && fetchTries < 3) {

                String url;

                if (!kw.isEmpty()) {
                    url =
                        BASE_URL + "/search/movie"
                        + "?api_key=" + API_KEY
                        + "&language=ko-KR"
                        + "&include_adult=false"
                        + "&query=" + urlEncode(kw)
                        + "&page=" + fetchPage;

                } else {
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

                    url = baseDiscover + "&page=" + fetchPage;
                }

                @SuppressWarnings("unchecked")
                Map<String, Object> result = rt.getForObject(url, Map.class);

                if (result == null) break;

                Object tr = result.get("total_results");
                Object tp = result.get("total_pages");

                if (tr instanceof Number) tmdbTotalResults = ((Number) tr).intValue();
                if (tp instanceof Number) tmdbTotalPages = ((Number) tp).intValue();

                @SuppressWarnings("unchecked")
                List<Map<String, Object>> results =
                        (List<Map<String, Object>>) result.get("results");

                if (results == null || results.isEmpty()) break;

                for (Map<String, Object> m : results) {
                    if (pageMovies.size() >= 15) break;

                    String posterPath = (m.get("poster_path") == null) ? null : String.valueOf(m.get("poster_path"));
                    if (posterPath == null || posterPath.trim().isEmpty() || "null".equalsIgnoreCase(posterPath)) continue;

                    m.put("posterUrl", IMG_URL + posterPath);

                    if (m.get("title") == null || String.valueOf(m.get("title")).isBlank()) {
                        m.put("title",
                                m.get("original_title") == null
                                        ? "제목 없음"
                                        : m.get("original_title"));
                    }

                    Object idObj = m.get("id");
                    if (idObj instanceof Number) {
                        m.put("tmdbId", ((Number) idObj).intValue());
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
            model.addAttribute("keyword", kw);
            model.addAttribute("error", "");

            Map<String, Object> cacheData = new HashMap<>();
            cacheData.put("movies", pageMovies);
            cacheData.put("pageInfo", pi);

            CACHE.put(cacheKey, new CacheEntry(System.currentTimeMillis(), cacheData));

        } catch (Exception e) {

            model.addAttribute("movies", new ArrayList<>());
            model.addAttribute("pi", buildPageInfo(0, 1, 5, 15));
            model.addAttribute("genreId", genreId);
            model.addAttribute("sort", sort);
            model.addAttribute("keyword", kw);
            model.addAttribute("error",
                    "TMDB 호출 실패: " + e.getClass().getName() + " / " + e.getMessage());
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

        Map<String, Object> res = new HashMap<>();
        RestTemplate rt = new RestTemplate();

        try {
            String url =
                    BASE_URL + "/movie/" + tmdbId
                    + "?api_key=" + API_KEY
                    + "&language=ko-KR";

            @SuppressWarnings("unchecked")
            Map<String, Object> data = rt.getForObject(url, Map.class);

            if (data.get("poster_path") != null) {
                data.put("posterUrl", IMG_URL + data.get("poster_path"));
            }

            res.put("ok", true);
            res.putAll(data);

        } catch (Exception e) {
            res.put("ok", false);
            res.put("message", e.getMessage());
        }

        return res;
    }

    private MoviePageInfo buildPageInfo(
            int listCount,
            int currentPage,
            int pageLimit,
            int movieLimit) {

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

    @ResponseBody
    @GetMapping("/tmdb/movieCredits.mo")
    public Map<String, Object> tmdbMovieCredits(@RequestParam("tmdbId") String tmdbIdRaw) {

        String tmdbId = tmdbIdRaw;
        if (tmdbId.contains(".")) {
            tmdbId = tmdbId.substring(0, tmdbId.indexOf('.'));
        }

        Map<String, Object> res = new HashMap<>();
        RestTemplate rt = new RestTemplate();

        try {
            String url =
                    BASE_URL + "/movie/" + tmdbId + "/credits"
                    + "?api_key=" + API_KEY
                    + "&language=ko-KR";

            @SuppressWarnings("unchecked")
            Map<String, Object> data = rt.getForObject(url, Map.class);

            StringBuilder directors = new StringBuilder();

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> crew = (List<Map<String, Object>>) data.get("crew");
            if (crew != null) {
                for (Map<String, Object> c : crew) {
                    String job = (c.get("job") == null) ? "" : String.valueOf(c.get("job"));
                    if ("Director".equalsIgnoreCase(job)) {
                        String name = (c.get("name") == null) ? "" : String.valueOf(c.get("name"));
                        if (!name.isBlank()) {
                            if (directors.length() > 0) directors.append(", ");
                            directors.append(name);
                        }
                    }
                }
            }

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> cast = (List<Map<String, Object>>) data.get("cast");
            List<String> actorNames = new java.util.ArrayList<>();
            if (cast != null) {
                int limit = Math.min(8, cast.size());
                for (int i = 0; i < limit; i++) {
                    Map<String, Object> a = cast.get(i);
                    if (a == null) continue;
                    String name = (a.get("name") == null) ? "" : String.valueOf(a.get("name"));
                    if (!name.isBlank()) actorNames.add(name);
                }
            }

            res.put("ok", true);
            res.put("director", directors.length() == 0 ? "-" : directors.toString());
            res.put("actors", actorNames);

        } catch (Exception e) {
            res.put("ok", false);
            res.put("message", e.getMessage());
        }

        return res;
    }

    private String urlEncode(String s) {
        try {
            return java.net.URLEncoder.encode(s, "UTF-8");
        } catch (Exception e) {
            return s;
        }
    }
}

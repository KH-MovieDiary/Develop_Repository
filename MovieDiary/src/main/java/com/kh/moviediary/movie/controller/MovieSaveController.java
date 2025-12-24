package com.kh.moviediary.movie.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.kh.moviediary.movie.service.MovieService;
import com.kh.moviediary.movie.vo.Movie;

@Controller
public class MovieSaveController {

    private static final String API_KEY  = "7c6e7a1753d67ca027fa6776c3dbba6f";
    private static final String BASE_URL = "https://api.themoviedb.org/3";

    @Autowired
    private MovieService movieService;

    @ResponseBody
    @RequestMapping(
        value="/movie/saveFromTmdb.mo",
        method=RequestMethod.POST,
        produces="application/json; charset=UTF-8"
    )
    public Map<String, Object> saveFromTmdb(@RequestBody Map<String, Object> body) {

        Map<String, Object> res = new HashMap<>();

        try {
            int tmdbId = parseIntFromBody(body.get("tmdbId"));
            String title = (body.get("title") == null) ? "" : String.valueOf(body.get("title"));
            String category = (body.get("category") == null) ? "" : String.valueOf(body.get("category"));
            String adult = (body.get("adult") == null) ? "N" : String.valueOf(body.get("adult"));
            String releaseDate = (body.get("releaseDate") == null) ? "" : String.valueOf(body.get("releaseDate"));
            String content = (body.get("content") == null) ? "" : String.valueOf(body.get("content"));

            float popularity = 0f;
            if (body.get("popularity") != null && !"".equals(String.valueOf(body.get("popularity")))) {
                popularity = Float.parseFloat(String.valueOf(body.get("popularity")));
            }

            String director = fetchDirectorFromTmdbCredits(tmdbId);

            Movie movie = Movie.builder()
                    .movieId(tmdbId)
                    .movieTitle(title)
                    .category(category)
                    .director(director)
                    .adult(adult)
                    .releaseDateStr(releaseDate)
                    .popularity(popularity)
                    .ratingScore(0f)
                    .reviewCount(0)
                    .likeCount(0)
                    .dislikeCount(0)
                    .content(content)
                    .build();

            int result = movieService.insertMovieIfNotExists(movie);

            res.put("ok", true);
            res.put("inserted", result == 1);
            res.put("message", (result == 1) ? "inserted" : "already exists");
            res.put("director", director);

        } catch (Exception e) {
            e.printStackTrace();
            res.put("ok", false);
            res.put("message", e.getClass().getName() + " / " + e.getMessage());
        }

        return res;
    }

    private String fetchDirectorFromTmdbCredits(int tmdbId) {
        if (tmdbId <= 0) return "";

        try {
            RestTemplate rt = new RestTemplate();
            String url = BASE_URL + "/movie/" + tmdbId + "/credits"
                    + "?api_key=" + API_KEY
                    + "&language=ko-KR";

            @SuppressWarnings("unchecked")
            Map<String, Object> credits = rt.getForObject(url, Map.class);

            if (credits == null) return "";

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> crew = (List<Map<String, Object>>) credits.get("crew");
            if (crew == null) return "";
            StringBuilder directors = new StringBuilder();

            for (Map<String, Object> c : crew) {
                if (c == null) continue;

                Object jobObj = c.get("job");
                if (jobObj == null) continue;

                String job = String.valueOf(jobObj);
                if (!"Director".equalsIgnoreCase(job)) continue;

                String name = (c.get("name") == null) ? "" : String.valueOf(c.get("name"));
                if (name.isBlank()) continue;

                if (directors.length() > 0) directors.append(", ");
                directors.append(name);
            }

            return directors.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    private int parseIntFromBody(Object obj) {
        if (obj == null) return 0;

        if (obj instanceof Number) {
            return ((Number) obj).intValue();
        }

        String s = String.valueOf(obj).trim();
        if (s.isEmpty() || "null".equalsIgnoreCase(s)) return 0;

        if (s.contains(".")) {
            s = s.substring(0, s.indexOf('.'));
        }

        return Integer.parseInt(s);
    }
}

package com.kh.moviediary.tmdb.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class TmdbServiceImpl implements TmdbService {

    private final RestTemplate rt = new RestTemplate();

    // (권장) properties에서 읽기
    @Value("${tmdb.apiKey:}")
    private String apiKey;

    @Value("${tmdb.baseUrl:https://api.themoviedb.org/3}")
    private String baseUrl;

    @Value("${tmdb.imgUrl:https://image.tmdb.org/t/p/w500}")
    private String imgUrl;

    @Value("${tmdb.lang:ko-KR}")
    private String lang;

    @Override
    public Map<String, String> getPosterUrlsByMovieIds(List<String> movieIds, int limit) {

        Map<String, String> posters = new HashMap<>();
        if (movieIds == null || movieIds.isEmpty()) return posters;

        int n = Math.min(movieIds.size(), limit);

        for (int i = 0; i < n; i++) {
            String movieId = movieIds.get(i);
            if (movieId == null) continue;

            movieId = movieId.trim();
            if (movieId.isEmpty()) continue;

            posters.put(movieId, fetchPosterUrl(movieId));
        }

        return posters;
    }

    private String fetchPosterUrl(String movieId) {
        // apiKey가 비어있으면 실패 처리
        if (apiKey == null || apiKey.trim().isEmpty()) return "";

        try {
            String url = baseUrl + "/movie/" + movieId
                       + "?api_key=" + apiKey
                       + "&language=" + lang;

            @SuppressWarnings("unchecked")
            Map<String, Object> detail = rt.getForObject(url, Map.class);

            Object posterPathObj = (detail == null) ? null : detail.get("poster_path");
            String posterPath = (posterPathObj == null) ? "" : String.valueOf(posterPathObj);

            return toPosterUrl(posterPath);

        } catch (Exception e) {
            return "";
        }
    }

    private String toPosterUrl(String posterPath) {
        if (posterPath == null) return "";
        posterPath = posterPath.trim();
        if (posterPath.isEmpty() || "null".equalsIgnoreCase(posterPath)) return "";
        return imgUrl + posterPath;
    }
}

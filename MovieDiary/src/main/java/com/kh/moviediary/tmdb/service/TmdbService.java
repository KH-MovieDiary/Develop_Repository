package com.kh.moviediary.tmdb.service;

import java.util.List;
import java.util.Map;

public interface TmdbService {

    /**
     * movieIds를 받아 posterUrl map으로 반환
     * - key: movieId(String)
     * - value: posterUrl(String, 없으면 "")
     */
    Map<String, String> getPosterUrlsByMovieIds(List<String> movieIds, int limit);
}

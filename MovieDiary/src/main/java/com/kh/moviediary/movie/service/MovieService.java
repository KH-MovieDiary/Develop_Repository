package com.kh.moviediary.movie.service;

import com.kh.moviediary.movie.vo.Movie;


public interface MovieService {

	int insertMovie(Movie movie);
	
	int insertMovieIfNotExists(Movie movie);
}

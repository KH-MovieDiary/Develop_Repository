package com.kh.moviediary.movie.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moviediary.movie.dao.MovieDao;
import com.kh.moviediary.movie.vo.Movie;

@Service
public class MovieServiceImpl implements MovieService{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MovieDao dao;

	@Override
	public int insertMovie(Movie movie) {
		return dao.insertMovie(sqlSession, movie);
	}

	@Override
    public int insertMovieIfNotExists(Movie movie) {
        int exists = dao.insertMovieIfNotExists(sqlSession, movie.getMovieId());
        if (exists > 0) {
            return 0; 
        }
        return dao.insertMovie(sqlSession, movie);
    }
}

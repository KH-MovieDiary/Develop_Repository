package com.kh.moviediary.movie.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moviediary.movie.vo.Movie;

@Repository
public class MovieDao {
	
	public int insertMovie(SqlSessionTemplate sqlSession, Movie movie) {
		System.out.println("insertMovie");
		return sqlSession.insert("movieMapper.insertMovie", movie);
	}
	public int insertMovieIfNotExists(SqlSessionTemplate sqlSession, int movieId) {
        Integer cnt = sqlSession.selectOne("movieMapper.countByMovieId", movieId);
        return (cnt == null) ? 0 : cnt.intValue();
    }
}

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tmdb/data/models/movie.dart';
import 'package:flutter_tmdb/data/network_repositories/abstract_movie_api.dart';

import '../db/movie_dao.dart';

class MovieRepository implements AbstractMovieApi{
  static const _baseUrl = 'https://api.themoviedb.org/3';

  final MovieDao _movieDao = MovieDao();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    queryParameters: {'api_key': dotenv.env['API_KEY']!},
    contentType: 'application/json',
  ));

  @override
  Future<List<Movie>> getMovieList() async {
    try{
      final response = await _dio.get('/movie/popular');
      final List<Movie> movies = [];
      for (var movieJson in response.data['results']) {
        final movie = Movie.fromJson(movieJson);
        await movie.downloadImage(movie.id);
        movies.add(movie);
      }
      await _movieDao.clearTable();
      await _movieDao.saveMovies(movies);
      return movies;
    } on DioError catch(e){
      if (e.type == DioErrorType.unknown) {
        // No internet connection, try to fetch from database
        final moviesFromDb = await _movieDao.getAllMovies();
        return moviesFromDb;
      } else {
        throw Exception('Failed to fetch movie data from API.');
      }
    } catch (e) {
      throw Exception('Failed to fetch movie data.');
    }
  }

  @override
  Future<Movie?> getMovieDetails(int id) async{
    try{
      final response = await _dio.get('/movie/$id');
      final movieDetails = Movie.fromJson(response.data);
      return movieDetails;
    }on DioError catch(e){
      final Movie? movie = await _movieDao.getMovieById(id);
      return movie;
    }


  }
}
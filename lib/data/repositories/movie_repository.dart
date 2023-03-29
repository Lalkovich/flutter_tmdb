import 'package:dio/dio.dart';
import 'package:flutter_tmdb/data/models/movie.dart';
import 'package:flutter_tmdb/data/repositories/abstract_movie_api.dart';

class MovieRepository implements AbstractMovieApi{
  static const _apiKey = 'd86412600ac9f3c72d6fe1e52afa68e5';
  static const _baseUrl = 'https://api.themoviedb.org/3';

  final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    queryParameters: {'api_key':_apiKey},
    contentType: 'application/json',
  ));

  @override
  Future<List<Movie>> getMovieList() async {
    try{
      final response = await _dio.get('/movie/popular');
      final data = response.data['results'] as List<dynamic>;
      final movies = data.map((json) => Movie.fromJson(json)).toList();
      return movies;
    } on DioError catch(error){
      throw Exception('Failed to get movies: ${error.message}');
    }
  }

  @override
  Future<Movie> getMovieDetails(int id) async{
    final response = await _dio.get('/movie/$id');
    if(response.statusCode == 200){
      final movieDetails = Movie.fromJson(response.data);
      return movieDetails;
    }else{
      throw Exception('Failed to load movie details');
    }
  }
}
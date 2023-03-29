import 'package:flutter_tmdb/data/models/movie.dart';

abstract class AbstractMovieApi{
  Future<dynamic> getMovieList();
  Future<Movie> getMovieDetails(int id);
}


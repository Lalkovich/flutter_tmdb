part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class GetMovieDetails extends MovieEvent {
  final int movieId;

  GetMovieDetails(this.movieId);
}

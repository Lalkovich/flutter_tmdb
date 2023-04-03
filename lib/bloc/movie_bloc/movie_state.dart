part of 'movie_bloc.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieDetailsLoading extends MovieState {}

class MovieDetailsLoaded extends MovieState {
  final Movie? movieDetails;

  MovieDetailsLoaded(this.movieDetails);
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}

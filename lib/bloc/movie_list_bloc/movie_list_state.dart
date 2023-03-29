part of 'movie_list_bloc.dart';

abstract class MovieListState{}

class MovieListInitial extends MovieListState {

}

class MovieListLoading extends MovieListState {

}

class MovieListLoaded extends MovieListState  {
  final List<Movie> movieList;

  MovieListLoaded(this.movieList);
}

class MovieListError extends MovieListState{
  final String message;

  MovieListError(this.message);
}

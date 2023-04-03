import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_tmdb/data/models/movie.dart';
import 'package:flutter_tmdb/data/network_repositories/movie_repository.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_tmdb/main.dart';

part 'movie_event.dart';
part 'movie_state.dart';

@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository = locator.get<MovieRepository>();
  MovieBloc() : super(MovieInitial()) {
    on<GetMovieDetails>(_onGetMovieDetails);
  }

  Future<void> _onGetMovieDetails(GetMovieDetails event,Emitter<MovieState> emit)async {
    emit(MovieDetailsLoading());
    try{
      final movie = await _movieRepository.getMovieDetails(event.movieId);
      emit(MovieDetailsLoaded(movie!));
    }catch(error){
      emit(MovieError(error.toString()));
    }
  }

}

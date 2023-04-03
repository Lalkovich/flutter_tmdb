import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_tmdb/data/models/movie.dart';
import 'package:flutter_tmdb/data/network_repositories/movie_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_tmdb/main.dart';

part 'movie_list_event.dart';

part 'movie_list_state.dart';

@injectable
class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository _movieRepository = locator.get<MovieRepository>();

  MovieListBloc() : super(MovieListInitial()){
    on<LoadMovieList>(_load);
  }

   Future<void> _load(LoadMovieList event,Emitter<MovieListState> emit) async{
      emit(MovieListLoading());
      try{
        final movies = await _movieRepository.getMovieList();
        emit(MovieListLoaded(movies));
      }catch(error){
        emit(MovieListError('Failed to get movies: $error'));
      }
   }

}

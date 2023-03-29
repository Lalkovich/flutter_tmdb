import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:flutter_tmdb/main.dart';
import 'package:flutter_tmdb/ui/movie_list/movie_tile.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}): super(key:key);

  @override
  State<StatefulWidget> createState() => _MovieListState();
}

class _MovieListState extends State<MovieListScreen> {

  final MovieListBloc _movieListBloc = locator.get<MovieListBloc>();

  @override
  void initState() {
    _movieListBloc.add(LoadMovieList());
    super.initState();
  }

  @override
  void dispose(){
    _movieListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
      ),
      body:BlocBuilder<MovieListBloc,MovieListState>(
        bloc: _movieListBloc,
        builder: (context,state){
          if(state is MovieListLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is MovieListLoaded){
            final movies = state.movieList;
            return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final movie = movies[index];
                  return MovieTile(movie: movie);
                });
          }else if(state is MovieListInitial){
            return const Center(
              child: Text('Movie List Initial'),
            );
        }else if(state is MovieListError){
            return const Center(
              child: Text('Failed to fetch movies'),
            );
          }else{
            return const Center(
              child: Text("Unknown state"),
            );
          }
        },
      )
    );
  }
}

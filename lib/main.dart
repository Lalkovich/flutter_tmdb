import 'package:flutter/material.dart';
import 'package:flutter_tmdb/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:flutter_tmdb/data/repositories/movie_repository.dart';
import 'package:flutter_tmdb/ui/movie_list/movie_list.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void main() async {
  locator.registerSingleton<MovieRepository>(MovieRepository());
  locator.registerLazySingleton(() => MovieListBloc());
  locator.registerLazySingleton(() => MovieBloc());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MovieListScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

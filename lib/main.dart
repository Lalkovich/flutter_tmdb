import 'package:flutter/material.dart';
import 'package:flutter_tmdb/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:flutter_tmdb/data/db/movie_dao.dart';
import 'package:flutter_tmdb/data/network_repositories/movie_repository.dart';
import 'package:flutter_tmdb/ui/movie_list/movie_list.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
GetIt locator = GetIt.instance;

void main() async {
  await dotenv.load(fileName: "flutter_dotenv.env");
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

import 'dart:convert';

import 'package:flutter_tmdb/data/db/movie_database.dart';
import 'package:flutter_tmdb/data/models/movie.dart';
import 'package:sqflite/sqflite.dart';

class MovieDao {
  final dbProvider = MovieDatabase.instance;

  Future<void> clearTable() async {
    final db = await dbProvider.database;
    await db.delete('movies');
  }

  Future<int> createMovie(Movie movie) async {
    final db = await dbProvider.database;
    return db.insert('movies', movie.toJson());
  }

  Future<List<Movie>> getAllMovies() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('movies');
    return List.generate(maps.length, (i) {
      final movie = Movie.fromJson(maps[i]);
      if(movie.imageData != null && movie.imageData!.isNotEmpty){
        return movie;
      }else{
        return movie.copyWith(imageData: null);
      }
    });
  }

  Future<void> saveMovies(List<Movie> movies) async {
    final dao = MovieDao();
    final dbMovieList = await dao.getAllMovies();

    for (final movie in movies) {
      final dbMovie = dbMovieList
          .firstWhere((dbMovie) => dbMovie.id == movie.id,orElse: ()=> Movie(id: 0, originalTitle: null, overview: null, posterPath: null));
      if (dbMovie != null) {
        await dao.updateMovie(movie);
      } else {
        await dao.createMovie(movie);
      }
    }

    final db = await dbProvider.database;
    final batch = db.batch();

    for (final movie in movies) {
      batch.insert('movies', movie.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  Future<Movie?> getMovieById(int id) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Movie.fromJson(maps.first);
    }
    return null;
  }

  Future<int> updateMovie(Movie movie) async {
    final db = await dbProvider.database;
    return await db.update(
      'movies',
      movie.toJson(),
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> deleteMovie(int id) async {
    final db = await dbProvider.database;
    return await db.delete(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}

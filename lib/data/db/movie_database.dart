import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase{
  static final MovieDatabase instance = MovieDatabase._init();

  static Database? _database;

  MovieDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('movie.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);}
  Future<void> _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE movies(id INTEGER PRIMARY KEY,original_title TEXT,overview TEXT,poster_path TEXT,imageData BLOB)'
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final Dio dio = Dio();

class Movie {
  final int id;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  late Uint8List? imageData;

  Movie({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    this.imageData,
  });

  Future<void> downloadImage(int id) async {
    final localFile = await _getLocalFile(id);
    if (await localFile.exists()) {
      // Image has already been downloaded.
      imageData = await localFile.readAsBytes();
      return;
    }
    if (imageData != null) {
      // Image has already been downloaded.
      return;
    }
    try {
      final response = await dio.get(
          'https://image.tmdb.org/t/p/w500$posterPath',
          options: Options(responseType: ResponseType.bytes));

      imageData = Uint8List.fromList(response.data);
      final file = await _getLocalFile(id);
      await file.writeAsBytes(imageData!);
    } catch (e) {
      throw Exception('Failed to download image.');
    }
  }

  Future<File> _getLocalFile(int id) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, '${id}_poster.png');
    return File(path);
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      imageData: json['imageData'] != null
          ? Uint8List.fromList(json['imageData'].cast<int>())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'imageData': imageData?.toList(),
    };
  }

  Movie copyWith({
    int? id,
    String? originalTitle,
    String? overview,
    String? posterPath,
    Uint8List? imageData,
  }) {
    return Movie(
      id: id ?? this.id,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      imageData: imageData ?? this.imageData,
    );
  }
}
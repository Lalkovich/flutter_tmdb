class Movie {
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;

  const Movie({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath
});

  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
      id: json['id'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }

}

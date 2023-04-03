import 'package:flutter/material.dart';
import 'package:flutter_tmdb/data/models/movie.dart';
import 'package:flutter_tmdb/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb/ui/movie_details/movie_details.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({Key? key, required this.movie}) : super(key: key);

  final Movie movie;
  static const baseImageUrl = 'https://image.tmdb.org/t/p/w92/';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final movieBloc = locator.get<MovieBloc>();
    return ListTile(
      leading: Container(
        width: 48.0,
        height: 48.0,
        child: movie.imageData != null ?
            Image.memory(movie.imageData!):
        Image.network(baseImageUrl + movie.posterPath.toString()),
      ),
      title: Text(
        movie.originalTitle as String,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => movieBloc,
                  child: MovieDetailsScreen(movieId: movie.id),
                )));
      },
    );
  }
}

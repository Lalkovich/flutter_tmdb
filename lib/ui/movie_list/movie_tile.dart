import 'package:flutter/material.dart';
import 'package:flutter_tmdb/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb/ui/movie_details/movie_details.dart';

class MovieTile extends StatelessWidget{
  const MovieTile({
    Key? key,
    required this.movie
}) : super(key: key);

    final dynamic movie;
    static const baseImageUrl = 'https://image.tmdb.org/t/p/w92/';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final movieBloc = locator.get<MovieBloc>();
    return ListTile(
      leading: Image.network(baseImageUrl+movie.posterPath),
      title:Text(
        movie.originalTitle,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.arrow_forward),
    onTap: (){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => BlocProvider(
          create:(context) => movieBloc,
          child:MovieDetailsScreen(movieId: movie.id),
        ))
      );
    },
    );
  }

}
import 'package:flutter/material.dart';

import '../bloc/movies_provider.dart';
import '../models/movie_item.dart';
import '../widgets/movie_screen/actor_list.dart';
import '../widgets/movie_screen/header.dart';
import '../widgets/movie_screen/overview.dart';
import '../widgets/movie_screen/rate.dart';
import '../widgets/movie_screen/trailer.dart';

class MovieScreen extends StatelessWidget {
  final MovieItem movieData;
  MovieScreen(this.movieData);
  @override
  Widget build(BuildContext context) {
    MoviesBloc _bloc = MoviesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(movieData.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            header(movieData),
            overview(movieData.overview, movieData.releaseDate),
            trailer(movieData.id, _bloc),
            rate(movieData.voteAverage, movieData.voteCount),
            Divider(
              thickness: 1,
              height: 10,
            ),
            actorsList(movieData.id, _bloc),
          ],
        ),
      ),
    );
  }
}

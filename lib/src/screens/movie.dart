import 'package:flutter/material.dart';
import 'package:movie_app/src/bloc/movies_provider.dart';
import 'package:movie_app/src/models/movie_item.dart';
import 'package:movie_app/src/widgets/movie_screen/actor_list.dart';
import 'package:movie_app/src/widgets/movie_screen/header.dart';
import 'package:movie_app/src/widgets/movie_screen/overview.dart';
import 'package:movie_app/src/widgets/movie_screen/rate.dart';
import 'package:movie_app/src/widgets/movie_screen/trailer.dart';

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

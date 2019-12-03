import 'package:flutter/material.dart';
import 'package:movie_app/src/widgets/movie_screen/youtube_player.dart';

import '../bloc/movies_provider.dart';
import '../models/movie_item.dart';
import '../widgets/movie_screen/actor_list.dart';
import '../widgets/movie_screen/header.dart';
import '../widgets/movie_screen/overview.dart';
import '../widgets/movie_screen/rate.dart';

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
            Header(movieData),
            Overview(movieData.overview, movieData.releaseDate),
            YouTubeWidget(movieData.id, _bloc),
            Rate(movieData.voteAverage, movieData.voteCount),
            Divider(
              thickness: 1,
              height: 10,
            ),
            ActorList(movieData.id, _bloc),
          ],
        ),
      ),
    );
  }
}

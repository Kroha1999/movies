import 'package:flutter/material.dart';
import 'package:movie_app/src/bloc/movies_bloc.dart';
import 'package:youtube_player/youtube_player.dart';

Widget trailer(int id, MoviesBloc bloc) {
  return Container(
    child: StreamBuilder(
      stream: bloc.movieTrailer(id),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return YoutubePlayer(
          reactToOrientationChange: false,
          showVideoProgressbar: false,
          startAt: Duration.zero,
          autoPlay: false,
          context: context,
          source: snapshot.data,
          quality: YoutubeQuality.MEDIUM,
        );
      },
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:movie_app/src/bloc/movies_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
 
Widget trailer(int id, MoviesBloc bloc) {
  return Container(
    child: StreamBuilder(
      stream: bloc.movieTrailer(id),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        YoutubePlayerController _controller = YoutubePlayerController(
            initialVideoId: snapshot.data,
            flags: YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
        );
        return YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
        );
      },
    ),
  );
 }  
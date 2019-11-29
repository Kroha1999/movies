import 'package:flutter/material.dart';
import 'package:movie_app/src/bloc/movies_bloc.dart';
import 'package:movie_app/src/widgets/movie_screen/actor_view.dart';

Widget actorsList(int id, MoviesBloc bloc) {
  return Container(
    height: 290,
    //width: 100,
    child: StreamBuilder(
      stream: bloc.movieActors(id),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return ActorView(snapshot.data[index]);
          },
        );
      },
    ),
  );
}

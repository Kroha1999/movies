import 'package:flutter/material.dart';

import '../../bloc/movies_bloc.dart';
import '../../widgets/movie_screen/actor_view.dart';

Widget actorsList(int id, MoviesBloc bloc) {
  return Container(
    height: 290,
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

import 'package:flutter/material.dart';

import '../../bloc/movies_bloc.dart';
import '../../widgets/movie_screen/actor_view.dart';

class ActorList extends StatelessWidget {
  final int id;
  final MoviesBloc bloc;
  ActorList(this.id, this.bloc);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.movieActors(id),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return Container(
          height: 290,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ActorView(snapshot.data[index]);
            },
          ),
        );
      },
    );
  }
}

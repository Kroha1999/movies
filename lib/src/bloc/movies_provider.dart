import 'package:flutter/material.dart';

import 'movies_bloc.dart';

export 'movies_bloc.dart';

class MoviesProvider extends InheritedWidget {
  MoviesProvider({Key key, Widget child}) : super(key: key, child: child);

  final MoviesBloc bloc = MoviesBloc();

  static MoviesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MoviesProvider) as MoviesProvider).bloc;
  }

  @override
  bool updateShouldNotify(_) => true;
}

import 'package:flutter/material.dart';
import 'package:movie_app/src/widgets/search_delegate.dart';

import '../models/movies_type.dart';
import '../widgets/movies_list.dart';

class MoviesTabs extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Top rated'),
    Tab(text: 'Upcoming'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("MoviesApp"),
          bottom: TabBar(tabs: myTabs),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            MovieList(MoviesListType.topMovies),
            MovieList(MoviesListType.upcomingMovies),
          ],
        ),
      ),
    );
  }
}

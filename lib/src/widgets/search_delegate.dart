import 'package:flutter/material.dart';

import '../bloc/movies_provider.dart';
import '../widgets/search_list_tile.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Center(
        child: Text(
          "Search term must be longer than two letters.",
        ),
      );
    }
    MoviesBloc block = MoviesProvider.of(context);
    return StreamBuilder(
      stream: block.searchMovies(query),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              height: 45.0,
              width: 45.0,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.data.isEmpty) {
          return Center(
            child: Text(
              "No result found.",
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              return Column(
                children: <Widget>[
                  SearchMovieTile(
                    snapshot.data[index],
                  ),
                  Divider(height: 10,)
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}

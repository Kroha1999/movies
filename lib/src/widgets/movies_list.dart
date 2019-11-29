import 'package:flutter/material.dart';
import 'package:movie_app/src/bloc/movies_provider.dart';
import 'package:movie_app/src/models/movie_item.dart';
import 'package:movie_app/src/models/movies_type.dart';
import 'package:movie_app/src/widgets/movie_list_tile.dart';

class MovieList extends StatefulWidget {
  final MoviesListType type;
  MovieList(this.type);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  ScrollController _scrollController;
  MoviesBloc _bloc;

  //initializing bloc and setting listener to scroll
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    Future.delayed(Duration.zero,(){
      _bloc = MoviesProvider.of(context);
      _bloc.fetchMovies(widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = MoviesProvider.of(context);
    return StreamBuilder(
      stream: _bloc.movies(widget.type),
      builder: (context, AsyncSnapshot<List<MovieItem>> snapshot) {
        //If data was not fetched
        if (!snapshot.hasData) {
          return loaderIndicator(45.0, 45.0);
        }

        return ListView.builder(
          itemCount: snapshot.data.length + 1,
          controller: _scrollController,
          itemBuilder: (context, int index) {
            return index >= snapshot.data.length
                ? loaderIndicator(25.0, 25.0)
                : MovieTile(snapshot.data[index]);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _bloc.fetchMovies(widget.type);
    }
  }

  Widget loaderIndicator(x, y) {
    return Center(
        child:
            Container(width: x, height: y, child: CircularProgressIndicator()));
  }
}

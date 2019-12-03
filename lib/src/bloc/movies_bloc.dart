import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../bloc/movies_mixin.dart';
import '../models/movies_type.dart';
import '../repository/repository.dart';
import '../models/movie_item.dart';

class MoviesBloc with MoviesMixin {
  final _moviesTopList = <MovieItem>[];
  final _moviesUpList = <MovieItem>[];
  final _repository = Repository();
  final _moviesTop = StreamController<List<MovieItem>>.broadcast();
  final _moviesUp = StreamController<List<MovieItem>>.broadcast();

  // Stream of MovieItems lists
  get movies => _defineStream;
  // Stream that provides data about actor requires movie [id]
  get movieActors => _getActors;
  // Stream of List<MovieItem> found by [query]
  get searchMovies => _searchMovies;
  // Future YouTube video id by movie [id] 
  Future<String> Function(int) get movieTrailerFuture => _getTrailerFuture;

  // Defines which stream to provide
  Stream<List<MovieItem>> _defineStream(MoviesListType type) {
    if (type == MoviesListType.topMovies) {
      return _moviesTop.stream;
    } else {
      return _moviesUp.stream;
    }
  }

  // Fetches new movies data depending on [type] of list
  fetchMovies(MoviesListType type) async {
    if (type == MoviesListType.topMovies) {
      final List<MovieItem> moviesPage = await _repository.fetchTopMovies();
      if (moviesPage == null) return;
      _moviesTopList.addAll(moviesPage);
      _moviesTop.sink.add(_moviesTopList);
    } else {
      final List<MovieItem> moviesPage =
          await _repository.fetchUpcomingMovies();
      if (moviesPage == null) return;
      _moviesUpList.addAll(moviesPage);
      _moviesUp.sink.add(_moviesUpList);
    }
  }
  
  // Stream of List<MovieItem> found by [query]
  Stream<List<MovieItem>> _searchMovies(String query){
    return _repository.searchMovies(query).asStream();
  }

  // Stream transformation in order to get top 10 actors of curent film by movie [id]
  Stream<List> _getActors(int id) {
    return _repository.getActors(id).transform(toActors);
  }

  // Transformer which tramsnsforms the response and returns YouTube String [id] or null
  Future<String> _getTrailerFuture(int id) async{
    Response response = await _repository.getVideoFuture(id);
    if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if(data['results'].length == 0) return null;
        if (data['results'][0]['site'] == 'YouTube') {
          if(data['results'][0]['key']=='' || data['results'][0]['key']==null){
            return null;
          }
          return(data['results'][0]['key'].toString());
        }
        return null;
      }
      return null;
  }

  dispose() {
    _moviesUp.close();
    _moviesTop.close();
  }
}

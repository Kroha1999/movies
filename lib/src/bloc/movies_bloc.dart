import 'dart:async';

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

  // Stream that provides data about trailer requires movie [id]
  get movieTrailer => _getTrailer;
  // Stream that provides data about actor requires movie [id]
  get movieActors => _getActors;

  // Stream transformation in order to get YouTube video id by movie [id] 
  Stream<String> _getTrailer(int id) {
    return _repository.getVideo(id).transform(toTrailer);
  }

  // Stream transformation in order to get top 10 actors of curent film by movie [id]
  Stream<List> _getActors(int id) {
    return _repository.getActors(id).transform(toActors);
  }

  dispose() {
    _moviesUp.close();
    _moviesTop.close();
  }
}

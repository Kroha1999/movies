import 'dart:async';
import 'package:movie_app/src/bloc/movies_mixin.dart';
import 'package:movie_app/src/models/movies_type.dart';
import 'package:movie_app/src/repository/repository.dart';
import '../models/movie_item.dart';

class MoviesBloc with MoviesMixin {
  final _moviesTopList = <MovieItem>[];
  final _moviesUpList = <MovieItem>[];
  final _repository = Repository();
  final _moviesTop = StreamController<List<MovieItem>>.broadcast();
  final _moviesUp = StreamController<List<MovieItem>>.broadcast();

  //Stream provider
  get movies => _defineStream;

  //function that defines which stream to provide
  Stream<List<MovieItem>> _defineStream(MoviesListType type) {
    if (type == MoviesListType.topMovies)
      return _moviesTop.stream;
    else
      return _moviesUp.stream;
  }

  //fetches new movies data
  fetchMovies(MoviesListType type) async {
    if (type == MoviesListType.topMovies) {
      final List<MovieItem> moviesPage = 
          await _repository.fetchTopMovies();
      if(moviesPage == null) return;
      _moviesTopList.addAll(moviesPage);
      _moviesTop.sink.add(_moviesTopList);
    } else {
      final List<MovieItem> moviesPage =
          await _repository.fetchUpcomingMovies();
      if(moviesPage == null) return;
      _moviesUpList.addAll(moviesPage);
      _moviesUp.sink.add(_moviesUpList);
    }
  }

  ///////////////////////////////////////////////////
  get movieTrailer => _getTrailer;
  get movieActors => _getActors;

  Stream<String> _getTrailer(int id){
    return _repository.getVideo(id).transform(toTrailer);
  }

  Stream<List> _getActors(int id){
    return _repository.getActors(id).transform(toActors);
  }

  dispose() {
    _moviesUp.close();
    _moviesTop.close();
  }
}

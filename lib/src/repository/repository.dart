import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:movie_app/src/models/movie_item.dart';

class Repository {
  final Client _client = Client();

  final String _root = 'https://api.themoviedb.org/3/movie';
  final String _topRated = '/top_rated';
  final String _upcoming = '/upcoming';
  final String _key = '8aef39947e80e042b305cf5dab20703c';

  int _topPage = 0;
  int _upcomingPage = 0;

  //Fetches top movies on specific page
  Future<dynamic> fetchTopMovies() {
    _topPage += 1;
    return _client
        .get("$_root$_topRated?api_key=$_key&page=$_topPage")
        .then(responceHandler);
  }

  //fetches upcoming movies on specific page
  Future<dynamic> fetchUpcomingMovies() {
    _upcomingPage += 1;
    return _client
        .get("$_root$_upcoming?api_key=$_key&page=$_upcomingPage")
        .then(responceHandler);
  }

  // converts received data to MovieItem model
  List<MovieItem> responceHandler(Response responce) {
    if (responce.statusCode == 200) {
      List<dynamic> jsonsList = json.decode(responce.body)['results'];
      return jsonsList.map((jsonVal) => MovieItem.fromJson(jsonVal)).toList();
    } else
      return null;
  }

  // get trailer for specific movie
  Stream getVideo(int id) {
    return _client.get("$_root/$id/videos?api_key=$_key").asStream();
  }

  // get actors for specific movie
  Stream getActors(int id) {
    return _client.get("$_root/$id/credits?api_key=$_key").asStream();
  }
}

import 'dart:convert';

import 'package:http/http.dart' show Client, Response;

import '../models/movie_item.dart';

class Repository {
  final Client _client = Client();

  final String _root = 'https://api.themoviedb.org/3';
  final String _topRated = '/movie/top_rated';
  final String _upcoming = '/movie/upcoming';
  final String _key = '8aef39947e80e042b305cf5dab20703c';

  int _topPage = 0;
  int _upcomingPage = 0;

  // Fetches top movies on specific page
  Future<List<MovieItem>> fetchTopMovies() {
    _topPage += 1;
    return _client
        .get("$_root$_topRated?api_key=$_key&page=$_topPage")
        .then(responceHandler);
  }

  // Fetches upcoming movies on specific page
  Future<List<MovieItem>> fetchUpcomingMovies() {
    _upcomingPage += 1;
    return _client
        .get("$_root$_upcoming?api_key=$_key&page=$_upcomingPage")
        .then(responceHandler);
  }

  // Converts received data to MovieItem model
  List<MovieItem> responceHandler(Response responce) {
    if (responce.statusCode == 200) {
      List<dynamic> jsonsList = json.decode(responce.body)['results'];
      return jsonsList.map((jsonVal) => MovieItem.fromJson(jsonVal)).toList();
    } else
      return null;
  }

  // Gets trailer for specific movie by [id]
  Stream getVideo(int id) {
    return _client.get("$_root/movie/$id/videos?api_key=$_key").asStream();
  }

  // Gets actors for specific movie by [id]
  Stream getActors(int id) {
    return _client.get("$_root/movie/$id/credits?api_key=$_key").asStream();
  }

  // Looks up movies with a specific [query]
  Future<List<MovieItem>> searchMovies(String query) {
    return _client
        .get("$_root/search/movie?api_key=$_key&query=$query&include_adult=true")
        .then(responceHandler);
  }
}

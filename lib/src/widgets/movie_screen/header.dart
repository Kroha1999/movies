import 'package:flutter/material.dart';
import 'package:movie_app/src/models/movie_item.dart';

Widget header(MovieItem movieData) {
  return Hero(
    tag: movieData.id,
    child: Container(
      height: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: Image.network(movieData.backdropPath != null
                ? "http://image.tmdb.org/t/p/w342/${movieData.backdropPath}"
                : 'http://image.tmdb.org/t/p/w342/${movieData.posterPath}')
            .image,
        fit: BoxFit.cover,
      )),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black87, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Stack(
          children: <Widget>[
            //poster
            Positioned(
              bottom: 13,
              left: 10,
              child: headerPoster(movieData.posterPath),
            ),
            //title and genres
            Positioned(
              bottom: 13,
              left: 80,
              child: headerText(movieData.title, movieData.genres),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget headerPoster(String posterPath) {
  return Container(
    height: 100,
    child: Image.network('http://image.tmdb.org/t/p/w185/$posterPath'),
  );
}

Widget headerText(String title, List<String> genres) {
  //geners to String
  String genresStr = '';
  for (String el in genres) {
    if (el == genres[0])
      genresStr += el;
    else
      genresStr += ", $el";
  }
  return Material(
      animationDuration: Duration(seconds: 5),
      type: MaterialType.transparency,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 320,
            child: Text(
              title,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 320,
            child: Text(
              genresStr,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ));
}
import 'package:flutter/material.dart';

import '../../models/movie_item.dart';

class Header extends StatelessWidget {
  final MovieItem movieData;
  Header(this.movieData);
  @override
  Widget build(BuildContext context) {
    Image backdrop = movieData.backdropPath != null
        ? Image.network(
            'http://image.tmdb.org/t/p/w342/${movieData.backdropPath}')
        : movieData.posterPath != null
            ? Image.network(
                'http://image.tmdb.org/t/p/w342/${movieData.posterPath}')
            : Image.asset('assets/images/noposter.jpg');
    Image poster = movieData.posterPath != null
        ? Image.network(
            'http://image.tmdb.org/t/p/w185/${movieData.posterPath}')
        : Image.asset('assets/images/noposter.jpg');
    return Hero(
      tag: movieData.id,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backdrop.image,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Stack(
            children: <Widget>[
              //poster
              Positioned(
                bottom: 13,
                left: 10,
                child: Container(
                  height: 100,
                  child: poster,
                ),
              ),
              //title and genres
              Positioned(
                bottom: 13,
                left: 85,
                child: HeaderText(movieData.title, movieData.genres),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final String title;
  final List<String> genres;
  HeaderText(this.title, this.genres);
  @override
  Widget build(BuildContext context) {
    //geners to String
    String genresStr = '';
    for (String el in genres) {
      if (el == genres[0]) {
        genresStr += el;
      } else {
        genresStr += ", $el";
      }
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
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 320,
            child: Text(
              genresStr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

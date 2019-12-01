import 'package:flutter/material.dart';

import '../models/movie_item.dart';
import '../screens/movie.dart';

class MovieTile extends StatelessWidget {
  final MovieItem movieData;
  MovieTile(this.movieData);

  @override
  Widget build(BuildContext context) {
    Image backdrop = movieData.backdropPath != null
        ? Image.network(
            'http://image.tmdb.org/t/p/w342/${movieData.backdropPath}')
        : movieData.posterPath != null
            ? Image.network(
                'http://image.tmdb.org/t/p/w342/${movieData.posterPath}')
            : Image.asset('assets/images/noposter.jpg');
    return GestureDetector(
      onTap: () {
        //Moving to next route
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MovieScreen(movieData)));
      },
      child: Hero(
        tag: movieData.id,
        child: Container(
          height: 190,
          // Image
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            image: DecorationImage(image: backdrop.image, fit: BoxFit.cover),
          ),
          // Half opacity shadow
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
                stops: [0, 0.4],
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Stack(
                // Title
                children: <Widget>[
                  Positioned(
                    bottom: 13,
                    left: 13,
                    child: Container(
                      width: 340,
                      child: Text(
                        movieData.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //Rate
                  Positioned(
                    bottom: 40,
                    left: 13,
                    child: Row(
                      children: <Widget>[
                        Text(
                          movieData.voteCount == null || movieData.voteCount == 0
                              ? "Not rated "
                              : '${movieData.voteAverage} ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

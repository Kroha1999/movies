import 'package:flutter/material.dart';

import '../models/movie_item.dart';
import '../screens/movie.dart';

class SearchMovieTile extends StatelessWidget {
  final MovieItem movieData;
  SearchMovieTile(this.movieData);

  @override
  Widget build(BuildContext context) {
    Image poster = movieData.posterPath == null
        ? Image.asset('assets/images/noposter.jpg')
        : Image.network("http://image.tmdb.org/t/p/w92/${movieData.posterPath}");
    return GestureDetector(
      onTap: () {
        //Moving to next route
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MovieScreen(movieData)));
      },
      child: Hero(
        tag: movieData.id,
        child: Container(
          height: 110,
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: <Widget>[
                //Poster
                Positioned(
                  bottom: 5,
                  left: 13,
                  child: Container(
                    height: 100,
                    width: 65,
                    child: poster,
                  ),
                ),
                // Title
                Positioned(
                  bottom: 47,
                  left: 83,
                  child: Container(
                    width: 275,
                    child: Text(
                      movieData.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                //Rate
                Positioned(
                  bottom: 73,
                  left: 83,
                  child: Row(
                    children: <Widget>[
                      Text(
                        movieData.voteCount == null || movieData.voteCount == 0
                            ? "Not rated "
                            : '${movieData.voteAverage} ',
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 83,
                  child: Container(
                    width: 295,
                    height: 40,
                    child: Text(
                      movieData.overview,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

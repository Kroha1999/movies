import 'package:flutter/material.dart';
import 'package:movie_app/src/models/movie_item.dart';
import 'package:movie_app/src/screens/movie.dart';

class MovieTile extends StatelessWidget {
  final MovieItem movieData;
  MovieTile(this.movieData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Moving to next royte
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
            image: DecorationImage(
                image: Image.network(movieData.backdropPath != null
                        ? 'http://image.tmdb.org/t/p/w342/${movieData.backdropPath}'
                        : 'http://image.tmdb.org/t/p/w342/${movieData.posterPath}')
                    .image,
                fit: BoxFit.cover),
          ),
          // Half opacity shadow
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight,
                  stops: [0, 0.4],
                  colors: [Colors.black54, Colors.transparent]),
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
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  //Rate
                  Positioned(
                    bottom: 40,
                    left: 13,
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${movieData.voteAverage}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.star, color: Colors.yellow[400], size: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

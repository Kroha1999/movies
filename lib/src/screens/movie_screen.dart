import 'package:flutter/material.dart';
import 'package:movie_app/src/bloc/movies_provider.dart';
import 'package:movie_app/src/models/movie_item.dart';
import 'package:movie_app/src/widgets/actor_view.dart';
import 'package:youtube_player/youtube_player.dart';

class MovieScreen extends StatelessWidget {
  final MovieItem movieData;
  MovieScreen(this.movieData);
  @override
  Widget build(BuildContext context) {
    MoviesBloc _bloc = MoviesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(movieData.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            header(movieData),
            overview(movieData.overview,movieData.releaseDate),
            trailer(movieData.id, _bloc),
            rate(movieData.voteAverage, movieData.voteCount),
            Divider(
              thickness: 1,
              height: 10,
            ),
            actorsList(movieData.id,_bloc),
          ],
        ),
      ),
    );
  }

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

  Widget overview(String overview, String release) {
    return Container(
      margin: EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Overview",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Expanded(child: Container(),),
              Text(
                "Release: $release",
                style: TextStyle(fontStyle: FontStyle.italic,color:Colors.grey, fontSize: 12),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          Text(
            overview,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  Widget rate(double average, int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            average.toString(),
            style: TextStyle(fontSize: 40),
          ),
        ),
        Icon(
          Icons.star,
          color: Colors.amberAccent,
          size: 46,
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 13, 10, 0),
          child: Text("$total voted", style: TextStyle(fontSize: 25)),
        ),
      ],
    );
  }

  Widget trailer(int id, MoviesBloc bloc) {
    return Container(
      child: StreamBuilder(
        stream: bloc.movieTrailer(id),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return YoutubePlayer(
            reactToOrientationChange: false,
            showVideoProgressbar: false,
            startAt: Duration.zero,
            autoPlay: false,
            context: context,
            source: snapshot.data,
            quality: YoutubeQuality.MEDIUM,
          );
        },
      ),
    );
  }

  Widget actorsList(int id, MoviesBloc bloc){
    return Container(
      height: 290,
      //width: 100,
      child: StreamBuilder(
        stream: bloc.movieActors(id),
        builder: (context,AsyncSnapshot<List> snapshot){
          if(!snapshot.hasData){
            return Container();
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
            return ActorView(snapshot.data[index]);
           },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/src/models/actor.dart';

class ActorView extends StatelessWidget {
  final Actor actor;

  ActorView(this.actor);

  @override
  Widget build(BuildContext context) {
    return actor.photoPath == null
        ? Container()
        : Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              image: DecorationImage(
                  image: Image.network(
                          'http://image.tmdb.org/t/p/w154/${actor.photoPath}')
                      .image,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth),
            ),
            //Name and character's name from the film
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    actor.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  color: Colors.white,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Text(
                    actor.character,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(bottom: 8.0),)
              ],
            ),
          );
  }
}

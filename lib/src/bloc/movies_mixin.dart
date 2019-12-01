import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Response;

import '../models/actor.dart';

class MoviesMixin {
  // Converts responce from the web and filtering data for YouTube video identificator
  final toTrailer = StreamTransformer<Response, String>.fromHandlers(
    handleData: (responce, sink) {
      if (responce.statusCode == 200) {
        Map<String, dynamic> data = json.decode(responce.body);
        if (data['results'][0]['site'] == 'YouTube') {
          sink.add(data['results'][0]['key'].toString());
        }
        return 0;
      }
      return null;
    },
  );

  // Converts responce from the web to List of actors
  final toActors = StreamTransformer<Response, List<Actor>>.fromHandlers(
    handleData: (responce, sink) {
      if (responce.statusCode == 200) {
        Map<String, dynamic> data = json.decode(responce.body);
        List<dynamic> actorsMaps = data['cast'].getRange(0, 10).toList();
        List<Actor> actors = actorsMaps
            .map((map) =>
                Actor(map['character'], map['name'], map['profile_path']))
            .toList();
        sink.add(actors);
        return 0;
      }
      return null;
    },
  );
}

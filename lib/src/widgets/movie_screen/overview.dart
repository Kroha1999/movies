import 'package:flutter/material.dart';

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
            Expanded(
              child: Container(),
            ),
            Text(
              "Release: $release",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                  fontSize: 12),
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

import 'package:flutter/material.dart';

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

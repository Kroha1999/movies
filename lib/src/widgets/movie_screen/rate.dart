import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  final double average;
  final int total;
  Rate(this.average, this.total);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            total == null || total == 0 ? "Not rated " : '$average ',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Icon(
          Icons.favorite,
          color: Colors.red,
          size: 40,
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Text("$total voted", style: TextStyle(fontSize: 25)),
        ),
      ],
    );
  }
}

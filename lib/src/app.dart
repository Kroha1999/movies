import 'package:flutter/material.dart';
import 'screens/category_tabs.dart';

import 'bloc/movies_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MoviesProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies app',
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.black,
          fontFamily: 'OpenSans',
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          ),
          cursorColor: Colors.red,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        home: MoviesTabs(),
      ),
    );
  }
}

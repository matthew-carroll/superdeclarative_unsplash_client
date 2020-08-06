import 'package:example/api_key.dart';
import 'package:flutter/material.dart';

import 'photo_details.dart';
import 'photo_list.dart';

// Place your Unsplash API key in a file called api_key.dart in a variable
// called "unsplashKey", or simply replace the following reference with your
// literal API key.
final String accessKey = unsplashKey;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Client',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.yellow,
        accentColor: Colors.yellow,
        cursorColor: Colors.yellow,
        textSelectionHandleColor: Colors.yellow,
      ),
      routes: {
        '/': (BuildContext context) => PhotoListScreen(
              accessKey: accessKey,
            ),
        'photo': (BuildContext context) => PhotoScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

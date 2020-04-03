import 'package:flutter/material.dart';

import 'photo_details.dart';
import 'photo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Grand Finale',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (BuildContext context) => PhotoListScreen(),
        'photo': (BuildContext context) => PhotoScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

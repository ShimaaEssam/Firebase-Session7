
import 'package:flutter/material.dart';

import 'messages/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
//firestore
//        home: HomePage(title: 'Home'),
    //cloud message
        home:MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

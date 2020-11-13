import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './pages/login_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        //change the color later
        primaryColor: Colors.blueGrey[900],
        accentColor: Colors.blueGrey[900],
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text("PINGER"),
      //   ),
      // ),

      //our home page
      home: LoginPage(),
    );
  }
}

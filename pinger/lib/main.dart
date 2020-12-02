import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinger/screen/authentication/login.dart';
import 'package:pinger/screen/authentication/signup.dart';
import 'package:pinger/screen/home.dart';
import 'package:pinger/services/navigation_service.dart';
import 'package:pinger/screen/authentication/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  double _height;
  double _width;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PINGER',
      navigatorKey: NavigationService.instance.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "login",
      routes: {
        "login": (BuildContext _context) => LoginPage(),
        "register": (BuildContext _context) => RegisterationPage(),
        "home": (BuildContext _context) => HomePage(),
        //TODO: work on
        "profileui": (BuildContext _context) => ProfilePage(1000, 1000),
      },
      // home: LoginPage(),
    );
  }
}

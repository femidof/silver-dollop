import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinger/screen/login.dart';
import 'package:pinger/screen/signup.dart';
import 'package:pinger/screen/registration.dart';
import 'package:pinger/services/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
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
      },
      //home: LoginPage(),
      home: RegisterationPage(),
    );
  }
}

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SignUpPage(),
          LoginPage(),
        ],
      ),
    );
  }
}

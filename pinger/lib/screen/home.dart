import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        title: Center(
          child: Shimmer.fromColors(
              child: Text(
                "Pinger",
                style: GoogleFonts.pacifico(fontSize: 28),
              ),
              baseColor: Colors.blueAccent,
              highlightColor: Colors.redAccent),
        ),
      ),
    );
  }
}

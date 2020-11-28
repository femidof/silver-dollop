import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pinger/screen/authentication/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _height;
  double _width;

  TabController _tabController;

  _HomePageState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;
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
        bottom: TabBar(
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(
                Icons.people_outline,
                size: 25,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 25,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.person_outline,
                size: 25,
              ),
            )
          ],
        ),
      ),
      body: _tabBarPages(),
    );
  }

  Widget _tabBarPages() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        ProfilePage(_height, _width),
        ProfilePage(_height, _width),
        ProfilePage(_height, _width),
      ],
    );
  }
}

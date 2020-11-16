import 'package:flutter/material.dart';
import 'package:pinger/screen/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  _HomePageState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        textTheme: TextTheme(
          title: TextStyle(fontSize: 16),
        ),
        title: Text("Pinger"),
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
        ProfilePage(),
        ProfilePage(),
        ProfilePage(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pinger/services/db_service.dart';
import 'package:pinger/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:pinger/models/contact.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchPage extends StatefulWidget {
  double _height;
  double _width;

  SearchPage(this._height, this._width);

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  String _searchText;

  AuthProvider _auth;

  _SearchPageState() {
    _searchText = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance, child: _searchPageUI()),
      color: Colors.white,
    );
  }

  Widget _searchPageUI() {
    return Builder(
      builder: (BuildContext _context) {
        _auth = Provider.of<AuthProvider>(_context);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _userSearchField(),
            _usersListView(),
          ],
        );
      },
    );
  }

  Widget _userSearchField() {
    return Container(
      height: this.widget._height * .08,
      width: this.widget._width,
      padding: EdgeInsets.symmetric(vertical: this.widget._height * 0.02),
      child: TextField(
        autocorrect: false,
        style: TextStyle(color: Colors.black),
        onSubmitted: (_input) {
          setState(() {
            _searchText = _input;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          labelStyle: TextStyle(color: Colors.black),
          labelText: "Search user",
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _usersListView() {
    return StreamBuilder<List<Contact>>(
      stream: DBService.instance.getUsersInDB(_searchText),
      builder: (_context, _snapshot) {
        var _usersData = _snapshot.data;
        if (_usersData != null) {
          _usersData.removeWhere((_contact) => _contact.id == _auth.user.uid);
        }
        return _snapshot.hasData
            ? Container(
                height: this.widget._height * 0.75,
                child: ListView.builder(
                  itemCount: _usersData.length,
                  itemBuilder: (BuildContext _context, int _index) {
                    var _userData = _usersData[_index];
                    var _currentTime = DateTime.now();
                    //TODO: work on this gave a 'to date was called on null error'.

                    // var _isUserActive = !_userData.lastseen.toDate().isBefore(
                    //       _currentTime.subtract(
                    //         Duration(
                    //           hours: 1,
                    //         ),
                    //       ),
                    //     );

                    // print("userdata");
                    // print(_userData);
                    // print("userData.lastseen");
                    // print(_userData.lastseen);
                    // print("userData.lastseen.todate");
                    // print(_userData.lastseen.toDate());
                    // print("userData.lastseen.todate.is before");
                    // print(_userData.lastseen.toDate().isBefore);

                    return ListTile(
                      // title: Text("Tolu "),
                      title: Text(_userData.name),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(_userData.image),
                          ),
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          //TODO: wot
                          // _isUserActive
                          //     ? Text(
                          //         "Active now",
                          //         style: TextStyle(fontSize: 15),
                          //       )
                          //     : Text(
                          //         "Last Seen",
                          //         style: TextStyle(fontSize: 15),
                          //       ),
                          // _isUserActive
                          //     ? Container(
                          //         height: 10,
                          //         width: 10,
                          //         decoration: BoxDecoration(
                          //           color: Colors.green,
                          //           borderRadius: BorderRadius.circular(100),
                          //         ),
                          //       )
                          //     : Text(
                          //         timeago.format(
                          //           _userData.lastseen.toDate(),
                          //         ),
                          //         // "About an hour ago",
                          //         style: TextStyle(fontSize: 15),
                          //       ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : SpinKitWanderingCubes(
                color: Colors.blue,
                size: 50,
              );
        ;
      },
    );
  }
}

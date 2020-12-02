// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinger/models/conversation.dart';
import 'package:provider/provider.dart';
import 'package:pinger/auth/auth.dart';
import 'package:pinger/services/db_service.dart';
// import 'package:timeago/timeago.dart' as timeago;
import 'package:pinger/services/navigation_service.dart';
import 'package:pinger/screen/authentication/conversation_page.dart';

class RecentConversationsPage extends StatelessWidget {
  final double _height;
  final double _width;

  RecentConversationsPage(this._height, this._width);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _conversationsListViewWidget(),
      ),
    );
  }

  Widget _conversationsListViewWidget() {
    return Builder(
      builder: (BuildContext _context) {
        var _auth = Provider.of<AuthProvider>(_context);
        return Container(
            height: _height,
            width: _width,
            child: StreamBuilder<List<ConversationSnippet>>(
              stream: DBService.instance.getUserConversations(_auth.user.uid),
              builder: (_context, _snapshot) {
                var _data = _snapshot.data;

                // print("getting User Conversationsssssss${_snapshot.data}");

                //TODO: WORK ON THAT
                return _snapshot.hasData
                    ? ListView.builder(
                        // itemCount: 1,
                        //TODO: work on that
                        itemCount: _data.length,
                        itemBuilder: (_context, _index) {
                          return ListTile(
                            onTap: () {
                              NavigationService.instance.navigateToRoute(
                                MaterialPageRoute(
                                  builder: (BuildContext _context) {
                                    return ConversationPage(
                                        _data[_index].conversationID,
                                        _data[_index].id,
                                        _data[_index].name,
                                        _data[_index].image);
                                  },
                                ),
                              );
                            },
                            // title: Text("Tolu"),
                            //TODO: WORK ON THAT
                            title: Text(_data[_index].name),
                            // subtitle: Text("Subtite"),
                            subtitle: Text(_data[_index].lastMessage),
                            tileColor: Colors
                                .white, //TODO: maybe change that color some where else
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  // image: NetworkImage(
                                  //     "https://i.pravatar.cc/150?img=3"),
                                  //TODO: work on that
                                  image: NetworkImage(_data[_index].image),
                                ),
                              ),
                            ),
                            trailing: _listTileTrailingWidgets(),

                            // _listTileTrailingWidgets(_data[_index].timestamp),
                          );
                        },
                      )
                    : SpinKitWanderingCubes(
                        color: Colors.white,
                        size: 50,
                      );
              },
            ));
      },
    );
  }

//TODO: WOT
  // Widget _listTileTrailingWidgets(Timestamp _lastMessagetimestamp) {
  Widget _listTileTrailingWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          //TODO: WORK ON THAT
          //timeago.format(_lastMessagetimestamp.toDate()),
          "Lastseen",
          style: TextStyle(fontSize: 15),
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(100),
          ),
        )
      ],
    );
  }
}

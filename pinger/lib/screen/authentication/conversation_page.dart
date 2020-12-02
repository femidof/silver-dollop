import 'package:flutter/material.dart';
import 'package:pinger/services/db_service.dart';
import 'package:pinger/models/conversation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pinger/auth/auth.dart';
import 'package:pinger/models/message.dart';

class ConversationPage extends StatefulWidget {
  String _conversationID;
  String _receiverID;
  String _receiverImage;
  String _receivername;

  ConversationPage(this._conversationID, this._receiverID, this._receivername,
      this._receiverImage);
  @override
  State<StatefulWidget> createState() {
    return _ConversationPageState();
  }
}

class _ConversationPageState extends State<ConversationPage> {
  double _deviceHeight;
  double _deviceWidth;

  AuthProvider _auth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //TODO: Error. Range error index. invalid value
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(this.widget._receivername),
      ),
      body: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _conversatioinPageUI(),
      ),
    );
  }

  Widget _conversatioinPageUI() {
    return Builder(
      builder: (BuildContext _context) {
        _auth = Provider.of<AuthProvider>(_context);
        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            _messageListView(),
          ],
        );
      },
    );
  }

  Widget _messageListView() {
    return Container(
      height: _deviceHeight * .75,
      width: _deviceWidth,
      child: StreamBuilder<Conversation>(
        stream: DBService.instance.getConversation(this.widget._conversationID),
        builder: (BuildContext _context, _snapshot) {
          var _conversationData = _snapshot.data;
          if (_conversationData != null) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: _conversationData.messages.length,
              itemBuilder: (BuildContext _context, int _index) {
                var _message = _conversationData.messages[_index];
                bool _isOwnMessage = _message.senderID ==
                    _auth.user.uid; //to tell who own the message
                return _messageListViewChild(_isOwnMessage, _message);
              },
            );
          } else {
            return SpinKitWanderingCubes(
              color: Colors.white,
              size: 50,
            );
          }
        },
      ),
    );
  }

  Widget _messageListViewChild(bool _isOwnMessage, Message _message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            _isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          !_isOwnMessage ? _userImageWidget() : Container(),
          _textMessageBubble(_isOwnMessage, _message.content),
        ],
      ),
    );
  }

  Widget _userImageWidget() {
    double _imageRadius = _deviceHeight * 0.05;

    return Container(
      height: _imageRadius,
      width: _imageRadius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(this.widget._receiverImage),
        ),
      ),
    );
  }

  Widget _textMessageBubble(bool _isOwnMessage, String _message) {
    List<Color> _colorScheme = _isOwnMessage
        ? [Colors.blue, Color.fromRGBO(42, 117, 188, 1)]
        : [Color.fromRGBO(69, 69, 69, 1), Color.fromRGBO(43, 43, 43, 1)];
    return Container(
      height: _deviceHeight * 0.10,
      width: _deviceWidth * 0.75,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: _colorScheme,
          stops: [.3, .7],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text(_message)],
      ),
    );
  }
}

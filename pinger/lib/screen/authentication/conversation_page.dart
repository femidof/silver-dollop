import 'package:flutter/material.dart';
import 'package:pinger/services/db_service.dart';
import 'package:pinger/models/conversation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      body: _conversatioinPageUI(),
    );
  }

  Widget _conversatioinPageUI() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        _messageListView(),
      ],
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
              itemCount: _conversationData.messages.length,
              itemBuilder: (BuildContext _context, int _index) {
                var _message = _conversationData.messages[_index];
                return _textMessageBubble(true, _message.content);
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

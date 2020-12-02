import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: Error. Range error index. invalid value
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(this.widget._receivername),
      ),
    );
  }
}

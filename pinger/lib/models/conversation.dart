import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinger/models/message.dart';

class ConversationSnippet {
  final String id;
  final String chatID;
  final String image;
  final String lastMessage;
  final String name;
  final int unseenCount;
  final Timestamp timestamp;

  ConversationSnippet(
      {this.chatID,
      this.id,
      this.lastMessage,
      this.unseenCount,
      this.timestamp,
      this.name,
      this.image});

  factory ConversationSnippet.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data();

    return ConversationSnippet(
      id: _snapshot.id,
      chatID: _data["chatID"],
      lastMessage: _data["lastMessage"] != null ? _data["lastMessage"] : "",
      unseenCount: _data["unseenCount"],
      timestamp: _data["timestamp"],
      name: _data["name"],
      image: _data["image"],
    );
  }
}

class Conversation {
  final String id;
  final List members;
  final List<Message> messages;
  final String ownerID;

  Conversation({this.id, this.members, this.ownerID, this.messages});

  factory Conversation.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data();
    List _messages = _data["messages"];
    if (_messages != null) {
      _messages = _messages.map(
        (_m) {
          var _messageType =
              _m["type"] == "text" ? MessageType.Text : MessageType.Image;
          return Message(
              senderID: _m["senderID"],
              content: _m["message"],
              timestamp: _m["timestamp"],
              type: _messageType);
        },
      ).toList();
    } else {
      _messages = null;
    }
    return Conversation(
        id: _snapshot.documentID,
        members: _data["members"],
        ownerID: _data["ownerID"],
        messages: _messages);
  }
}
